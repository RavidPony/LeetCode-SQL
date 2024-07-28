-- option 1 
SELECT
  t.Request_at AS Day
  ,ROUND(SUM(t.Status != "completed") / COUNT(*), 2) AS 'Cancellation Rate'
FROM Trips t
JOIN Users d ON t.Driver_Id = d.Users_Id
JOIN Users c ON t.Client_Id = c.Users_Id
WHERE d.Banned = "No"
  AND c.Banned = "No"
  AND t.Request_at BETWEEN "2013-10-01" AND "2013-10-03"
GROUP BY t.Request_at
ORDER BY t.Request_at;


-- option 2 
SELECT
  t.Request_at AS Day
  ,ROUND(SUM(t.Status != "completed") / COUNT(*), 2) AS 'Cancellation Rate'
FROM Trips t
JOIN Users d 
  ON t.Driver_Id = d.Users_Id 
  AND d.Banned = 'No'
  AND t.Request_at BETWEEN "2013-10-01" AND "2013-10-03"
JOIN Users c 
  ON t.Client_Id = c.Users_Id 
  And c.Banned = 'No'
GROUP BY t.Request_at;

--option 3 
SELECT
  Request_at AS Day
  ,ROUND(SUM(Status != "completed") / COUNT(*), 2) AS 'Cancellation Rate'
FROM Trips
WHERE Request_at BETWEEN "2013-10-01" AND "2013-10-03"
  AND Driver_Id IN (SELECT Users_Id FROM Users WHERE Banned = 'No')
  AND Client_Id IN (SELECT Users_Id FROM Users WHERE Banned = 'No')
GROUP BY Request_at;
