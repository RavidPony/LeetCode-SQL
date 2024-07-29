SELECT customer_id, product_id, product_name
FROM (
    SELECT customer_id, o.product_id, p.product_name,
           RANK() OVER (PARTITION BY customer_id ORDER BY COUNT(*) DESC) AS rank_count
    FROM Orders o
    JOIN Products p ON p.product_id = o.product_id
    GROUP BY customer_id, o.product_id, p.product_name
) AS ranked_products
WHERE rank_count = 1;

-- First, the GROUP BY operation is performed on customer_id, product_id, product_name, and then the RANK() operation is executed.
-- JOIN: Joining the Orders and Products tables based on the product identifier (product_id). This allows combining data about the products with the orders they are included in.
-- GROUP BY customer_id, product_id, product_name: Groups the records by three attributes - customer identity, product identifier, and product name. This allows calculating the order count for each combination of customer and product.
-- COUNT(*): At this stage, for each group created after the GROUP BY, the count of records is calculated. This gives the number of orders each customer has made for each product.
-- RANK() OVER (PARTITION BY customer_id ORDER BY COUNT(*) DESC): The RANK() function is applied after obtaining the total number of orders for each combination of customer and product. It is applied to each group (partition) of customer (customer_id), where the records are sorted by the number of orders in descending order. This returns a ranking of the products for each customer, where the product with the highest number of orders gets the highest rank (1).
-- Therefore, the RANK() function is always executed after the different groups have been created and the counts have been completed using the GROUP BY.
