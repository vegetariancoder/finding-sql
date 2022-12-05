drop database leetcode;
create database leetcode;
use leetcode;

create table employee
(
emp_name varchar(10),
dep_id int,
salary int
);
delete from employee;
insert into employee values
('Siva',1,30000),('Ravi',2,40000),('Prasad',1,50000),('Sai',2,20000);

select * from employee;

select
    max_table.dep_id,
    emp_name_max_salary,
    emp_name_min_salary
from
    (
select
    dep_id,
    emp_name as emp_name_max_salary
from
    employee
where
    (dep_id,salary) in (
select
    dep_id,
    max(salary) as max_salary
from
    employee
group by
    dep_id)) max_table
inner join
(
select
    dep_id,
    emp_name as emp_name_min_salary
from
    employee
where
    (dep_id,salary) in (
select
    dep_id,
    min(salary) as max_salary
from
    employee
group by
    dep_id)) min_table
on
    max_table.dep_id=min_table.dep_id
order by
    max_table.dep_id;



