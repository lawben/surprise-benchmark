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
--
-- ALTER TABLE PART ADD PRIMARY KEY (P_PARTKEY);
-- ALTER TABLE SUPPLIER ADD PRIMARY KEY (S_SUPPKEY);
-- ALTER TABLE PARTSUPP ADD PRIMARY KEY (PS_PARTKEY, PS_SUPPKEY);
-- ALTER TABLE CUSTOMER ADD PRIMARY KEY (C_CUSTKEY);
-- ALTER TABLE ORDERS ADD PRIMARY KEY (O_ORDERKEY);
-- ALTER TABLE LINEITEM ADD PRIMARY KEY (L_ORDERKEY, L_LINENUMBER);
-- ALTER TABLE NATION ADD PRIMARY KEY (N_NATIONKEY);
-- ALTER TABLE REGION ADD PRIMARY KEY (R_REGIONKEY);
--
-- -- foreign keys
--
-- ALTER TABLE SUPPLIER ADD FOREIGN KEY (S_NATIONKEY) REFERENCES NATION(N_NATIONKEY);
--
-- ALTER TABLE PARTSUPP ADD FOREIGN KEY (PS_PARTKEY) REFERENCES PART(P_PARTKEY);
-- ALTER TABLE PARTSUPP ADD FOREIGN KEY (PS_SUPPKEY) REFERENCES SUPPLIER(S_SUPPKEY);
--
-- ALTER TABLE CUSTOMER ADD FOREIGN KEY (C_NATIONKEY) REFERENCES NATION(N_NATIONKEY);
--
-- ALTER TABLE ORDERS ADD FOREIGN KEY (O_CUSTKEY) REFERENCES CUSTOMER(C_CUSTKEY);
--
-- ALTER TABLE LINEITEM ADD FOREIGN KEY (L_ORDERKEY) REFERENCES ORDERS(O_ORDERKEY);
-- ALTER TABLE LINEITEM ADD FOREIGN KEY (L_PARTKEY,L_SUPPKEY) REFERENCES PARTSUPP(PS_PARTKEY,PS_SUPPKEY);
--
-- ALTER TABLE NATION ADD FOREIGN KEY (N_REGIONKEY) REFERENCES REGION(R_REGIONKEY);

------------------------------------------------------------------------------------------------------------------------
-- tables for split queries
------------------------------------------------------------------------------------------------------------------------

drop table if exists orders_1;
create table orders_1
(
    o_1_orderkey      integer        not null,
    o_1_custkey       integer        not null,
    o_1_orderstatus   char(1)        not null,
    o_1_totalprice    decimal(15, 2) not null,
    o_1_orderdate     date           not null
);

drop table if exists orders_1a;
create table orders_1a
(
    o_1a_orderkey      integer        not null,
    o_1a_custkey       integer        not null,
    o_1a_orderstatus   char(1)        not null
);

drop table if exists orders_1b;
create table orders_1b
(
    o_1b_orderkey      integer        not null,
    o_1b_totalprice    decimal(15, 2) not null,
    o_1b_orderdate     date           not null
);

drop table if exists orders_2;
create table orders_2
(
    o_2_orderkey      integer        not null,
    o_2_orderpriority char(15)       not null,
    o_2_clerk         char(15)       not null,
    o_2_shippriority  integer        not null,
    o_2_comment       varchar(79)    not null
);

drop table if exists orders_2a;
create table orders_2a
(
    o_2a_orderkey      integer        not null,
    o_2a_orderpriority char(15)       not null,
    o_2a_clerk         char(15)       not null,
    o_2a_shippriority  integer        not null,
    o_2a_comment       varchar(79)    not null
);

insert into orders_1
select o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate
from orders;

insert into orders_1a
select o_orderkey, o_custkey, o_orderstatus
from orders;

insert into orders_1b
select o_orderkey, o_totalprice, o_orderdate
from orders;

insert into orders_2
select o_orderkey, o_orderpriority, o_clerk, o_shippriority, o_comment
from orders;

insert into orders_2a
select o_orderkey, o_orderpriority, o_clerk, o_shippriority, o_comment
from orders;

-- ALTER TABLE orders_1 ADD PRIMARY KEY (o_1_orderkey);
-- ALTER TABLE orders_1a ADD PRIMARY KEY (o_1a_orderkey);
-- ALTER TABLE orders_1b ADD PRIMARY KEY (o_1b_orderkey);
-- ALTER TABLE orders_2 ADD PRIMARY KEY (o_2_orderkey);
-- ALTER TABLE orders_2a ADD PRIMARY KEY (o_2a_orderkey);