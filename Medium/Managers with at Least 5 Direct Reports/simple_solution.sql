-- We need to find managers with at least five direct reports, which can be done by counting the number of employees who have a particular manager.

SELECT
  m.Name
FROM Employee AS e
JOIN Employee AS m
ON e.ManagerId = m.Id 
GROUP BY m.Name
HAVING COUNT(*) >= 5
ORDER BY m.Name;


-- SELECT m.Name: The query selects the names of the managers.

-- FROM Employee AS e JOIN Employee AS m ON e.ManagerId = m.Id: The query performs a self-join on the Employee table. This means it joins the Employee table to itself to find the managers of employees.

-- e represents the employees.
-- m represents the managers.
-- The condition ON e.ManagerId = m.Id ensures that we join rows from the Employee table where the ManagerId of an employee (e.ManagerId) matches the Id of a manager (m.Id).
-- GROUP BY m.Name: The query groups the results by the manager's name. This allows us to perform aggregate functions on each group of rows that have the same manager.

-- HAVING COUNT(*) >= 5: The query filters the groups to include only those managers who have 5 or more employees. The HAVING clause is used to filter groups after the GROUP BY clause has been applied. COUNT(*) counts the number of employees in each group (i.e., the number of employees per manager).

-- ORDER BY m.Name: Finally, the query sorts the results by the manager's name in ascending order.
