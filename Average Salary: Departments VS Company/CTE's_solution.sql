WITH CTE1 AS (
SELECT s.employee_id, s.amount, s.pay_date,e.department_id,
DATE_FORMAT(s.pay_date, "%Y-%m") as y_m, 
ROUND(AVG(amount) OVER(PARTITION BY DATE_FORMAT(s.pay_date, "%Y-%m")),2) 'company_avg'
FROM salary s join employee e 
ON s.employee_id = e.employee_id
),
CTE2 as (
SELECT y_m as pay_period, department_id, company_avg, ROUND(AVG(amount),2) 'department_avg' 
FROM CTE1 
GROUP  BY department_id, y_m
)
SELECT *, 
	CASE 
		WHEN company_avg < department_avg THEN 'higher'
        WHEN company_avg > department_avg THEN 'lower'
        ELSE 'lower'
	END as 'comparision'
FROM CTE2 
ORDER BY pay_period desc, department_id
