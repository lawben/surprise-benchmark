import argparse
import os
import pathlib
import re


def update_xml_file(names_and_queries: list[tuple[str, str]], xml_file: pathlib.Path) -> None:
    with open(xml_file, "w", encoding="utf-8") as file:
        file.write("""<?xml version="1.0" encoding="UTF-8"?>\n<templates>\n""")
        for name, query in names_and_queries:
            file.write(f"""    <template name="{name}"><query><![CDATA[ {query} ]]></query></template>\n""")
        file.write("""</templates>""")


def update_system_xml_files(names_and_queries: list[tuple[str, str]], system_xml_files: list[pathlib.Path]) -> None:
    for system_xml_file in system_xml_files:
        with open(system_xml_file, "r", encoding="utf-8") as file:
            content = file.read()

        content = re.sub(
            "<weights>.*</weights>",
            "<weights>" + ",".join("1" for _ in names_and_queries) + "</weights>",
            content
        )
        content = re.sub(
            r"<transactiontypes>(.|\s)*</transactiontypes>",
            "<transactiontypes>" + "".join(f"<transactiontype><name>{name}</name></transactiontype>" for name, _ in names_and_queries) + "</transactiontypes>",
            content
        )

        with open(system_xml_file, "w", encoding="utf-8") as file:
            file.write(content)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(prog="prepare_queries_for_benchbase", description="Prepare the generated queries for BenchBase.")
    parser.add_argument("-d", "--queries_dir", help="queries directory", type=pathlib.Path, default=pathlib.Path("data/queries"))
    parser.add_argument("-x", "--xml_file", help="xml file path", type=pathlib.Path, default=pathlib.Path("data/surprise_tpch_queries.xml"))
    parser.add_argument(
        "-s", "--system_xml_files", help="comma-separated list of system-specific xml file paths", type=pathlib.Path, nargs="*",
        default=[
            pathlib.Path("clickhouse/surprise_tpch_config.xml"),
            pathlib.Path("monetdb/surprise_tpch_config.xml"),
            pathlib.Path("mysql/surprise_tpch_config.xml"),
            pathlib.Path("postgres/surprise_tpch_config.xml"),
            pathlib.Path("umbra/surprise_tpch_config.xml"),
        ]
    )
    args = parser.parse_args()

    if not args.queries_dir.is_dir():
        raise FileNotFoundError("The queries directory does not exist!")

    os.makedirs(args.xml_file.parent, exist_ok=True)

    names_and_queries = []
    for query_path in sorted(args.queries_dir.glob("*.sql")):
        with open(query_path, "r", encoding="utf-8") as file:
            names_and_queries.append((query_path.name[:-4], file.read()))

    update_xml_file(names_and_queries, args.xml_file)
    update_system_xml_files(names_and_queries, args.system_xml_files)
