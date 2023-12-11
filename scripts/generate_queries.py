import argparse
import os
import pathlib
import random
import sqlite3

from openai_api_helpers import openai_execute


def create_prompt(schema: str, num_queries_per_request: int) -> str:
    return f"""Generate {num_queries_per_request} OLAP SQL queries that follow the schema below. I need just the SQL statements, no explanations. Each query should be wrapped in ```sql <query> ```. The goal is to stress-test the database management system, so use advanced features such as CTEs, pattern machting, set predicates, and recursion.

Schema:

```sql
{schema}
```

Example query:
```sql
select
    o_year,
    sum(case
        when nation = 'Spain' then volume
        else 0
    end) / sum(volume) as mkt_share
from
    (
        select
            extract(year from o_orderdate) as o_year,
            l_extendedprice * (1 - l_discount) as volume,
            n2.n_name as nation
        from
            part,
            supplier,
            lineitem,
            orders,
            customer,
            nation n1,
            nation n2,
            region
        where
            p_partkey = l_partkey
            and s_suppkey = l_suppkey
            and l_orderkey = o_orderkey
            and o_custkey = c_custkey
            and c_nationkey = n1.n_nationkey
            and n1.n_regionkey = r_regionkey
            and r_name = 'west'
            and s_nationkey = n2.n_nationkey
            and o_orderdate between date '1995-01-01' and date '1996-12-31'
            and p_type = 'screw'
    ) as all_nations
group by
    o_year
order by
    o_year;
```
"""


def create_requests(
        prompt: str,
        random_seed: int,
        num_requests: int,
        model: str,
        max_tokens: str,
        temperature: float
) -> list[dict]:
    random.seed(random_seed)
    requests = []
    for ix in range(num_requests):
        request = {
            "model": model,
            "max_tokens": max_tokens,
            "temperature": temperature,
            "seed": random.randint(0, 1000000),
            "messages": [
                {
                    "role": "user",
                    "content": prompt
                },
            ]
        }
        requests.append(request)
    return requests


def postprocess_output(output: str) -> str:
    # remove ```sql ... ´´´
    if output.startswith("```sql\n"):
        output = output[7:]
    if output.endswith("```"):
        output = output[:-3]
    return output


def split_queries(output: str) -> list[str]:
    queries = output.split("```sql")
    queries = queries[:1] + ["```sql" + query for query in queries[1:]]  # add -- back
    return queries


def remove_comment(line: str) -> str:
    if "--" in line:
        return line[:line.index("--")]
    else:
        return line


def postprocess_query(query: str) -> str | None:
    query = query.strip()
    query = query.removeprefix("```sql")
    query = query.removesuffix("```")
    query = query.strip()

    lines = query.split("\n")
    lines = [line.strip() for line in lines]
    lines = [line for line in lines if "```" not in line]
    lines = [line.strip() for line in lines]
    lines = [remove_comment(line) for line in lines]
    lines = [line.strip() for line in lines]
    lines = [line for line in lines if line != ""]
    lines = [line.strip() for line in lines]

    query = " ".join(lines)  # turn query into single line
    query = " ".join(query.split())

    if len(query) <= 2:  # query consists only of "--"
        print(f"Discard empty query `{query}`!")
        return None

    return query


def validate_query(query: str, schema: str) -> str | None:
    with sqlite3.connect(":memory:") as val_db:
        val_db.executescript(schema)
        val_db.commit()

        try:
            val_db.execute(query)
            val_db.commit()
        except Exception as e:
            print(f"Discard execution-failed query: `{query}`!")
            print(f"Reason: {e}")
            return None

    return query


def save_queries(queries: list[str], queries_dir: pathlib.Path) -> None:
    prev_max_idx = max(int(p.name[1:-4]) for p in sorted(queries_dir.glob("*.sql")))
    for ix, query in enumerate(queries):
        with open(queries_dir / f"S{ix + prev_max_idx + 1}.sql", "w", encoding="utf-8") as file:
            file.write(query)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(prog="generate_queries", description="Generate queries with GPT.")
    parser.add_argument("queries_dir", help="output queries directory", type=pathlib.Path)
    parser.add_argument("schema_file", help="schema sql file", type=pathlib.Path)
    parser.add_argument("-r", "--requests", help="number of API requests", type=int, default=1)
    parser.add_argument("-q", "--queries_per_request", help="number of queries per API request", type=int, default=3)
    parser.add_argument("-s", "--seed", help="random seed for seeds for API requests", type=int, default=837596)
    parser.add_argument("-m", "--model", help="model for API requests", type=str, default="gpt-4")
    parser.add_argument("-x", "--max_tokens", help="max_tokens for API requests", type=int, default=None)
    parser.add_argument("-t", "--temperature", help="temperature for API requests", type=float, default=0)
    parser.add_argument("-f", "--force", help="do not require confirmation below given cost", type=float, default=0.1)
    args = parser.parse_args()

    os.makedirs(args.queries_dir, exist_ok=True)

    with open(args.schema_file, "r", encoding="utf-8") as file:
        schema = file.read()

    prompt = create_prompt(schema, args.queries_per_request)
    requests = create_requests(prompt, args.seed, args.requests, args.model, args.max_tokens, args.temperature)

    responses = openai_execute(requests=requests, force=args.force)

    outputs = [response["choices"][0]["message"]["content"] for response in responses]
    outputs = [postprocess_output(output) for output in outputs]
    queries = [query for output in outputs for query in split_queries(output)]  # also flattens list of queries
    queries = [q for query in queries if (q := postprocess_query(query)) is not None]
    queries = [q for query in queries if (q := validate_query(query, schema)) is not None]

    print(
        f"Obtained {len(queries)} valid queries from {args.requests} requests with "
        f"{args.queries_per_request} queries per request."
    )

    save_queries(queries, args.queries_dir)
