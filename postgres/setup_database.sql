CREATE TABLE PART
(

    P_PARTKEY     SERIAL,
    P_NAME        VARCHAR(55),
    P_MFGR        CHAR(25),
    P_BRAND       CHAR(10),
    P_TYPE        VARCHAR(25),
    P_SIZE        INTEGER,
    P_CONTAINER   CHAR(10),
    P_RETAILPRICE DECIMAL,
    P_COMMENT     VARCHAR(23)
);

CREATE TABLE SUPPLIER
(
    S_SUPPKEY   SERIAL,
    S_NAME      CHAR(25),
    S_ADDRESS   VARCHAR(40),
    S_NATIONKEY INTEGER NOT NULL, -- references N_NATIONKEY
    S_PHONE     CHAR(15),
    S_ACCTBAL   DECIMAL,
    S_COMMENT   VARCHAR(101)
);

CREATE TABLE PARTSUPP
(
    PS_PARTKEY    INTEGER NOT NULL, -- references P_PARTKEY
    PS_SUPPKEY    INTEGER NOT NULL, -- references S_SUPPKEY
    PS_AVAILQTY   INTEGER,
    PS_SUPPLYCOST DECIMAL,
    PS_COMMENT    VARCHAR(199)
);

CREATE TABLE CUSTOMER
(
    C_CUSTKEY    SERIAL,
    C_NAME       VARCHAR(25),
    C_ADDRESS    VARCHAR(40),
    C_NATIONKEY  INTEGER NOT NULL, -- references N_NATIONKEY
    C_PHONE      CHAR(15),
    C_ACCTBAL    DECIMAL,
    C_MKTSEGMENT CHAR(10),
    C_COMMENT    VARCHAR(117)
);

CREATE TABLE ORDERS
(
    O_ORDERKEY      SERIAL,
    O_CUSTKEY       INTEGER NOT NULL, -- references C_CUSTKEY
    O_ORDERSTATUS   CHAR(1),
    O_TOTALPRICE    DECIMAL,
    O_ORDERDATE     DATE,
    O_ORDERPRIORITY CHAR(15),
    O_CLERK         CHAR(15),
    O_SHIPPRIORITY  INTEGER,
    O_COMMENT       VARCHAR(79)
);

CREATE TABLE LINEITEM
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

CREATE TABLE NATION
(
    N_NATIONKEY SERIAL,
    N_NAME      CHAR(25),
    N_REGIONKEY INTEGER NOT NULL, -- references R_REGIONKEY
    N_COMMENT   VARCHAR(152)
);

CREATE TABLE REGION
(
    R_REGIONKEY SERIAL,
    R_NAME      CHAR(25),
    R_COMMENT   VARCHAR(152)
);

COPY part FROM '/benchbase/tpch_data/part.tbl' WITH (FORMAT csv, DELIMITER '|');

COPY region FROM '/benchbase/tpch_data/region.tbl' WITH (FORMAT csv, DELIMITER '|');

COPY nation FROM '/benchbase/tpch_data/nation.tbl' WITH (FORMAT csv, DELIMITER '|');

COPY supplier FROM '/benchbase/tpch_data/supplier.tbl' WITH (FORMAT csv, DELIMITER '|');

COPY customer FROM '/benchbase/tpch_data/customer.tbl' WITH (FORMAT csv, DELIMITER '|');

COPY partsupp FROM '/benchbase/tpch_data/partsupp.tbl' WITH (FORMAT csv, DELIMITER '|');

COPY orders FROM '/benchbase/tpch_data/orders.tbl' WITH (FORMAT csv, DELIMITER '|');

COPY lineitem FROM '/benchbase/tpch_data/lineitem.tbl' WITH (FORMAT csv, DELIMITER '|');

ALTER TABLE PART ADD PRIMARY KEY (P_PARTKEY);
ALTER TABLE SUPPLIER ADD PRIMARY KEY (S_SUPPKEY);
ALTER TABLE PARTSUPP ADD PRIMARY KEY (PS_PARTKEY, PS_SUPPKEY);
ALTER TABLE CUSTOMER ADD PRIMARY KEY (C_CUSTKEY);
ALTER TABLE ORDERS ADD PRIMARY KEY (O_ORDERKEY);
ALTER TABLE LINEITEM ADD PRIMARY KEY (L_ORDERKEY, L_LINENUMBER);
ALTER TABLE NATION ADD PRIMARY KEY (N_NATIONKEY);
ALTER TABLE REGION ADD PRIMARY KEY (R_REGIONKEY);

-- foreign keys

ALTER TABLE SUPPLIER ADD FOREIGN KEY (S_NATIONKEY) REFERENCES NATION(N_NATIONKEY);

ALTER TABLE PARTSUPP ADD FOREIGN KEY (PS_PARTKEY) REFERENCES PART(P_PARTKEY);
ALTER TABLE PARTSUPP ADD FOREIGN KEY (PS_SUPPKEY) REFERENCES SUPPLIER(S_SUPPKEY);

ALTER TABLE CUSTOMER ADD FOREIGN KEY (C_NATIONKEY) REFERENCES NATION(N_NATIONKEY);

ALTER TABLE ORDERS ADD FOREIGN KEY (O_CUSTKEY) REFERENCES CUSTOMER(C_CUSTKEY);

ALTER TABLE LINEITEM ADD FOREIGN KEY (L_ORDERKEY) REFERENCES ORDERS(O_ORDERKEY);
ALTER TABLE LINEITEM ADD FOREIGN KEY (L_PARTKEY,L_SUPPKEY) REFERENCES PARTSUPP(PS_PARTKEY,PS_SUPPKEY);

ALTER TABLE NATION ADD FOREIGN KEY (N_REGIONKEY) REFERENCES REGION(R_REGIONKEY);

-- indexes on the foreign keys

CREATE INDEX IDX_SUPPLIER_NATION_KEY ON SUPPLIER (S_NATIONKEY);

CREATE INDEX IDX_PARTSUPP_PARTKEY ON PARTSUPP (PS_PARTKEY);
CREATE INDEX IDX_PARTSUPP_SUPPKEY ON PARTSUPP (PS_SUPPKEY);

CREATE INDEX IDX_CUSTOMER_NATIONKEY ON CUSTOMER (C_NATIONKEY);

CREATE INDEX IDX_ORDERS_CUSTKEY ON ORDERS (O_CUSTKEY);

CREATE INDEX IDX_LINEITEM_ORDERKEY ON LINEITEM (L_ORDERKEY);
CREATE INDEX IDX_LINEITEM_PART_SUPP ON LINEITEM (L_PARTKEY,L_SUPPKEY);

CREATE INDEX IDX_NATION_REGIONKEY ON NATION (N_REGIONKEY);


-- aditional indexes

CREATE INDEX IDX_LINEITEM_SHIPDATE ON LINEITEM (L_SHIPDATE, L_DISCOUNT, L_QUANTITY);

CREATE INDEX IDX_ORDERS_ORDERDATE ON ORDERS (O_ORDERDATE);

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

ALTER TABLE orders_1 ADD PRIMARY KEY (o_1_orderkey);
ALTER TABLE orders_1a ADD PRIMARY KEY (o_1a_orderkey);
ALTER TABLE orders_1b ADD PRIMARY KEY (o_1b_orderkey);
ALTER TABLE orders_2 ADD PRIMARY KEY (o_2_orderkey);
ALTER TABLE orders_2a ADD PRIMARY KEY (o_2a_orderkey);

CREATE INDEX IDX_ORDERS_1_CUSTKEY ON ORDERS_1 (O_1_CUSTKEY);
CREATE INDEX IDX_ORDERS_1A_CUSTKEY ON ORDERS_1A (O_1A_CUSTKEY);

CREATE INDEX IDX_ORDERS_1_ORDERDATE ON ORDERS_1 (O_1_ORDERDATE);
CREATE INDEX IDX_ORDERS_1B_ORDERDATE ON ORDERS_1B (O_1B_ORDERDATE);