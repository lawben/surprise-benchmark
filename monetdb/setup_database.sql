DROP TABLE IF EXISTS nation;
DROP TABLE IF EXISTS region;
DROP TABLE IF EXISTS part;
DROP TABLE IF EXISTS supplier;
DROP TABLE IF EXISTS partsupp;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS lineitem;

-- Sccsid:     @(#)dss.ddl  2.1.8.1
CREATE TABLE nation  ( n_nationkey  INTEGER NOT NULL,
                       n_name       CHAR(25) NOT NULL,
                       n_regionkey  INTEGER NOT NULL,
                       n_comment    VARCHAR(152));

CREATE TABLE region  ( r_regionkey  INTEGER NOT NULL,
                       r_name       CHAR(25) NOT NULL,
                       r_comment    VARCHAR(152));

CREATE TABLE part  ( p_partkey     INTEGER NOT NULL,
                     p_name        VARCHAR(55) NOT NULL,
                     p_mfgr        CHAR(25) NOT NULL,
                     p_brand       CHAR(10) NOT NULL,
                     p_type        VARCHAR(25) NOT NULL,
                     p_size        INTEGER NOT NULL,
                     p_container   CHAR(10) NOT NULL,
                     p_retailprice DECIMAL(15,2) NOT NULL,
                     p_comment     VARCHAR(23) NOT NULL );

CREATE TABLE supplier ( s_suppkey     INTEGER NOT NULL,
                        s_name        CHAR(25) NOT NULL,
                        s_address     VARCHAR(40) NOT NULL,
                        s_nationkey   INTEGER NOT NULL,
                        s_phone       CHAR(15) NOT NULL,
                        s_acctbal     DECIMAL(15,2) NOT NULL,
                        s_comment     VARCHAR(101) NOT NULL);

CREATE TABLE partsupp ( ps_partkey     INTEGER NOT NULL,
                        ps_suppkey     INTEGER NOT NULL,
                        ps_availqty    INTEGER NOT NULL,
                        ps_supplycost  DECIMAL(15,2)  NOT NULL,
                        ps_comment     VARCHAR(199) NOT NULL );

CREATE TABLE customer ( c_custkey     INTEGER NOT NULL,
                        c_name        VARCHAR(25) NOT NULL,
                        c_address     VARCHAR(40) NOT NULL,
                        c_nationkey   INTEGER NOT NULL,
                        c_phone       CHAR(15) NOT NULL,
                        c_acctbal     DECIMAL(15,2)   NOT NULL,
                        c_mktsegment  CHAR(10) NOT NULL,
                        c_comment     VARCHAR(117) NOT NULL);

CREATE TABLE orders  ( o_orderkey       INTEGER NOT NULL,
                       o_custkey        INTEGER NOT NULL,
                       o_orderstatus    CHAR(1) NOT NULL,
                       o_totalprice     DECIMAL(15,2) NOT NULL,
                       o_orderdate      DATE NOT NULL,
                       o_orderpriority  CHAR(15) NOT NULL,
                       o_clerk          CHAR(15) NOT NULL,
                       o_shippriority   INTEGER NOT NULL,
                       o_comment        VARCHAR(79) NOT NULL);

CREATE TABLE lineitem ( l_orderkey    INTEGER NOT NULL,
                        l_partkey     INTEGER NOT NULL,
                        l_suppkey     INTEGER NOT NULL,
                        l_linenumber  INTEGER NOT NULL,
                        l_quantity    DECIMAL(15,2) NOT NULL,
                        l_extendedprice  DECIMAL(15,2) NOT NULL,
                        l_discount    DECIMAL(15,2) NOT NULL,
                        l_tax         DECIMAL(15,2) NOT NULL,
                        l_returnflag  CHAR(1) NOT NULL,
                        l_linestatus  CHAR(1) NOT NULL,
                        l_shipdate    DATE NOT NULL,
                        l_commitdate  DATE NOT NULL,
                        l_receiptdate DATE NOT NULL,
                        l_shipinstruct CHAR(25) NOT NULL,
                        l_shipmode     CHAR(10) NOT NULL,
                        l_comment      VARCHAR(44) NOT NULL);

-- MonetDB doesn't have indexes.

-- https://www.monetdb.org/documentation-Dec2023/user-guide/sql-manual/data-loading/copy-from/

COPY INTO part FROM '/benchbase/tpch_data/part.tbl' ON CLIENT USING DELIMITERS '|', E'\n', '"';

COPY INTO region FROM '/benchbase/tpch_data/region.tbl' ON CLIENT USING DELIMITERS '|', E'\n', '"';

COPY INTO nation FROM '/benchbase/tpch_data/nation.tbl' ON CLIENT USING DELIMITERS '|', E'\n', '"';

COPY INTO supplier FROM '/benchbase/tpch_data/supplier.tbl' ON CLIENT USING DELIMITERS '|', E'\n', '"';

COPY INTO customer FROM '/benchbase/tpch_data/customer.tbl' ON CLIENT USING DELIMITERS '|', E'\n', '"';

COPY INTO partsupp FROM '/benchbase/tpch_data/partsupp.tbl' ON CLIENT USING DELIMITERS '|', E'\n', '"';

COPY INTO orders FROM '/benchbase/tpch_data/orders.tbl' ON CLIENT USING DELIMITERS '|', E'\n', '"';

COPY INTO lineitem FROM '/benchbase/tpch_data/lineitem.tbl' ON CLIENT USING DELIMITERS '|', E'\n', '"';

------------------------------------------------------------------------------------------------------------------------
-- tables for UNION
-----------------------------------------------------------------------------------------------------------------------



-- 1992, 1
DROP TABLE IF EXISTS LINEITEM_1992_1;
CREATE TABLE LINEITEM_1992_1 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1992_1
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1992-1-01' AND L_SHIPDATE < DATE '1992-1-01'+ INTERVAL '1' MONTH;


-- 1992, 2
DROP TABLE IF EXISTS LINEITEM_1992_2;
CREATE TABLE LINEITEM_1992_2 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1992_2
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1992-2-01' AND L_SHIPDATE < DATE '1992-2-01'+ INTERVAL '1' MONTH;


-- 1992, 3
DROP TABLE IF EXISTS LINEITEM_1992_3;
CREATE TABLE LINEITEM_1992_3 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1992_3
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1992-3-01' AND L_SHIPDATE < DATE '1992-3-01'+ INTERVAL '1' MONTH;


-- 1992, 4
DROP TABLE IF EXISTS LINEITEM_1992_4;
CREATE TABLE LINEITEM_1992_4 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1992_4
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1992-4-01' AND L_SHIPDATE < DATE '1992-4-01'+ INTERVAL '1' MONTH;


-- 1992, 5
DROP TABLE IF EXISTS LINEITEM_1992_5;
CREATE TABLE LINEITEM_1992_5 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1992_5
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1992-5-01' AND L_SHIPDATE < DATE '1992-5-01'+ INTERVAL '1' MONTH;


-- 1992, 6
DROP TABLE IF EXISTS LINEITEM_1992_6;
CREATE TABLE LINEITEM_1992_6 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1992_6
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1992-6-01' AND L_SHIPDATE < DATE '1992-6-01'+ INTERVAL '1' MONTH;


-- 1992, 7
DROP TABLE IF EXISTS LINEITEM_1992_7;
CREATE TABLE LINEITEM_1992_7 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1992_7
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1992-7-01' AND L_SHIPDATE < DATE '1992-7-01'+ INTERVAL '1' MONTH;


-- 1992, 8
DROP TABLE IF EXISTS LINEITEM_1992_8;
CREATE TABLE LINEITEM_1992_8 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1992_8
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1992-8-01' AND L_SHIPDATE < DATE '1992-8-01'+ INTERVAL '1' MONTH;


-- 1992, 9
DROP TABLE IF EXISTS LINEITEM_1992_9;
CREATE TABLE LINEITEM_1992_9 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1992_9
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1992-9-01' AND L_SHIPDATE < DATE '1992-9-01'+ INTERVAL '1' MONTH;


-- 1992, 10
DROP TABLE IF EXISTS LINEITEM_1992_10;
CREATE TABLE LINEITEM_1992_10 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1992_10
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1992-10-01' AND L_SHIPDATE < DATE '1992-10-01'+ INTERVAL '1' MONTH;


-- 1992, 11
DROP TABLE IF EXISTS LINEITEM_1992_11;
CREATE TABLE LINEITEM_1992_11 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1992_11
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1992-11-01' AND L_SHIPDATE < DATE '1992-11-01'+ INTERVAL '1' MONTH;


-- 1992, 12
DROP TABLE IF EXISTS LINEITEM_1992_12;
CREATE TABLE LINEITEM_1992_12 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1992_12
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1992-12-01' AND L_SHIPDATE < DATE '1992-12-01'+ INTERVAL '1' MONTH;


-- 1993, 1
DROP TABLE IF EXISTS LINEITEM_1993_1;
CREATE TABLE LINEITEM_1993_1 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1993_1
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1993-1-01' AND L_SHIPDATE < DATE '1993-1-01'+ INTERVAL '1' MONTH;


-- 1993, 2
DROP TABLE IF EXISTS LINEITEM_1993_2;
CREATE TABLE LINEITEM_1993_2 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1993_2
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1993-2-01' AND L_SHIPDATE < DATE '1993-2-01'+ INTERVAL '1' MONTH;


-- 1993, 3
DROP TABLE IF EXISTS LINEITEM_1993_3;
CREATE TABLE LINEITEM_1993_3 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1993_3
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1993-3-01' AND L_SHIPDATE < DATE '1993-3-01'+ INTERVAL '1' MONTH;


-- 1993, 4
DROP TABLE IF EXISTS LINEITEM_1993_4;
CREATE TABLE LINEITEM_1993_4 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1993_4
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1993-4-01' AND L_SHIPDATE < DATE '1993-4-01'+ INTERVAL '1' MONTH;


-- 1993, 5
DROP TABLE IF EXISTS LINEITEM_1993_5;
CREATE TABLE LINEITEM_1993_5 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1993_5
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1993-5-01' AND L_SHIPDATE < DATE '1993-5-01'+ INTERVAL '1' MONTH;


-- 1993, 6
DROP TABLE IF EXISTS LINEITEM_1993_6;
CREATE TABLE LINEITEM_1993_6 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1993_6
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1993-6-01' AND L_SHIPDATE < DATE '1993-6-01'+ INTERVAL '1' MONTH;


-- 1993, 7
DROP TABLE IF EXISTS LINEITEM_1993_7;
CREATE TABLE LINEITEM_1993_7 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1993_7
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1993-7-01' AND L_SHIPDATE < DATE '1993-7-01'+ INTERVAL '1' MONTH;


-- 1993, 8
DROP TABLE IF EXISTS LINEITEM_1993_8;
CREATE TABLE LINEITEM_1993_8 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1993_8
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1993-8-01' AND L_SHIPDATE < DATE '1993-8-01'+ INTERVAL '1' MONTH;


-- 1993, 9
DROP TABLE IF EXISTS LINEITEM_1993_9;
CREATE TABLE LINEITEM_1993_9 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1993_9
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1993-9-01' AND L_SHIPDATE < DATE '1993-9-01'+ INTERVAL '1' MONTH;


-- 1993, 10
DROP TABLE IF EXISTS LINEITEM_1993_10;
CREATE TABLE LINEITEM_1993_10 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1993_10
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1993-10-01' AND L_SHIPDATE < DATE '1993-10-01'+ INTERVAL '1' MONTH;


-- 1993, 11
DROP TABLE IF EXISTS LINEITEM_1993_11;
CREATE TABLE LINEITEM_1993_11 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1993_11
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1993-11-01' AND L_SHIPDATE < DATE '1993-11-01'+ INTERVAL '1' MONTH;


-- 1993, 12
DROP TABLE IF EXISTS LINEITEM_1993_12;
CREATE TABLE LINEITEM_1993_12 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1993_12
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1993-12-01' AND L_SHIPDATE < DATE '1993-12-01'+ INTERVAL '1' MONTH;


-- 1994, 1
DROP TABLE IF EXISTS LINEITEM_1994_1;
CREATE TABLE LINEITEM_1994_1 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1994_1
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1994-1-01' AND L_SHIPDATE < DATE '1994-1-01'+ INTERVAL '1' MONTH;


-- 1994, 2
DROP TABLE IF EXISTS LINEITEM_1994_2;
CREATE TABLE LINEITEM_1994_2 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1994_2
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1994-2-01' AND L_SHIPDATE < DATE '1994-2-01'+ INTERVAL '1' MONTH;


-- 1994, 3
DROP TABLE IF EXISTS LINEITEM_1994_3;
CREATE TABLE LINEITEM_1994_3 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1994_3
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1994-3-01' AND L_SHIPDATE < DATE '1994-3-01'+ INTERVAL '1' MONTH;


-- 1994, 4
DROP TABLE IF EXISTS LINEITEM_1994_4;
CREATE TABLE LINEITEM_1994_4 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1994_4
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1994-4-01' AND L_SHIPDATE < DATE '1994-4-01'+ INTERVAL '1' MONTH;


-- 1994, 5
DROP TABLE IF EXISTS LINEITEM_1994_5;
CREATE TABLE LINEITEM_1994_5 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1994_5
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1994-5-01' AND L_SHIPDATE < DATE '1994-5-01'+ INTERVAL '1' MONTH;


-- 1994, 6
DROP TABLE IF EXISTS LINEITEM_1994_6;
CREATE TABLE LINEITEM_1994_6 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1994_6
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1994-6-01' AND L_SHIPDATE < DATE '1994-6-01'+ INTERVAL '1' MONTH;


-- 1994, 7
DROP TABLE IF EXISTS LINEITEM_1994_7;
CREATE TABLE LINEITEM_1994_7 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1994_7
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1994-7-01' AND L_SHIPDATE < DATE '1994-7-01'+ INTERVAL '1' MONTH;


-- 1994, 8
DROP TABLE IF EXISTS LINEITEM_1994_8;
CREATE TABLE LINEITEM_1994_8 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1994_8
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1994-8-01' AND L_SHIPDATE < DATE '1994-8-01'+ INTERVAL '1' MONTH;


-- 1994, 9
DROP TABLE IF EXISTS LINEITEM_1994_9;
CREATE TABLE LINEITEM_1994_9 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1994_9
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1994-9-01' AND L_SHIPDATE < DATE '1994-9-01'+ INTERVAL '1' MONTH;


-- 1994, 10
DROP TABLE IF EXISTS LINEITEM_1994_10;
CREATE TABLE LINEITEM_1994_10 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1994_10
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1994-10-01' AND L_SHIPDATE < DATE '1994-10-01'+ INTERVAL '1' MONTH;


-- 1994, 11
DROP TABLE IF EXISTS LINEITEM_1994_11;
CREATE TABLE LINEITEM_1994_11 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1994_11
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1994-11-01' AND L_SHIPDATE < DATE '1994-11-01'+ INTERVAL '1' MONTH;


-- 1994, 12
DROP TABLE IF EXISTS LINEITEM_1994_12;
CREATE TABLE LINEITEM_1994_12 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1994_12
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1994-12-01' AND L_SHIPDATE < DATE '1994-12-01'+ INTERVAL '1' MONTH;


-- 1995, 1
DROP TABLE IF EXISTS LINEITEM_1995_1;
CREATE TABLE LINEITEM_1995_1 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1995_1
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1995-1-01' AND L_SHIPDATE < DATE '1995-1-01'+ INTERVAL '1' MONTH;


-- 1995, 2
DROP TABLE IF EXISTS LINEITEM_1995_2;
CREATE TABLE LINEITEM_1995_2 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1995_2
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1995-2-01' AND L_SHIPDATE < DATE '1995-2-01'+ INTERVAL '1' MONTH;


-- 1995, 3
DROP TABLE IF EXISTS LINEITEM_1995_3;
CREATE TABLE LINEITEM_1995_3 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1995_3
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1995-3-01' AND L_SHIPDATE < DATE '1995-3-01'+ INTERVAL '1' MONTH;


-- 1995, 4
DROP TABLE IF EXISTS LINEITEM_1995_4;
CREATE TABLE LINEITEM_1995_4 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1995_4
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1995-4-01' AND L_SHIPDATE < DATE '1995-4-01'+ INTERVAL '1' MONTH;


-- 1995, 5
DROP TABLE IF EXISTS LINEITEM_1995_5;
CREATE TABLE LINEITEM_1995_5 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1995_5
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1995-5-01' AND L_SHIPDATE < DATE '1995-5-01'+ INTERVAL '1' MONTH;


-- 1995, 6
DROP TABLE IF EXISTS LINEITEM_1995_6;
CREATE TABLE LINEITEM_1995_6 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1995_6
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1995-6-01' AND L_SHIPDATE < DATE '1995-6-01'+ INTERVAL '1' MONTH;


-- 1995, 7
DROP TABLE IF EXISTS LINEITEM_1995_7;
CREATE TABLE LINEITEM_1995_7 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1995_7
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1995-7-01' AND L_SHIPDATE < DATE '1995-7-01'+ INTERVAL '1' MONTH;


-- 1995, 8
DROP TABLE IF EXISTS LINEITEM_1995_8;
CREATE TABLE LINEITEM_1995_8 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1995_8
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1995-8-01' AND L_SHIPDATE < DATE '1995-8-01'+ INTERVAL '1' MONTH;


-- 1995, 9
DROP TABLE IF EXISTS LINEITEM_1995_9;
CREATE TABLE LINEITEM_1995_9 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1995_9
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1995-9-01' AND L_SHIPDATE < DATE '1995-9-01'+ INTERVAL '1' MONTH;


-- 1995, 10
DROP TABLE IF EXISTS LINEITEM_1995_10;
CREATE TABLE LINEITEM_1995_10 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1995_10
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1995-10-01' AND L_SHIPDATE < DATE '1995-10-01'+ INTERVAL '1' MONTH;


-- 1995, 11
DROP TABLE IF EXISTS LINEITEM_1995_11;
CREATE TABLE LINEITEM_1995_11 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1995_11
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1995-11-01' AND L_SHIPDATE < DATE '1995-11-01'+ INTERVAL '1' MONTH;


-- 1995, 12
DROP TABLE IF EXISTS LINEITEM_1995_12;
CREATE TABLE LINEITEM_1995_12 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1995_12
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1995-12-01' AND L_SHIPDATE < DATE '1995-12-01'+ INTERVAL '1' MONTH;


-- 1996, 1
DROP TABLE IF EXISTS LINEITEM_1996_1;
CREATE TABLE LINEITEM_1996_1 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1996_1
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1996-1-01' AND L_SHIPDATE < DATE '1996-1-01'+ INTERVAL '1' MONTH;


-- 1996, 2
DROP TABLE IF EXISTS LINEITEM_1996_2;
CREATE TABLE LINEITEM_1996_2 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1996_2
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1996-2-01' AND L_SHIPDATE < DATE '1996-2-01'+ INTERVAL '1' MONTH;


-- 1996, 3
DROP TABLE IF EXISTS LINEITEM_1996_3;
CREATE TABLE LINEITEM_1996_3 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1996_3
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1996-3-01' AND L_SHIPDATE < DATE '1996-3-01'+ INTERVAL '1' MONTH;


-- 1996, 4
DROP TABLE IF EXISTS LINEITEM_1996_4;
CREATE TABLE LINEITEM_1996_4 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1996_4
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1996-4-01' AND L_SHIPDATE < DATE '1996-4-01'+ INTERVAL '1' MONTH;


-- 1996, 5
DROP TABLE IF EXISTS LINEITEM_1996_5;
CREATE TABLE LINEITEM_1996_5 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1996_5
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1996-5-01' AND L_SHIPDATE < DATE '1996-5-01'+ INTERVAL '1' MONTH;


-- 1996, 6
DROP TABLE IF EXISTS LINEITEM_1996_6;
CREATE TABLE LINEITEM_1996_6 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1996_6
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1996-6-01' AND L_SHIPDATE < DATE '1996-6-01'+ INTERVAL '1' MONTH;


-- 1996, 7
DROP TABLE IF EXISTS LINEITEM_1996_7;
CREATE TABLE LINEITEM_1996_7 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1996_7
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1996-7-01' AND L_SHIPDATE < DATE '1996-7-01'+ INTERVAL '1' MONTH;


-- 1996, 8
DROP TABLE IF EXISTS LINEITEM_1996_8;
CREATE TABLE LINEITEM_1996_8 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1996_8
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1996-8-01' AND L_SHIPDATE < DATE '1996-8-01'+ INTERVAL '1' MONTH;


-- 1996, 9
DROP TABLE IF EXISTS LINEITEM_1996_9;
CREATE TABLE LINEITEM_1996_9 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1996_9
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1996-9-01' AND L_SHIPDATE < DATE '1996-9-01'+ INTERVAL '1' MONTH;


-- 1996, 10
DROP TABLE IF EXISTS LINEITEM_1996_10;
CREATE TABLE LINEITEM_1996_10 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1996_10
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1996-10-01' AND L_SHIPDATE < DATE '1996-10-01'+ INTERVAL '1' MONTH;


-- 1996, 11
DROP TABLE IF EXISTS LINEITEM_1996_11;
CREATE TABLE LINEITEM_1996_11 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1996_11
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1996-11-01' AND L_SHIPDATE < DATE '1996-11-01'+ INTERVAL '1' MONTH;


-- 1996, 12
DROP TABLE IF EXISTS LINEITEM_1996_12;
CREATE TABLE LINEITEM_1996_12 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1996_12
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1996-12-01' AND L_SHIPDATE < DATE '1996-12-01'+ INTERVAL '1' MONTH;


-- 1997, 1
DROP TABLE IF EXISTS LINEITEM_1997_1;
CREATE TABLE LINEITEM_1997_1 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1997_1
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1997-1-01' AND L_SHIPDATE < DATE '1997-1-01'+ INTERVAL '1' MONTH;


-- 1997, 2
DROP TABLE IF EXISTS LINEITEM_1997_2;
CREATE TABLE LINEITEM_1997_2 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1997_2
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1997-2-01' AND L_SHIPDATE < DATE '1997-2-01'+ INTERVAL '1' MONTH;


-- 1997, 3
DROP TABLE IF EXISTS LINEITEM_1997_3;
CREATE TABLE LINEITEM_1997_3 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1997_3
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1997-3-01' AND L_SHIPDATE < DATE '1997-3-01'+ INTERVAL '1' MONTH;


-- 1997, 4
DROP TABLE IF EXISTS LINEITEM_1997_4;
CREATE TABLE LINEITEM_1997_4 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1997_4
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1997-4-01' AND L_SHIPDATE < DATE '1997-4-01'+ INTERVAL '1' MONTH;


-- 1997, 5
DROP TABLE IF EXISTS LINEITEM_1997_5;
CREATE TABLE LINEITEM_1997_5 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1997_5
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1997-5-01' AND L_SHIPDATE < DATE '1997-5-01'+ INTERVAL '1' MONTH;


-- 1997, 6
DROP TABLE IF EXISTS LINEITEM_1997_6;
CREATE TABLE LINEITEM_1997_6 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1997_6
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1997-6-01' AND L_SHIPDATE < DATE '1997-6-01'+ INTERVAL '1' MONTH;


-- 1997, 7
DROP TABLE IF EXISTS LINEITEM_1997_7;
CREATE TABLE LINEITEM_1997_7 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1997_7
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1997-7-01' AND L_SHIPDATE < DATE '1997-7-01'+ INTERVAL '1' MONTH;


-- 1997, 8
DROP TABLE IF EXISTS LINEITEM_1997_8;
CREATE TABLE LINEITEM_1997_8 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1997_8
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1997-8-01' AND L_SHIPDATE < DATE '1997-8-01'+ INTERVAL '1' MONTH;


-- 1997, 9
DROP TABLE IF EXISTS LINEITEM_1997_9;
CREATE TABLE LINEITEM_1997_9 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1997_9
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1997-9-01' AND L_SHIPDATE < DATE '1997-9-01'+ INTERVAL '1' MONTH;


-- 1997, 10
DROP TABLE IF EXISTS LINEITEM_1997_10;
CREATE TABLE LINEITEM_1997_10 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1997_10
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1997-10-01' AND L_SHIPDATE < DATE '1997-10-01'+ INTERVAL '1' MONTH;


-- 1997, 11
DROP TABLE IF EXISTS LINEITEM_1997_11;
CREATE TABLE LINEITEM_1997_11 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1997_11
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1997-11-01' AND L_SHIPDATE < DATE '1997-11-01'+ INTERVAL '1' MONTH;


-- 1997, 12
DROP TABLE IF EXISTS LINEITEM_1997_12;
CREATE TABLE LINEITEM_1997_12 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1997_12
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1997-12-01' AND L_SHIPDATE < DATE '1997-12-01'+ INTERVAL '1' MONTH;


-- 1998, 1
DROP TABLE IF EXISTS LINEITEM_1998_1;
CREATE TABLE LINEITEM_1998_1 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1998_1
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1998-1-01' AND L_SHIPDATE < DATE '1998-1-01'+ INTERVAL '1' MONTH;


-- 1998, 2
DROP TABLE IF EXISTS LINEITEM_1998_2;
CREATE TABLE LINEITEM_1998_2 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1998_2
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1998-2-01' AND L_SHIPDATE < DATE '1998-2-01'+ INTERVAL '1' MONTH;


-- 1998, 3
DROP TABLE IF EXISTS LINEITEM_1998_3;
CREATE TABLE LINEITEM_1998_3 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1998_3
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1998-3-01' AND L_SHIPDATE < DATE '1998-3-01'+ INTERVAL '1' MONTH;


-- 1998, 4
DROP TABLE IF EXISTS LINEITEM_1998_4;
CREATE TABLE LINEITEM_1998_4 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1998_4
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1998-4-01' AND L_SHIPDATE < DATE '1998-4-01'+ INTERVAL '1' MONTH;


-- 1998, 5
DROP TABLE IF EXISTS LINEITEM_1998_5;
CREATE TABLE LINEITEM_1998_5 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1998_5
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1998-5-01' AND L_SHIPDATE < DATE '1998-5-01'+ INTERVAL '1' MONTH;


-- 1998, 6
DROP TABLE IF EXISTS LINEITEM_1998_6;
CREATE TABLE LINEITEM_1998_6 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1998_6
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1998-6-01' AND L_SHIPDATE < DATE '1998-6-01'+ INTERVAL '1' MONTH;


-- 1998, 7
DROP TABLE IF EXISTS LINEITEM_1998_7;
CREATE TABLE LINEITEM_1998_7 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1998_7
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1998-7-01' AND L_SHIPDATE < DATE '1998-7-01'+ INTERVAL '1' MONTH;


-- 1998, 8
DROP TABLE IF EXISTS LINEITEM_1998_8;
CREATE TABLE LINEITEM_1998_8 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1998_8
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1998-8-01' AND L_SHIPDATE < DATE '1998-8-01'+ INTERVAL '1' MONTH;


-- 1998, 9
DROP TABLE IF EXISTS LINEITEM_1998_9;
CREATE TABLE LINEITEM_1998_9 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1998_9
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1998-9-01' AND L_SHIPDATE < DATE '1998-9-01'+ INTERVAL '1' MONTH;


-- 1998, 10
DROP TABLE IF EXISTS LINEITEM_1998_10;
CREATE TABLE LINEITEM_1998_10 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1998_10
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1998-10-01' AND L_SHIPDATE < DATE '1998-10-01'+ INTERVAL '1' MONTH;


-- 1998, 11
DROP TABLE IF EXISTS LINEITEM_1998_11;
CREATE TABLE LINEITEM_1998_11 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1998_11
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1998-11-01' AND L_SHIPDATE < DATE '1998-11-01'+ INTERVAL '1' MONTH;


-- 1998, 12
DROP TABLE IF EXISTS LINEITEM_1998_12;
CREATE TABLE LINEITEM_1998_12 ( l_orderkey    INTEGER NOT NULL,
                            l_partkey     INTEGER NOT NULL,
                            l_suppkey     INTEGER NOT NULL,
                            l_linenumber  INTEGER NOT NULL,
                            l_quantity    DECIMAL(15,2) NOT NULL,
                            l_extendedprice  DECIMAL(15,2) NOT NULL,
                            l_discount    DECIMAL(15,2) NOT NULL,
                            l_tax         DECIMAL(15,2) NOT NULL,
                            l_returnflag  CHAR(1) NOT NULL,
                            l_linestatus  CHAR(1) NOT NULL,
                            l_shipdate    DATE NOT NULL,
                            l_commitdate  DATE NOT NULL,
                            l_receiptdate DATE NOT NULL,
                            l_shipinstruct CHAR(25) NOT NULL,
                            l_shipmode     CHAR(10) NOT NULL,
                            l_comment      VARCHAR(44) NOT NULL);
INSERT INTO LINEITEM_1998_12
SELECT *
FROM LINEITEM
WHERE L_SHIPDATE > DATE '1998-12-01' AND L_SHIPDATE < DATE '1998-12-01'+ INTERVAL '1' MONTH;

