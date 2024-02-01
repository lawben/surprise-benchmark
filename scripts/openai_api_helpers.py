# version: 2024-02-01-16-28 (reduced)
import datetime
import hashlib
import json
import logging
import os
import pathlib
import threading
import time
from typing import Any

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
_openai_additional_tokens_per_message = 10
_openai_cost_for_failed_requests = 0.0
_openai_len_for_failed_requests = 0
_openai_wait_window = 70.0
_openai_wait_before_retry = 0.1
_openai_wait_before_try = 0.001
_openai_api_share = 0.3
_openai_api_max_simultaneous_requests = 200
_openai_cache_path = pathlib.Path("openai_cache")
_openai_cache_size = 10000

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


def _openai_get_model_params(model: str) -> dict:
    if model not in _openai_model_parameters.keys():
        raise AssertionError(f"Unknown model '{model}'!")
    else:
        return _openai_model_parameters[model]


def _openai_compute_approximate_input_len(request: dict) -> int:
    encoding = tiktoken.encoding_for_model(request["model"])

    if "messages" in request.keys():
        extra_tokens = _openai_additional_tokens_per_message
        return sum(len(encoding.encode(message["content"])) + extra_tokens for message in request["messages"])
    elif "prompt" in request.keys():
        return len(encoding.encode(request["prompt"]))
    else:
        raise ValueError("Invalid request!")


def _openai_compute_approximate_max_output_len(request: dict) -> int:
    if request["max_tokens"] is not None:
        return request["max_tokens"]
    else:
        model_params = _openai_get_model_params(request["model"])
        left_for_output = max(0, model_params["max_context"] - _openai_compute_approximate_input_len(request))
        if model_params["max_output_tokens"] is not None and model_params["max_output_tokens"] < left_for_output:
            return model_params["max_output_tokens"]
        else:
            return left_for_output


def _openai_compute_approximate_max_total_len(request: dict) -> int:
    return _openai_compute_approximate_input_len(request) + _openai_compute_approximate_max_output_len(request)


def _openai_compute_actual_total_len(response: dict) -> int:
    if "usage" in response.keys():
        return response["usage"]["prompt_tokens"] + response["usage"]["completion_tokens"]
    else:
        return _openai_len_for_failed_requests


def _openai_compute_approximate_max_cost(request: dict) -> float:
    if "best_of" in request.keys():
        n = request["best_of"]
    elif "n" in request.keys():
        n = request["n"]
    else:
        n = 1

    model_params = _openai_get_model_params(request["model"])
    input_cost = _openai_compute_approximate_input_len(request) * (model_params["cost_per_1k_input_tokens"] / 1000)
    output_cost = _openai_compute_approximate_max_output_len(request) * (model_params["cost_per_1k_output_tokens"] / 1000)
    return n * (input_cost + output_cost)


def _openai_compute_actual_cost(response: dict) -> float:
    if "usage" not in response.keys():
        return _openai_cost_for_failed_requests

    model_params = _openai_get_model_params(response["model"])
    input_cost = response["usage"]["prompt_tokens"] * (model_params["cost_per_1k_input_tokens"] / 1000)
    output_cost = response["usage"]["completion_tokens"] * (model_params["cost_per_1k_output_tokens"] / 1000)

    return input_cost + output_cost


def _openai_check_request(request: dict) -> None:
    model_params = _openai_get_model_params(request["model"])
    approx_input_len = _openai_compute_approximate_input_len(request)
    if model_params["max_context"] < approx_input_len:
        logger.warning("Unable to process the input due to the model's max_context!")

    if model_params["max_context"] == approx_input_len:
        logger.warning("Unable to generate any output tokens due to the model's max_context!")

    if request["max_tokens"] is not None:
        if model_params["max_output_tokens"] is not None and model_params["max_output_tokens"] < request["max_tokens"]:
            logger.warning("Unable to generate max_tokens output tokens due to the model's max_output_tokens!")

        if model_params["max_context"] < approx_input_len + request["max_tokens"]:
            logger.warning("Unable to generate max_tokens output tokens due to the model's max_context!")


def _openai_load_cached_response(request: dict) -> dict | None:
    request_hash = hashlib.sha256(bytes(json.dumps(request), "utf-8")).hexdigest()
    matching_cache_file_paths = list(sorted(_openai_cache_path.glob(f"*-{request_hash}.json")))
    if len(matching_cache_file_paths) > 0:
        matching_cache_file_path = matching_cache_file_paths[0]
        with open(matching_cache_file_path, "r", encoding="utf-8") as file:
            cached_pair = json.load(file)
            if cached_pair["request"] == request:
                return cached_pair["response"]
    return None


def _openai_execute_request(request: dict) -> tuple[dict, bool]:
    response = _openai_load_cached_response(request)
    if response is not None:
        return response, True

    # execute request
    if "messages" in request.keys():
        url = _openai_chat_url
    elif "prompt" in request.keys():
        url = _openai_completions_url
    else:
        raise ValueError("Invalid request!")

    response = requests.post(
        url=url,
        json=request,
        headers={"Content-Type": "application/json", "Authorization": f"Bearer {os.environ['OPENAI_API_KEY']}"}
    )
    if response.status_code != 200:
        logger.debug(f"Request failed: {response.content}")
    response = response.json()

    request_hash = hashlib.sha256(bytes(json.dumps(request), "utf-8")).hexdigest()
    cache_file_path = _openai_cache_path / f"{get_timestamp()}-{request_hash}.json"
    with open(cache_file_path, "w", encoding="utf-8") as cache_file:
        json.dump({"request": request, "response": response}, cache_file)

    return response, False


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
        silent: bool = False
) -> list[dict]:
    """Execute a list of requests against the OpenAI API.

    This method also computes the maximum cost incurred by the requests, caches requests and responses, and waits
    between requests to abide the API limits.

    Args:
        requests: A list of API requests.
        force: An optional float specifying the cost below which no confirmation should be required.
        silent: Whether to display log messages and progress bars.

    Returns:
        A list of API responses.
    """
    pairs: list[dict[str, Any]] = [{
        "request": request,
        "response": None,
        "was_cached": False,
        "max_total_len": None,
        "finished_time": None,
        "thread": None
    } for request in requests]

    # check requests
    for pair in pairs:
        _openai_check_request(pair["request"])

    # create cache directory
    os.makedirs(_openai_cache_path, exist_ok=True)

    # load cached pairs
    for pair in pairs:
        response = _openai_load_cached_response(pair["request"])
        if response is not None:
            pair["response"] = response
            pair["was_cached"] = True

    pairs_to_execute = [pair for pair in pairs if not pair["was_cached"]]

    # compute maximum cost
    total_max_cost = sum(_openai_compute_approximate_max_cost(pair["request"]) for pair in pairs_to_execute)
    if force is None or total_max_cost >= force:
        logger.info(f"Press enter to continue and spend up to around ${total_max_cost:.2f}.")
        input(f"Press enter to continue and spend up to around ${total_max_cost:.2f}.")
        if not silent:
            logger.info("Begin execution.")
    elif not silent:
        logger.info(f"Spending up to around ${total_max_cost:.2f}.")

    # execute requests
    with tqdm.tqdm(total=len(pairs), desc="execute requests", disable=silent) as progress_bar:
        for pair in pairs_to_execute:
            model_params = _openai_get_model_params(pair["request"]["model"])
            pair["max_total_len"] = _openai_compute_approximate_max_total_len(pair["request"])

            while True:
                # pairs are relevant if they were already started, were not cached, and the finished time is within the last
                # minute
                relevant_pairs = [p for p in pairs_to_execute if p["thread"] is not None and not p["was_cached"] and (p["finished_time"] is None or time.time() - p["finished_time"] <= _openai_wait_window)]
                total_requests = len(relevant_pairs)
                simultaneous_requests = len([p for p in relevant_pairs if p["finished_time"] is None])
                total_len = sum(p["max_total_len"] for p in relevant_pairs)
                if simultaneous_requests > _openai_api_max_simultaneous_requests:
                    logger.debug("Sleep to avoid too many simultaneous requests.")
                    time.sleep(_openai_wait_before_retry)
                if total_requests > model_params["max_rpm"] * _openai_api_share:
                    logger.debug("Sleep to abide the model's max_rpm.")
                    time.sleep(_openai_wait_before_retry)
                elif total_len > model_params["max_tpm"] * _openai_api_share:
                    logger.debug("Sleep to abide the model's max_tpm.")
                    time.sleep(_openai_wait_before_retry)
                else:
                    time.sleep(_openai_wait_before_try)

                    def execute(p, pb):
                        response, was_cached = _openai_execute_request(p["request"])
                        p["response"] = response
                        p["was_cached"] = was_cached
                        p["finished_time"] = time.time()
                        p["max_total_len"] = _openai_compute_actual_total_len(response)
                        pb.update()

                    thread = threading.Thread(target=execute, args=(pair, progress_bar))
                    pair["thread"] = thread
                    thread.start()
                    break

        for pair in pairs_to_execute:
            if pair["thread"] is not None:
                pair["thread"].join()

    # shrink cache
    cache_file_paths = list(sorted(_openai_cache_path.glob("*.json")))
    if len(cache_file_paths) > _openai_cache_size:
        logger.debug(f"OpenAI cache is too large ({len(cache_file_paths)} > {_openai_cache_size})! ==> Shrink it.")
        for cache_file_path in cache_file_paths[:-_openai_cache_size]:
            os.remove(cache_file_path)

    # describe output
    num_failed_requests = 0
    for pair in pairs:
        if "choices" not in pair["response"].keys():
            num_failed_requests += 1
    if num_failed_requests > 0:
        logger.warning(f"{num_failed_requests} requests failed!")

    total_cost = sum(_openai_compute_actual_cost(pair["response"]) for pair in pairs_to_execute if not pair["was_cached"])
    if not silent:
        message = f"Spent ${total_cost:.2f}."
        was_cached = sum(pair["was_cached"] for pair in pairs)
        if was_cached > 0:
            message += f" ({was_cached} responses were already cached)"
        logger.info(message)

    return [pair["response"] for pair in pairs]
