drop database online;
create database online;
use online;

create table emp(
emp_id int,
emp_name varchar(20),
department_id int,
salary int,
manager_id int,
emp_age int);

insert into emp
values
(1, 'Ankit', 100,10000, 4, 39);
insert into emp
values (2, 'Mohit', 100, 15000, 5, 48);
insert into emp
values (3, 'Vikas', 100, 10000,4,37);
insert into emp
values (4, 'Rohit', 100, 5000, 2, 16);
insert into emp
values (5, 'Mudit', 200, 12000, 6,55);
insert into emp
values (6, 'Agam', 200, 12000,2, 14);
insert into emp
values (7, 'Sanjay', 200, 9000, 2,13);
insert into emp
values (8, 'Ashish', 200,5000,2,12);
insert into emp
values (9, 'Mukesh',300,6000,6,51);
insert into emp
values (10, 'Rakesh',300,7000,6,50);

select * from emp;



with calc_table as (
    select
        sum(salary) as total_salary,
        count(salary) as count_salary
    from
        emp
),
    answer as (
select
    department_id,
    avg(salary) as dept_salary,
    ((select total_salary-sum(salary) from calc_table))/((select count_salary-count(salary) from calc_table)) as company_avg_salary
from
    emp
group by
    department_id)
select
    department_id
from
    answer
where
    dept_salary < company_avg_salary;

