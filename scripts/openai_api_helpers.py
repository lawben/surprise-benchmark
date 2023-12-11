# version: 2023-12-08-15-51 (reduced)

import functools
import json
import os
import pathlib
import shutil
import time

import attrs
import openai
import tiktoken
import tqdm


########################################################################################################################
# OpenAI API helpers
########################################################################################################################

_openai_model_parameters = {
    "gpt-3.5-turbo-1106": {
        "name": "gpt-3.5-turbo-1106",
        "chat_or_completion": "chat",
        "max_rpm": 10000,
        "max_tpm": 1000000,
        "cost_per_input_token": 0.000001,
        "cost_per_output_token": 0.000002,
        "max_context": 4096,
        "additional_delay": 0.1,
        "additional_tokens_per_message": 10
    },
    "gpt-3.5-turbo-instruct.yaml": {
        "name": "gpt-3.5-turbo-instruct",
        "chat_or_completion": "completion",
        "max_rpm": 10000,
        "max_tpm": 1000000,
        "cost_per_input_token": 0.000001,
        "cost_per_output_token": 0.000002,
        "max_context": 4096,
        "additional_delay": 0.1,
        "additional_tokens_per_message": 10
    },
    "gpt-4": {
        "name": "gpt-4",
        "chat_or_completion": "chat",
        "max_rpm": 10000,
        "max_tpm": 150000,
        "cost_per_input_token": 0.00003,
        "cost_per_output_token": 0.00006,
        "max_context": 8192,
        "additional_delay": 0.1,
        "additional_tokens_per_message": 10
    },
    "gpt-4-32k": {
        "name": "gpt-4-32k",
        "chat_or_completion": "chat",
        "max_rpm": 10000,
        "max_tpm": 150000,
        "cost_per_input_token": 0.00006,
        "cost_per_output_token": 0.00012,
        "max_context": 32768,
        "additional_delay": 0.1,
        "additional_tokens_per_message": 10
    },
    "gpt-4-1106-preview": {
        "name": "gpt-4-1106-preview",
        "chat_or_completion": "chat",
        "max_rpm": 40,
        "max_tpm": 150000,
        "cost_per_input_token": 0.00001,
        "cost_per_output_token": 0.00003,
        "max_context": 128000,
        "additional_delay": 0.1,
        "additional_tokens_per_message": 10
    }
}


@attrs.define(slots=False)
class _Request:
    request: dict = attrs.field(init=True)
    response: dict | None = attrs.field(init=False)

    @functools.cached_property
    def model(self) -> str:
        if self.request is not None:
            return self.request["model"]
        elif self.response is not None:
            return self.response["model"]
        else:
            raise AssertionError("Missing request and response!")

    @functools.cached_property
    def model_params(self) -> dict:
        if self.model not in _openai_model_parameters.keys():
            raise AssertionError(f"Unknown model '{self.model}'!")
        return _openai_model_parameters[self.model]

    @functools.cached_property
    def approx_input_len(self) -> int:
        if self.request is None:
            raise AssertionError("Missing request!")

        encoding = tiktoken.encoding_for_model(self.model)

        if "messages" in self.request.keys():
            extra_tokens = self.model_params["additional_tokens_per_message"]
            return sum(len(encoding.encode(message["content"])) + extra_tokens for message in self.request["messages"])
        elif "prompt" in self.request.keys():
            return len(encoding.encode(self.request["prompt"]))
        else:
            raise ValueError("Invalid request!")

    @functools.cached_property
    def approx_max_output_len(self) -> int:
        if self.request is None:
            raise AssertionError("Missing request!")

        if self.request["max_tokens"] is None:
            return max(0, self.model_params["max_context"] - self.approx_input_len)
        else:
            return self.request["max_tokens"]

    @functools.cached_property
    def approx_max_cost(self) -> float:
        if self.request is None:
            raise AssertionError("Missing request!")

        if "best_of" in self.request.keys():
            n = self.request["best_of"]
        elif "n" in self.request.keys():
            n = self.request["n"]
        else:
            n = 1

        input_cost = self.approx_input_len * self.model_params["cost_per_input_token"]
        output_cost = self.approx_max_output_len * self.model_params["cost_per_output_token"]
        total_cost = input_cost + output_cost

        return n * total_cost

    @functools.cached_property
    def actual_cost(self) -> float:
        if self.response is None:
            raise AssertionError("Missing response!")

        return self.response["usage"]["prompt_tokens"] * self.model_params["cost_per_input_token"] \
            + self.response["usage"]["completion_tokens"] * self.model_params["cost_per_output_token"]

    def check_request(self) -> None:
        if self.request is None:
            raise AssertionError("Missing request!")

        if self.model_params["max_context"] < self.approx_input_len:
            print("Unable to process the input due to the model's maximum context size!")
        elif self.request["max_tokens"] is not None \
                and self.model_params["max_context"] - self.approx_input_len < self.request["max_tokens"]:
            print("Unable to generate max_tokens output tokens due to the model's maximum context size!")
        elif self.request["max_tokens"] is None and self.model_params["max_context"] - self.approx_input_len == 0:
            print("Unable to generate any output tokens due to the model's maximum context size!")

    def execute(self) -> None:
        if self.request is None:
            raise AssertionError("Missing request!")

        def make_request_hashable(d):
            if isinstance(d, dict):
                return tuple((key, make_request_hashable(value)) for key, value in d.items())
            elif isinstance(d, list) or isinstance(d, tuple):
                return tuple(make_request_hashable(value) for value in d)
            else:
                return d

        request_hash = hash(make_request_hashable(self.request))
        backup_path = pathlib.Path(f"openai_backup/{request_hash}.json")
        if backup_path.is_file():
            with open(backup_path, "r", encoding="utf-8") as file:
                req_res = json.load(file)
                if req_res["request"] == self.request:
                    print(f"Loading backup from previous execution: {backup_path}")
                    self.response = req_res["response"]
                    return

        before = time.time()

        if "messages" in self.request.keys():
            self.response = openai.ChatCompletion.create(**self.request)
        elif "prompt" in self.request.keys():
            self.response = openai.Completion.create(**self.request)
        else:
            raise ValueError("Invalid request!")

        with open(backup_path, "w", encoding="utf-8") as backup_file:
            json.dump({"request": self.request, "response": self.response}, backup_file)

        after = time.time()
        delta = after - before

        a = 60 / self.model_params["max_rpm"]
        b = 60 * (self.response["usage"]["total_tokens"]) / self.model_params["max_tpm"]
        delay = max(a, b) + self.model_params["additional_delay"]

        wait = delay - delta
        if wait > 0:
            print(f"Waiting for {round(wait, 4)} seconds because of API rate limits.")
            time.sleep(wait)


def openai_model(
        model: str
) -> dict:
    """Retrieve information about the OpenAI model.

    Args:
        model: The name of the model.

    Returns:
        A dictionary with information about the OpenAI model.
    """
    if model not in _openai_model_parameters.keys():
        raise AssertionError(f"Unknown model '{model}'!")
    return _openai_model_parameters[model]


def openai_check(requests: list[dict], ) -> None:
    """Check the given requests with regard to API and model restrictions.

    Args:
        requests: A list of API requests.
    """
    for request in requests:
        _Request(request).check_request()


def openai_cost(requests: list[dict]) -> float:
    """Compute the maximum dollar cost for executing the given requests.

    Args:
        requests: A list of API requests.

    Returns:
        The dollar cost.
    """
    requests = [_Request(request) for request in requests]
    for request in requests:
        request.check_request()
    return sum(request.approx_max_cost for request in requests)


def openai_execute(requests: list[dict], *, force: float | None = None, silent: bool = False) -> list[dict]:
    """Execute a list of requests against the OpenAI API.

    This method also computes the maximum cost incurred by the requests, creates backups in case the execution fails,
    and waits between requests to abide the API limits.

    Args:
        requests: A list of API requests.
        force: An optional float specifying the cost below which no confirmation should be required.
        silent: Whether to display log messages and progress bars.

    Returns:
        A list of API responses.
    """
    # prepare requests
    requests = [_Request(request) for request in requests]

    # check requests
    for request in requests:
        request.check_request()

    # compute maximum cost
    total_max_cost = sum(request.approx_max_cost for request in requests)
    if force is None or total_max_cost >= force:
        print(f"Press any key to continue and spend up to around ${round(total_max_cost, 6)}.")
        input()

    # create backup directory
    os.makedirs("openai_backup", exist_ok=True)

    # execute requests
    for request in tqdm.tqdm(requests, desc="Executing requests", disable=silent):
        request.execute()

    # delete backup directory
    shutil.rmtree("openai_backup")

    # compute actual cost
    total_cost = sum(request.actual_cost for request in requests)
    if not silent:
        print(f"Spent ${round(total_cost, 6)}.")

    return [request.response for request in requests]
