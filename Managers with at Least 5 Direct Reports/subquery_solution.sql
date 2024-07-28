--Use a subquery to identify the managerId values that have at least five direct reports. 
--This is done by grouping the employees by their managerId and using the HAVING clause to filter for counts greater than or equal to 5.
--Then use the IN clause to select the name of employees whose id matches the managerId values found in the subquery, effectively finding the names of managers with at least five direct reports.


select name 
from employee 
where id in
(select managerId 
from Employee
Group by managerId
Having count(managerId)>=5)
