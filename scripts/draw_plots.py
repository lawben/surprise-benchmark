import argparse
import os
import pathlib
import re

import numpy as np
import pandas as pd
from matplotlib import pyplot as plt


def load_results(results_dir: pathlib.Path) -> pd.DataFrame:
    results = []
    for system_path in sorted(results_dir.glob("*/")):
        for result_path in sorted(system_path.glob("*.results.*.csv")):
            df = pd.read_csv(result_path)
            df["system"] = system_path.name
            df["query"] = re.match(r".*\.results\.(\w+)\.csv", result_path.name).groups()[0]
            df["file"] = result_path.name
            results.append(df)
    return pd.concat(results, ignore_index=True)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(prog="draw_plots",description="Plot BenchBase results.")
    parser.add_argument("results_dir", help="BenchBase results directory", type=pathlib.Path)
    parser.add_argument("plots_dir", help="output plots directory", type=pathlib.Path)
    parser.add_argument("-v", "--value", help="value to plot",
                        action="store", type=str, default="Median Latency (millisecond)")
    parser.add_argument("-s", "--sort", help="sort queries by results of given system",
                        action="store", type=str, default=None)
    parser.add_argument("-n", "--normalize", help="normalize results by given query",
                        action="store", type=str, default=None)
    args = parser.parse_args()

    if not args.results_dir.is_dir():
        raise FileNotFoundError("The results directory does not exist!")

    if not args.plots_dir.is_dir():
        os.makedirs(args.plots_dir, exist_ok=True)

    results = load_results(args.results_dir)
    results.to_csv(args.plots_dir / "results.csv", index=False)

    if args.sort is None:
        sorted_queries = results["query"].unique()
    else:
        sorted_queries = results[results["system"] == args.sort].sort_values(by=args.value)["query"].unique()
    query2index = {query: idx for idx, query in enumerate(sorted_queries)}

    plt.style.use("ggplot")
    plt.rcParams["figure.figsize"] = (12, 5)
    colors = ["#5D85C3", "#E9503E", "#50B695", "#F8BA3C", "#009CDA", "#C9308E"]

    for system, system_color in zip(results["system"].unique(), colors):
        df = results[results["system"] == system]
        if args.normalize is None:
            normalizer = 1
        else:
            normalizer = df[args.value][df["query"] == args.normalize].tolist()[0]

        plt.scatter(
            x=[query2index[query] for query in df["query"]],
            y=df[args.value] / normalizer,
            marker="x",
            color=system_color,
            label=system
        )

    plt.xticks(np.arange(len(sorted_queries)), sorted_queries)
    plt.ylabel(args.value + f"Normalized By {args.normalize}" if args.normalize is not None else "")
    plt.legend()
    plt.tight_layout()

    plt.savefig(args.plots_dir / ("normalized_latency.pdf" if args.normalize is not None else "latency.pdf"))
