-- In the subquery, select the product_id and the minimum year for each product by grouping the Sales table by product_id and using the aggregate function min(year). Alias this column as "year".
-- In the main query, select the product_id, year (aliased as "first_year"), quantity, and price columns from the Sales table.
-- Add a filter condition to the main query to include only the rows where the product_id and year values match the results from the subquery.
-- Return the resulting rows.

SELECT product_id, year AS first_year, quantity, price
FROM Sales
WHERE (product_id, year) in (
    SELECT product_id, MIN(year) 
    FROM Sales
    GROUP BY product_id
)

