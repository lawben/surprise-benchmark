import argparse

def get_table_name(year, month):
    return "LINEITEM_" + str(year) + "_" + str(month)

def get_union_op(if_unionall):
    operator = "UNION"
    if if_unionall:
        operator += " ALL"
    return operator

def union_last(year_range, month_range, if_unionall):
    operator = get_union_op(if_unionall)
    result = ""
    template = """
(
-- {year}, {month}
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        {table_name}
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
"""
    for year in year_range:
        for month in month_range:
            table_name = get_table_name(year, month)
            result += template.format(table_name=table_name, year=year, month=month)
            if year != 1998 or month != 12:
                result += operator
    return result

def union_first(year_range, month_range, if_unionall):
    operator = get_union_op(if_unionall)
    result = "WITH LINEITEM_NEW AS ("
    for year in year_range:
        for month in month_range:
            table_name = get_table_name(year, month)
            result += "SELECT * FROM " + table_name + "\n"
            if year != 1998 or month != 12:
                result += operator + "\n"
    result += ")"
    result += """
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_NEW
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority;
"""
    return result

def psql_monthly_union(year, month):
    table_name = get_table_name(year, month)
    template = """
-- {year}, {month}
DROP TABLE IF EXISTS {table_name};
CREATE TABLE {table_name}
(
    L_ORDERKEY      INTEGER NOT NULL, -- references O_ORDERKEY
    L_PARTKEY       INTEGER NOT NULL, -- references P_PARTKEY (compound fk to PARTSUPP)
    L_SUPPKEY       INTEGER NOT NULL, -- references S_SUPPKEY (compound fk to PARTSUPP)
    L_LINENUMBER    INTEGER,
    L_QUANTITY      DECIMAL,
    L_EXTENDEDPRICE DECIMAL,
    L_DISCOUNT      DECIMAL,
    L_TAX           DECIMAL,
    L_RETURNFLAG    CHAR(1),
    L_LINESTATUS    CHAR(1),
    L_SHIPDATE      DATE,
    L_COMMITDATE    DATE,
    L_RECEIPTDATE   DATE,
    L_SHIPINSTRUCT  CHAR(25),
    L_SHIPMODE      CHAR(10),
    L_COMMENT       VARCHAR(44)
);

INSERT INTO {table_name}
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '{year}-{month}-01' AND L_SHIPDATE < DATE '{year}-{month}-01'+ INTERVAL '1' MONTH;

ALTER TABLE {table_name} ADD PRIMARY KEY (L_ORDERKEY, L_LINENUMBER);
ALTER TABLE {table_name} ADD FOREIGN KEY (L_ORDERKEY) REFERENCES ORDERS(O_ORDERKEY);
ALTER TABLE {table_name} ADD FOREIGN KEY (L_PARTKEY,L_SUPPKEY) REFERENCES PARTSUPP(PS_PARTKEY,PS_SUPPKEY);
--CREATE INDEX IDX_{table_name}_ORDERKEY ON  {table_name} (L_ORDERKEY);
--CREATE INDEX IDX_{table_name}_PART_SUPP ON {table_name} (L_PARTKEY,L_SUPPKEY);
--CREATE INDEX IDX_{table_name}_SHIPDATE ON  {table_name} (L_SHIPDATE, L_DISCOUNT, L_QUANTITY);
"""
    return template.format(table_name=table_name, year=year, month=month)


def main():
    parser = argparse.ArgumentParser(description='Generation of SQL for union')
    parser.add_argument('--option', help='psql_create_table, union_first, unionall_first, union_last, unionall_last')
    
    args = parser.parse_args()

    option = args.option
    year_range = range(1992, 1998 + 1)
    month_range = range(1, 12 + 1)
    if option == 'psql_create_table':
        for year in year_range:
            for month in month_range:
                print(psql_monthly_union(year, month))
    elif option == 'union_first':
        print(union_first(year_range, month_range, False))
    elif option == 'unionall_first':
        print(union_first(year_range, month_range, True))
    elif option == 'union_last':
        print(union_last(year_range, month_range, False))
    elif option == 'unionall_last':
        print(union_last(year_range, month_range, True))
    else:
        print("INVALID")
        parser.print_help()

if __name__ == '__main__':
    main()
