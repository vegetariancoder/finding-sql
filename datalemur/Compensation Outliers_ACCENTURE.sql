drop database datalemur;
create database datalemur;
use datalemur;


Create table If Not Exists employee_pay (employee_id int, salary int, title varchar(100));
insert into employee_pay (employee_id, salary,title ) values (101,80000,'Data Analyst');
insert into employee_pay (employee_id, salary,title ) values (102,90000,'Data Analyst');
insert into employee_pay (employee_id, salary,title ) values (103,100000,'Data Analyst');
insert into employee_pay (employee_id, salary,title ) values (104,30000,'Data Analyst');
insert into employee_pay (employee_id, salary,title ) values (105,120000,'Data Scientist');
insert into employee_pay (employee_id, salary,title ) values (106,100000,'Data Scientist');
insert into employee_pay (employee_id, salary,title ) values (107,80000,'Data Scientist');
insert into employee_pay (employee_id, salary,title ) values (108,310000,'Data Scientist');


with answer as (
select
    employee_id,
    salary,
    employee_pay_table.title,
    avg_salary,
    double_times_salary,
    half_salary,
    case
        when salary >=double_times_salary then 'overpaid'
        when salary <=half_salary then 'underpaid'
    end as status
from
    (
select
    title,
    avg_salary,
    avg_salary*2 as double_times_salary,
    round(avg_salary/2,0) as half_salary
from
    (
select
    title,
    round(avg(salary),0) as avg_salary
from
    employee_pay
group by
    title)salary_calc)calc_table
right join
(select
     employee_id,
     salary,
     title
 from
     employee_pay) as employee_pay_table
on
    calc_table.title=employee_pay_table.title)
select
    employee_id,
    salary,
    status
from
    answer
where
    status is not null;
