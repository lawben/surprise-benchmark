import argparse
import os
import pathlib
import shutil


def save_queries(queries: list[str], queries_dir: pathlib.Path) -> None:
    for ix, query in enumerate(queries):
        with open(queries_dir / f"S{ix}.sql", "w", encoding="utf-8") as file:
            file.write(query)


def save_queries_for_benchbase(queries: list[str], xml_file: pathlib.Path) -> None:
    with open(xml_file, "w", encoding="utf-8") as file:
        file.write("""<?xml version="1.0" encoding="UTF-8"?>\n<templates>\n""")
        for ix, query in enumerate(queries):
            file.write(f"""    <template name="S{ix}"><query><![CDATA[ {query} ]]></query></template>\n""")
        file.write("""</templates>""")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(prog="prepare_queries_for_benchbase", description="Prepare the generated queries for BenchBase.")
    parser.add_argument("queries_dir", help="queries directory", type=pathlib.Path)
    parser.add_argument("xml_file", help="xml file path", type=pathlib.Path)
    args = parser.parse_args()

    if not args.queries_dir.is_dir():
        raise FileNotFoundError("The queries directory does not exist!")

    os.makedirs(args.xml_file.parent, exist_ok=True)

    queries = []
    for query_path in sorted(args.queries_dir.glob("*.sql")):
        with open(query_path, "r", encoding="utf-8") as file:
            queries.append(file.read())

    shutil.rmtree(args.queries_dir)
    os.makedirs(args.queries_dir, exist_ok=True)

    save_queries(queries, args.queries_dir)
    save_queries_for_benchbase(queries, args.xml_file)
