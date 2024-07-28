# Window Functions and WINDOW Clause in SQL

## Window Function
A window function in SQL performs a calculation across a set of table rows that are related to the current row. This set of rows is called the "window" and is defined by the OVER clause. Unlike aggregate functions, window functions do not cause rows to be grouped into a single output row; instead, the rows retain their individual identities.

## Common Window Functions
ROW_NUMBER(): Assigns a unique sequential integer to rows within a partition of the result set.
RANK(): Assigns a rank to rows within a partition of the result set, with gaps in the ranking values.
DENSE_RANK(): Similar to RANK(), but without gaps in the ranking values.
SUM(): Calculates the cumulative sum of a numeric column.
AVG(): Calculates the cumulative average of a numeric column.
MIN() and MAX(): Return the minimum or maximum value within a partition.

```sql
SELECT 
  user_id, 
  quiz_date, 
  ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY quiz_date) AS quiz_number
FROM Quiz;
```

# WINDOW Clause
The WINDOW clause is used to define named window specifications that can be **reused** by multiple window functions within a query. This can make complex queries more readable and reduce repetition.

### Examples with WINDOW Clause for Reusability
```sql
SELECT 
  user_id, 
  quiz_date, 
  ROW_NUMBER() OVER w AS quiz_number, 
  RANK() OVER w AS quiz_rank
FROM Quiz
WINDOW w AS (PARTITION BY user_id ORDER BY quiz_date);
```
--------------------

```sql
SELECT 
  department_id, 
  employee_id, 
  salary, 
  SUM(salary) OVER w AS cumulative_salary, 
  AVG(salary) OVER w AS average_salary
FROM Employees
WINDOW w AS (PARTITION BY department_id ORDER BY salary DESC);
```
