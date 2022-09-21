drop database strata;
create database strata;
use strata;
create table employee
(
id int,
first_name varchar(100),
last_name varchar(100),
age int,
sex varchar(100),
employee_title varchar(100),
department varchar(100),
salary int,
target int,
bonus int,
email varchar(100),
city varchar(100),
address varchar(100),
manager_id int
);

select * from employee;

with answer as (
select
    id,
    first_name,
    salary,
    manager_id
from
    employee)
select
    answer.first_name,
    answer.salary
from
    answer
inner join
    employee
on
    answer.manager_id= employee.id
where
    answer.salary > employee.salary;