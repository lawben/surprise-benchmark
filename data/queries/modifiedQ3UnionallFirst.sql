with lineitemUNIONALL as (
        select *
        from lineitem1992
        union all
        select *
        from lineitem1993
        union all
        select *
        from lineitem1994
        union all
        select *
        from lineitem1995
        union all
        select *
        from lineitem1996
        union all
        select *
        from lineitem1997
        union all
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
        lineitemUNIONALL
where
        c_mktsegment = 'BUILDING'
        and c_custkey = o_custkey
        and l_orderkey = o_orderkey
group by
        l_orderkey,
        o_orderdate,
        o_shippriority

