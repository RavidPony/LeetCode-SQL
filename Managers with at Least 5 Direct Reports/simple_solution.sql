-- We need to find managers with at least five direct reports, which can be done by counting the number of employees who have a particular manager.

SELECT
  m.Name
FROM Employee AS e
JOIN Employee AS m
ON e.ManagerId = m.Id 
GROUP BY m.Name
HAVING COUNT(*) >= 5
ORDER BY m.Name;
