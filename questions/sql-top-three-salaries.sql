-- https://datalemur.com/questions/sql-top-three-salaries
select department_name, name, salary
from (
  SELECT department_name, name, salary,
  dense_rank() over (partition by d.department_id order by salary desc) as rn
  FROM employee e join department d on e.department_id = d.department_id
) A
where A.rn <= 3
order by department_name, salary desc, name asc