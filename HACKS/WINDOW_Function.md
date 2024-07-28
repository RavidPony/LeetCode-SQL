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
---------
----------



# Query Examples with Window Functions
## Sample Table: `Sales`
### Let's assume we have a table called `Sales` with the following structure and sample data:

```sql
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    salesperson_id INT,
    sale_date DATE,
    amount DECIMAL(10, 2)
);

INSERT INTO Sales (sale_id, salesperson_id, sale_date, amount) VALUES
(1, 101, '2024-01-01', 1500.00),
(2, 101, '2024-01-02', 2300.00),
(3, 101, '2024-01-03', 1800.00),
(4, 102, '2024-01-01', 2500.00),
(5, 102, '2024-01-04', 1700.00),
(6, 103, '2024-01-03', 2200.00),
(7, 103, '2024-01-04', 1300.00),
(8, 103, '2024-01-05', 2700.00);
```

### Query Examples with Window Functions

#### 1. **ROW_NUMBER()**
Assigns a unique sequential integer to rows within a partition.

```sql
SELECT 
  sale_id, 
  salesperson_id, 
  sale_date, 
  amount,
  ROW_NUMBER() OVER (PARTITION BY salesperson_id ORDER BY sale_date) AS sale_number
FROM Sales;
```

#### 2. **RANK()**
Assigns a rank to rows within a partition, with gaps in the ranking values for ties.

```sql
SELECT 
  sale_id, 
  salesperson_id, 
  sale_date, 
  amount,
  RANK() OVER (PARTITION BY salesperson_id ORDER BY amount DESC) AS rank
FROM Sales;
```

#### 3. **DENSE_RANK()**
Similar to `RANK()`, but without gaps in the ranking values for ties.

```sql
SELECT 
  sale_id, 
  salesperson_id, 
  sale_date, 
  amount,
  DENSE_RANK() OVER (PARTITION BY salesperson_id ORDER BY amount DESC) AS dense_rank
FROM Sales;
```

#### 4. **NTILE(n)**
Divides rows in a partition into `n` buckets or groups and assigns a bucket number to each row.

```sql
SELECT 
  sale_id, 
  salesperson_id, 
  sale_date, 
  amount,
  NTILE(2) OVER (PARTITION BY salesperson_id ORDER BY amount DESC) AS bucket
FROM Sales;
```

#### 5. **LAG()**
Provides access to a row at a specified physical offset before the current row within a partition.

```sql
SELECT 
  sale_id, 
  salesperson_id, 
  sale_date, 
  amount,
  LAG(amount, 1) OVER (PARTITION BY salesperson_id ORDER BY sale_date) AS previous_amount
FROM Sales;
```

#### 6. **LEAD()**
Provides access to a row at a specified physical offset after the current row within a partition.

```sql
SELECT 
  sale_id, 
  salesperson_id, 
  sale_date, 
  amount,
  LEAD(amount, 1) OVER (PARTITION BY salesperson_id ORDER BY sale_date) AS next_amount
FROM Sales;
```

### Output Explanation

#### 1. **ROW_NUMBER()**
Each sale is given a sequential number within each `salesperson_id` partition, ordered by `sale_date`.

| sale_id | salesperson_id | sale_date  | amount | sale_number |
|---------|----------------|------------|--------|-------------|
| 1       | 101            | 2024-01-01 | 1500.00| 1           |
| 2       | 101            | 2024-01-02 | 2300.00| 2           |
| 3       | 101            | 2024-01-03 | 1800.00| 3           |
| 4       | 102            | 2024-01-01 | 2500.00| 1           |
| 5       | 102            | 2024-01-04 | 1700.00| 2           |
| 6       | 103            | 2024-01-03 | 2200.00| 1           |
| 7       | 103            | 2024-01-04 | 1300.00| 2           |
| 8       | 103            | 2024-01-05 | 2700.00| 3           |

#### 2. **RANK()**
Each sale is ranked within each `salesperson_id` partition, ordered by `amount` descending. Ties receive the same rank, but gaps are left in the ranking sequence.

| sale_id | salesperson_id | sale_date  | amount | rank |
|---------|----------------|------------|--------|------|
| 2       | 101            | 2024-01-02 | 2300.00| 1    |
| 3       | 101            | 2024-01-03 | 1800.00| 2    |
| 1       | 101            | 2024-01-01 | 1500.00| 3    |
| 4       | 102            | 2024-01-01 | 2500.00| 1    |
| 5       | 102            | 2024-01-04 | 1700.00| 2    |
| 8       | 103            | 2024-01-05 | 2700.00| 1    |
| 6       | 103            | 2024-01-03 | 2200.00| 2    |
| 7       | 103            | 2024-01-04 | 1300.00| 3    |

#### 3. **DENSE_RANK()**
Each sale is given a dense rank within each `salesperson_id` partition, ordered by `amount` descending. Ties receive the same rank, but without gaps in the ranking sequence.

| sale_id | salesperson_id | sale_date  | amount | dense_rank |
|---------|----------------|------------|--------|------------|
| 2       | 101            | 2024-01-02 | 2300.00| 1          |
| 3       | 101            | 2024-01-03 | 1800.00| 2          |
| 1       | 101            | 2024-01-01 | 1500.00| 3          |
| 4       | 102            | 2024-01-01 | 2500.00| 1          |
| 5       | 102            | 2024-01-04 | 1700.00| 2          |
| 8       | 103            | 2024-01-05 | 2700.00| 1          |
| 6       | 103            | 2024-01-03 | 2200.00| 2          |
| 7       | 103            | 2024-01-04 | 1300.00| 3          |

#### 4. **NTILE(n)**
Each sale is placed into one of `n` buckets within each `salesperson_id` partition, ordered by `amount` descending.

| sale_id | salesperson_id | sale_date  | amount | bucket |
|---------|----------------|------------|--------|--------|
| 2       | 101            | 2024-01-02 | 2300.00| 1      |
| 3       | 101            | 2024-01-03 | 1800.00| 1      |
| 1       | 101            | 2024-01-01 | 1500.00| 2      |
| 4       | 102            | 2024-01-01 | 2500.00| 1      |
| 5       | 102            | 2024-01-04 | 1700.00| 2      |
| 8       | 103            | 2024-01-05 | 2700.00| 1      |
| 6       | 103            | 2024-01-03 | 2200.00| 1      |
| 7       | 103            | 2024-01-04 | 1300.00| 2      |

#### 5. **LAG()**
Provides the amount of the previous sale for each row within each `salesperson_id` partition, ordered by `sale_date`.

| sale_id | salesperson_id | sale_date  | amount | previous_amount |
|---------|----------------|------------|--------|-----------------|
| 1       | 101            | 2024-01-01 | 1500.00| NULL            |
| 2       | 101            | 2024-01-02 | 2300.00| 1500.00         |
| 3       | 101            | 2024-01-03 | 1800.00| 2300.00         |
| 4       | 102            | 2024-01-01 | 2500.00| NULL            |
| 5       | 102            | 2024-01-04 | 1700.00| 2500.00         |
| 6       | 103            | 2024-01-03 | 2200.00| NULL            |
| 7       | 103            | 2024-01-04 | 1300.00| 2200.00         |
| 8       | 103            | 2024-01-05 | 2700.00| 1300.00         |

#### 6. **LEAD()**
Provides the amount of the next sale for each row within each `salesperson_id` partition, ordered by `sale_date`.

| sale_id | salesperson_id | sale_date  | amount | next_amount |
|---------|----------------|------------|--------|-------------|
| 1       | 101            | 2024-01-01 | 1500.00| 2300.00     |
| 2       | 101            | 2024-01-02 | 2300.00| 1800.00     |
| 3       | 101            | 2024-01-03 | 1800.00| NULL        |
| 4       | 102            | 2024-01-01 | 2500.00| 1700.00     |
| 5       | 102            | 2024-01-04 | 1700.00| NULL        |
| 6       | 103            | 2024-01-03 | 2200.00| 1300.00     |
| 7       | 103            | 2024-01-04 | 1300.00| 2700.00     |
| 8       | 103            | 2024-01-05 | 2700.00| NULL        |

These examples demonstrate how different window functions can be used to analyze and manipulate data within partitions, providing powerful tools for data analysis.
