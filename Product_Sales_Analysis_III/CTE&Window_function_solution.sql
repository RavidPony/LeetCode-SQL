
WITH CTE AS
(
SELECT
    product_id,
    year,
    quantity,
    price,
    dense_rank() over(partition by product_id order by year asc) as rnk
FROM Sales
)
SELECT
     product_id,
    year AS first_year,
    quantity,
    price
FROM CTE where rnk = 1
