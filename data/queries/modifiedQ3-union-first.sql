-- TPC-H Query 3
-- Without time filtering


with lineitemUNION as (
        select *
        from lineitem1992
        union
        select *
        from lineitem1993
        union
        select *
        from lineitem1994
        union
        select *
        from lineitem1995
        union
        select *
        from lineitem1996
        union
        select *
        from lineitem1997
        union
        select *
        from lineitem1998
)



select
        l_orderkey,
        sum(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
from
        customer,
        orders,
        lineitemUNION
where
        c_mktsegment = 'BUILDING'
        and c_custkey = o_custkey
        and l_orderkey = o_orderkey
group by
        l_orderkey,
        o_orderdate,
        o_shippriority
