# version: 2023-12-08-15-51 (reduced)
import datetime
import functools
import hashlib
import json
import logging
import multiprocessing.pool
import os
import pathlib
import time

import attrs
import requests
import tiktoken
import tqdm

logger = logging.getLogger(__name__)


def get_timestamp() -> str:
    """Get a timestamp string of the current time.

    Returns:
        A string representation of the current time.
    """
    return datetime.datetime.now().strftime("%Y-%m-%d-%H-%M-%S-%f")


########################################################################################################################
# OpenAI API helpers
########################################################################################################################

_openai_completions_url = "https://api.openai.com/v1/completions"
_openai_chat_url = "https://api.openai.com/v1/chat/completions"
_openai_wait_for_failed_requests = 1
_openai_cost_for_failed_requests = 0
_openai_backup_path = pathlib.Path("openai_backup")
_openai_backup_size = 1000
_openai_additional_delay = 0.05
_openai_additional_tokens_per_message = 10

_openai_model_parameters = {  # last updated 12.01.2024
    "gpt-3.5-turbo-1106": {
        "name": "gpt-3.5-turbo-1106",
        "chat_or_completion": "chat",
        "max_rpm": 10000,
        "max_tpm": 2000000,
        "cost_per_1k_input_tokens": 0.001,
        "cost_per_1k_output_tokens": 0.002,
        "max_context": 16385,
        "max_output_tokens": 4096
    },
    "gpt-3.5-turbo-instruct-0914": {
        "name": "gpt-3.5-turbo-instruct-0914",
        "chat_or_completion": "completion",
        "max_rpm": 3000,
        "max_tpm": 250000,
        "cost_per_1k_input_tokens": 0.0015,
        "cost_per_1k_output_tokens": 0.002,
        "max_context": 4096,
        "max_output_tokens": None
    },
    "gpt-4-0613": {
        "name": "gpt-4-0613",
        "chat_or_completion": "chat",
        "max_rpm": 10000,
        "max_tpm": 300000,
        "cost_per_1k_input_tokens": 0.03,
        "cost_per_1k_output_tokens": 0.06,
        "max_context": 8192,
        "max_output_tokens": None
    },
    "gpt-4-1106-preview": {
        "name": "gpt-4-1106-preview",
        "chat_or_completion": "chat",
        "max_rpm": 10000,
        "max_tpm": 600000,
        "cost_per_1k_input_tokens": 0.01,
        "cost_per_1k_output_tokens": 0.03,
        "max_context": 128000,
        "max_output_tokens": 4096
    }
}


@attrs.define(slots=False)
class _Request:
    request: dict = attrs.field(init=True)
    response: dict | None = attrs.field(init=False)
    loaded_from_backup: bool = attrs.field(init=False, default=False)

    @functools.cached_property
    def model(self) -> str:
        if self.request is not None:
            return self.request["model"]
        else:
            raise AssertionError("Missing request!")

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
            extra_tokens = _openai_additional_tokens_per_message
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
            left_for_output = max(0, self.model_params["max_context"] - self.approx_input_len)
            if self.model_params["max_output_tokens"] is not None and self.model_params["max_output_tokens"] < left_for_output:
                return self.model_params["max_output_tokens"]
            else:
                return left_for_output
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

        input_cost = self.approx_input_len * (self.model_params["cost_per_1k_input_tokens"] / 1000)
        output_cost = self.approx_max_output_len * (self.model_params["cost_per_1k_output_tokens"] / 1000)
        total_cost = input_cost + output_cost

        return n * total_cost

    @functools.cached_property
    def actual_cost(self) -> float:
        if self.response is None:
            raise AssertionError("Missing response!")

        if self.loaded_from_backup:
            return 0.0

        if "usage" not in self.response.keys():
            return _openai_cost_for_failed_requests

        input_cost = self.response["usage"]["prompt_tokens"] * (self.model_params["cost_per_1k_input_tokens"] / 1000)
        output_cost = self.response["usage"]["completion_tokens"] * (self.model_params["cost_per_1k_output_tokens"] / 1000)

        return input_cost + output_cost

    def check_request(self) -> None:
        if self.request is None:
            raise AssertionError("Missing request!")

        if self.model_params["max_context"] < self.approx_input_len:
            logger.warning("Unable to process the input due to the model's maximum context size!")

        if self.model_params["max_context"] == self.approx_input_len:
            logger.warning("Unable to generate any output tokens due to the model's maximum context size!")

        if self.request["max_tokens"] is not None:
            if self.model_params["max_output_tokens"] is not None and self.model_params["max_output_tokens"] < self.request["max_tokens"]:
                logger.warning("Unable to generate max_tokens output tokens due to the model's maximum output size!")

            if self.model_params["max_context"] < self.approx_input_len + self.request["max_tokens"]:
                logger.warning("Unable to generate max_tokens output tokens due to the model's maximum context size!")

    def execute(self, num_threads: int = 1) -> None:
        if self.request is None:
            raise AssertionError("Missing request!")

        request_hash = hashlib.sha256(bytes(json.dumps(self.request), "utf-8")).hexdigest()
        matching_backup_file_paths = list(sorted(_openai_backup_path.glob(f"*-{request_hash}.json")))
        if len(matching_backup_file_paths) > 0:
            matching_backup_file_path = matching_backup_file_paths[0]
            with open(matching_backup_file_path, "r", encoding="utf-8") as file:
                req_res = json.load(file)
                if req_res["request"] == self.request:
                    logger.debug(f"Loading backup from previous execution: {matching_backup_file_path}")
                    self.response = req_res["response"]
                    self.loaded_from_backup = True
                    return

        before = time.time()

        if "messages" in self.request.keys():
            url = _openai_chat_url
        elif "prompt" in self.request.keys():
            url = _openai_completions_url
        else:
            raise ValueError("Invalid request!")

        response = requests.post(
            url=url,
            json=self.request,
            headers={"Content-Type": "application/json", "Authorization": f"Bearer {os.environ['OPENAI_API_KEY']}"}
        )
        if response.status_code != 200:
            logger.debug(f"Request failed: {response.content}")
        self.response = response.json()

        backup_file_path = _openai_backup_path / f"{get_timestamp()}-{request_hash}.json"
        with open(backup_file_path, "w", encoding="utf-8") as backup_file:
            json.dump({"request": self.request, "response": self.response}, backup_file)

        after = time.time()
        delta = after - before

        if "usage" in self.response.keys():
            a = 60 / (self.model_params["max_rpm"] / num_threads)
            b = 60 * (self.response["usage"]["total_tokens"]) / (self.model_params["max_tpm"] / num_threads)
            delay = max(a, b) + _openai_additional_delay
        else:
            delay = _openai_wait_for_failed_requests

        wait = delay - delta
        if wait > 0:
            logger.debug(f"Waiting for {round(wait, 4)} seconds because of API rate limits.")
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


def openai_execute(
        requests: list[dict],
        *,
        force: float | None = None,
        silent: bool = False,
        num_threads: int = 1
) -> list[dict]:
    """Execute a list of requests against the OpenAI API.

    This method also computes the maximum cost incurred by the requests, creates backups in case the execution fails,
    and waits between requests to abide the API limits.

    Args:
        requests: A list of API requests.
        force: An optional float specifying the cost below which no confirmation should be required.
        silent: Whether to display log messages and progress bars.
        num_threads: The number of threads to use.

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
        logger.info(f"Press enter to continue and spend up to around ${total_max_cost:.2f}.")
        input()
        if not silent:
            logger.info("Begin execution.")
    elif not silent:
        logger.info(f"Spending up to around ${total_max_cost:.2f}.")

    # create backup directory
    os.makedirs(_openai_backup_path, exist_ok=True)

    # execute requests
    if num_threads > 1:
        with multiprocessing.pool.ThreadPool(processes=num_threads) as pool:
            for _ in tqdm.tqdm(
                    pool.imap(lambda request: request.execute(num_threads=num_threads), requests),
                    desc="execute requests",
                    disable=silent,
                    total=len(requests),
                    miniters=1
            ):
                pass
    else:
        for request in tqdm.tqdm(requests, desc="execute requests", disable=silent, miniters=1):
            request.execute()

    # shrink backup
    backup_file_paths = list(sorted(_openai_backup_path.glob("*.json")))
    if len(backup_file_paths) > _openai_backup_size:
        logger.debug(f"OpenAI backup is too large ({len(backup_file_paths)} > {_openai_backup_size})! ==> Shrink it.")
        for backup_file_path in backup_file_paths[:-_openai_backup_size]:
            os.remove(backup_file_path)

    num_loaded_from_backup = len(list(filter(lambda r: r.loaded_from_backup, requests)))
    if not silent and num_loaded_from_backup > 0:
        logger.info(f"{num_loaded_from_backup} requests loaded from backup.")

    num_failed_requests = 0
    for request in requests:
        if "choices" not in request.response.keys():
            num_failed_requests += 1
    if num_failed_requests > 0:
        logger.warning(f"{num_failed_requests} requests failed!")

    # compute actual cost
    total_cost = sum(request.actual_cost for request in requests)
    if not silent:
        logger.info(f"Spent ${total_cost:.2f}.")

    return [request.response for request in requests]
