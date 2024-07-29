
WITH OrderStats AS (
    SELECT
        order_id,
        MAX(quantity) AS max_quantity,
        SUM(quantity) / COUNT(product_id) AS avg_quantity
    FROM
        OrdersDetails
    GROUP BY
        order_id
),
OverallAverage AS (
    SELECT
        AVG(quantity) AS overall_avg_quantity
    FROM
        OrdersDetails
),
ImbalancedOrders AS (
    SELECT
        os.order_id
    FROM
        OrderStats os,
        OverallAverage oa
    WHERE
        os.max_quantity > oa.overall_avg_quantity
)

SELECT DISTINCT
    order_id
FROM
    ImbalancedOrders
ORDER BY
    order_id;

-- OrderStats CTE:
-- This Common Table Expression (CTE) calculates the maximum quantity (MAX(quantity)) and the average quantity (SUM(quantity) / COUNT(product_id)) for each order_id.
-- OverallAverage CTE:
-- This CTE calculates the overall average quantity (AVG(quantity)) across all orders.
-- ImbalancedOrders CTE:
-- This CTE selects order_id from OrderStats where the max_quantity is greater than the overall average quantity (overall_avg_quantity).
-- Final SELECT Statement:
-- The final query selects distinct order_ids from the ImbalancedOrders CTE and orders them by order_id.






