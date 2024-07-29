SELECT order_id
FROM OrdersDetails
GROUP BY order_id
HAVING MAX(quantity) > ALL (
    SELECT (SUM(quantity) / COUNT(DISTINCT product_id)) AS avg_quant_order
    FROM OrdersDetails
    GROUP BY order_id
)
ORDER BY order_id ASC;

-- HAVING Clause:
-- HAVING MAX(quantity) > ALL is used to filter out groups where the maximum quantity is greater than the average quantity of every order.
-- Subquery:
-- The subquery calculates the average quantity of each order (SUM(quantity) / COUNT(DISTINCT product_id)) and groups the results by order_id.
-- Comparison:
-- The MAX(quantity) of each order_id from the main query is compared with the average quantities from all orders using the ALL keyword
