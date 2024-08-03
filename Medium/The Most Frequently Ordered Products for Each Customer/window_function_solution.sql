SELECT customer_id, product_id, product_name
FROM (
    SELECT customer_id, o.product_id, p.product_name,
           RANK() OVER (PARTITION BY customer_id ORDER BY COUNT(*) DESC) AS rank_count
    FROM Orders o
    JOIN Products p ON p.product_id = o.product_id
    GROUP BY customer_id, o.product_id, p.product_name
) AS ranked_products
WHERE rank_count = 1;

-- Window functions are written in the SELECT clause but are executed after the groups are created in the GROUP BY and HAVING stages. 
-- They are written as part of the SELECT statement, but their execution takes place after the HAVING stage and before the ORDER BY stage.
