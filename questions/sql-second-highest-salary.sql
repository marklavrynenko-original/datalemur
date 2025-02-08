-- https://datalemur.com/questions/sql-second-highest-salary
SELECT distinct salary
FROM employee
order by salary desc
limit 1
offset 1