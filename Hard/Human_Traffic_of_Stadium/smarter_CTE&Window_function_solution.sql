--id - row_number() over() as id_diff: Calculates the difference between the id column and the result of the row_number function.
--    row_number() over(): Assigns a unique sequential integer to each row within the result set.
--    id - row_number(): Computes the difference between the id of the row and its row number.
-- where people > 99: Filters the rows to include only those where the people count is greater than 99. only this rows will get a row_number . 

-- select id_diff from q1 group by id_diff having count(*) > 2: 
--    This subquery groups the rows by id_diff and includes only those groups where the count of rows is greater than 2. 
--    Essentially, it finds id_diff values that occur more than twice.

with q1 as (
select *, id - row_number() over() as id_diff
from stadium
where people > 99
)
select id, visit_date, people
from q1
where id_diff in (select id_diff from q1 group by id_diff having count(*) > 2)
order by visit_date
