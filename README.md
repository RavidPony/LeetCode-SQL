# SQL exercises
# Code
```

with CTE as (
select dp.name as Department  ,
       em.name as Employee ,
       em.salary as Salary ,
       dense_rank() over (partition by dp.name order by em.salary DESC ) as rank_
from Employee em
join Department dp
on em.departmentId  = dp.id )

select Department, Employee , Salary
from CTE 
where rank_<= 3 
