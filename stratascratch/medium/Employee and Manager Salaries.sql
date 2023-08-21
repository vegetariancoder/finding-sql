use strata;

select * from employee_walmart;

with answer as (
select
    e1.first_name,
    e1.salary,
    e2.salary as manager_id,
    if(e1.salary>e2.salary,'Yes','No') as greater
from
    employee_walmart e1
inner join
    employee_walmart e2
where
    e1.manager_id = e2.id)
select first_name,salary from answer where greater = 'Yes';



with emp_info as (
select
    first_name,
    salary,
    manager_id
from
    employee_walmart)
, manager_info as (
select
    id,
    salary as manager_salary
from
    employee_walmart)
, answer as (
select
    first_name,
    salary,
    manager_salary,
    if(salary>manager_salary,'Yes','No') as greater
from
    emp_info
inner join
    manager_info
on
    emp_info.manager_id = manager_info.id)
select
    first_name,
    salary
from
    answer
where
    greater = 'Yes';

