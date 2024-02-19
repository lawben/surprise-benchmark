
(
-- 1992, 1
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1992_1
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1992, 2
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1992_2
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1992, 3
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1992_3
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1992, 4
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1992_4
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1992, 5
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1992_5
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1992, 6
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1992_6
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1992, 7
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1992_7
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1992, 8
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1992_8
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1992, 9
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1992_9
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1992, 10
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1992_10
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1992, 11
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1992_11
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1992, 12
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1992_12
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1993, 1
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1993_1
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1993, 2
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1993_2
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1993, 3
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1993_3
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1993, 4
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1993_4
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1993, 5
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1993_5
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1993, 6
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1993_6
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1993, 7
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1993_7
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1993, 8
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1993_8
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1993, 9
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1993_9
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1993, 10
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1993_10
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1993, 11
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1993_11
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1993, 12
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1993_12
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1994, 1
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1994_1
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1994, 2
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1994_2
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1994, 3
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1994_3
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1994, 4
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1994_4
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1994, 5
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1994_5
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1994, 6
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1994_6
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1994, 7
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1994_7
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1994, 8
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1994_8
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1994, 9
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1994_9
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1994, 10
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1994_10
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1994, 11
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1994_11
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1994, 12
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1994_12
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1995, 1
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1995_1
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1995, 2
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1995_2
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1995, 3
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1995_3
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1995, 4
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1995_4
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1995, 5
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1995_5
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1995, 6
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1995_6
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1995, 7
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1995_7
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1995, 8
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1995_8
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1995, 9
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1995_9
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1995, 10
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1995_10
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1995, 11
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1995_11
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1995, 12
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1995_12
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1996, 1
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1996_1
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1996, 2
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1996_2
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1996, 3
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1996_3
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1996, 4
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1996_4
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1996, 5
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1996_5
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1996, 6
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1996_6
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1996, 7
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1996_7
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1996, 8
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1996_8
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1996, 9
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1996_9
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1996, 10
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1996_10
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1996, 11
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1996_11
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1996, 12
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1996_12
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1997, 1
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1997_1
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1997, 2
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1997_2
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1997, 3
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1997_3
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1997, 4
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1997_4
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1997, 5
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1997_5
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1997, 6
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1997_6
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1997, 7
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1997_7
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1997, 8
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1997_8
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1997, 9
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1997_9
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1997, 10
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1997_10
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1997, 11
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1997_11
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1997, 12
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1997_12
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1998, 1
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1998_1
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1998, 2
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1998_2
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1998, 3
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1998_3
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1998, 4
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1998_4
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1998, 5
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1998_5
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1998, 6
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1998_6
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1998, 7
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1998_7
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1998, 8
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1998_8
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1998, 9
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1998_9
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1998, 10
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1998_10
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1998, 11
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1998_11
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)
UNION ALL
(
-- 1998, 12
SELECT
        l_orderkey,
        SUM(l_extendedprice * (1 - l_discount)) as revenue,
        o_orderdate,
        o_shippriority
FROM
        customer,
        orders,
        LINEITEM_1998_12
WHERE
        c_mktsegment = 'BUILDING'
        AND c_custkey = o_custkey
        AND l_orderkey = o_orderkey
GROUP BY
        l_orderkey,
        o_orderdate,
        o_shippriority
)

