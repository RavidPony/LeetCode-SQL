-- window function version
-- We can simply rank salary over each department as partition, and pick the top 3
-- Note that we cannot refer to window column rnk in the WHERE clause. So we must set up a temporary table

WITH department_ranking AS(
SELECT
  e.Name AS Employee
  ,d.Name AS Department
  ,e.Salary
  ,DENSE_RANK() OVER (PARTITION BY DepartmentId ORDER BY Salary DESC) AS rnk
FROM Employee AS e
JOIN Department AS d
ON e.DepartmentId = d.Id
)
SELECT
  Department
  ,Employee
  ,Salary
FROM department_ranking
WHERE rnk <= 3
ORDER BY Department ASC, Salary DESC;
