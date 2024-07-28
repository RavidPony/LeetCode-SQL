-- Approach
-- Joining Employee and Department Tables:

-- Use the JOIN operation to combine the Employee and Department tables based on the departmentId field.
-- Ranking Salaries within Each Department:

-- Apply the DENSE_RANK() window function to assign a rank to each employee's salary within their department. The ranking is done in descending order of salaries.
-- Filtering Top Three Salaries:

-- Wrap the previous steps in a subquery (rnk_tbl) to obtain the ranked results.
-- Select the records where the rank is less than or equal to 3, indicating the top three salaries in each department.
-- Final Result:

-- Retrieve the desired columns (Department, Employee, Salary) for the final output.

SELECT dp.name AS Department,
       em.name AS Employee,
       em.salary AS Salary
FROM (
    SELECT em.*, 
           dp.name AS Department, 
           DENSE_RANK() OVER (PARTITION BY dp.name ORDER BY em.salary DESC) AS rank_
    FROM Employee em
    JOIN Department dp ON em.departmentId = dp.id
) subquery
WHERE rank_ <= 3
ORDER BY Department, rank_;
