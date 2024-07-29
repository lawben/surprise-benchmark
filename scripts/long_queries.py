import argparse
import logging
import os
import pathlib
import random
import sqlite3

my_random = random.Random(225816044)


def random_identifier(num_chars: int) -> str:
    return "".join("a" * num_chars)


# noinspection SqlDialectInspection,SqlNoDataSourceInspection
def create_query_with_long_alias(alias_len: int) -> str:
    return f"select l_returnflag as {random_identifier(alias_len)} from lineitem limit 10;"


# noinspection SqlDialectInspection,SqlNoDataSourceInspection
def create_query_with_long_table_alias(alias_len: int) -> str:
    alias = random_identifier(alias_len)
    return f"select {alias}.l_returnflag as returnflag from lineitem as {alias} limit 10;"


def _create_complex_expression_in_select_rec(budget: int) -> str:
    operators = ["+", "-"]
    if budget <= 1:
        return "l_quantity"

    coin = my_random.randint(0, 2)
    if coin == 0:
        return f"-({_create_complex_expression_in_select_rec(budget - 1)})"
    elif coin == 1:
        return f"(1 {my_random.choice(operators)} {_create_complex_expression_in_select_rec(budget - 1)})"
    else:
        left_budget = my_random.randint(0, budget - 1)
        right_budget = budget - left_budget
        return (f"({_create_complex_expression_in_select_rec(left_budget)} {my_random.choice(operators)} "
                f"{_create_complex_expression_in_select_rec(right_budget)})")


# noinspection SqlDialectInspection,SqlNoDataSourceInspection
def create_query_with_complex_expression_in_select(num_expressions: int) -> str:
    return f"select {_create_complex_expression_in_select_rec(num_expressions)} as {random_identifier(3)} from lineitem limit 10;"


# noinspection SqlDialectInspection,SqlNoDataSourceInspection
def create_query_with_large_disjunction_in_where(num_expressions: int) -> str:
    where_parts = []
    for _ in range(num_expressions):
        year = my_random.randint(1992, 1998)
        month = my_random.randint(1, 12)
        if month in [1, 3, 5, 7, 8, 10, 12]:
            day = my_random.randint(1, 31)
        elif month in [4, 6, 9, 11]:
            day = my_random.randint(1, 30)
        else:
            day = my_random.randint(1, 28)

        where_parts.append(f"o_orderdate = date '{year}-{month:02d}-{day:02d}'")
    where_clause = " or ".join(where_parts)
    return f"select o_orderkey from orders where {where_clause} limit 10;"


def try_out_query(name: str, query: str, schema: str) -> None:
    with sqlite3.connect(":memory:") as val_db:
        val_db.executescript(schema)
        val_db.commit()

        try:
            val_db.execute(query)
            val_db.commit()
        except Exception as e:
            print(f"{name} fails in sqlite, reason: {e}")


def save_queries(names_and_queries: list[tuple[str, str]], queries_dir: pathlib.Path) -> None:
    for name, query in names_and_queries:
        with open(queries_dir / f"{name}.sql", "w", encoding="utf-8") as file:
            file.write(query)


if __name__ == "__main__":
    logging.basicConfig(encoding='utf-8', level=logging.INFO)

    parser = argparse.ArgumentParser(prog="long_queries", description="Generate long queries.")
    parser.add_argument("-d", "--queries_dir", help="output queries directory", type=pathlib.Path, default=pathlib.Path("data/long_queries"))
    parser.add_argument("-s", "--schema_file", help="schema sql file", type=pathlib.Path, default=pathlib.Path("data/tpch_schema.sql"))
    args = parser.parse_args()

    os.makedirs(args.queries_dir, exist_ok=True)

    with open(args.schema_file, "r", encoding="utf-8") as file:
        schema = file.read()

    print("Create queries...")
    names_and_queries = [
        ("long_alias_1M", create_query_with_long_alias(alias_len=1000000)),
        ("long_alias_10M", create_query_with_long_alias(alias_len=10000000)),
        ("long_alias_100M", create_query_with_long_alias(alias_len=100000000)),
        ("long_table_alias_1M", create_query_with_long_table_alias(alias_len=1000000)),
        ("long_table_alias_10M", create_query_with_long_table_alias(alias_len=10000000)),
        ("long_table_alias_100M", create_query_with_long_table_alias(alias_len=100000000)),
        ("complex_expr_in_select_10T", create_query_with_complex_expression_in_select(num_expressions=10000)),
        ("complex_expr_in_select_100T", create_query_with_complex_expression_in_select(num_expressions=100000)),
        ("complex_expr_in_select_1M", create_query_with_complex_expression_in_select(num_expressions=1000000)),
        ("large_disjunction_in_where_1T", create_query_with_large_disjunction_in_where(num_expressions=1000)),
        ("large_disjunction_in_where_10T", create_query_with_large_disjunction_in_where(num_expressions=10000)),
        ("large_disjunction_in_where_100T", create_query_with_large_disjunction_in_where(num_expressions=100000))
    ]

    print("Try out queries...")
    for name, query in names_and_queries:
        try_out_query(name, query, schema)

    save_queries(names_and_queries, args.queries_dir)
