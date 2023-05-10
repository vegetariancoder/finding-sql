drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists salary (id int, employee_id int , amount int, pay_date date);
insert into salary (id,employee_id,amount,pay_date) value (1,1,9000,'2017-03-31');
insert into salary (id,employee_id,amount,pay_date) value (2,2,6000,'2017-03-31');
insert into salary (id,employee_id,amount,pay_date) value (3,3,10000,'2017-03-31');
insert into salary (id,employee_id,amount,pay_date) value (4,1,7000,'2017-02-28');
insert into salary (id,employee_id,amount,pay_date) value (5,2,6000,'2017-02-28');
insert into salary (id,employee_id,amount,pay_date) value (6,3,8000,'2017-02-28');

Create table If Not Exists employee (employee_id int, department_id int );
insert into employee (employee_id,department_id) value (1,1);
insert into employee (employee_id,department_id) value (2,2);
insert into employee (employee_id,department_id) value (3,2);

with salary_main_table as (
select
    *,
    extract(month from pay_date) as month_value
from
    salary)
, march_avg_salary as (
select
    sum(amount)/count(pay_date) as avg_march_salary
from
    salary_main_table
where
    month_value=3)
, feb_avg_salary as (
select
    sum(amount)/count(pay_date) as avg_feb_salary
from
    salary_main_table
where
    month_value=2
)
, march_result as (
select
    substring(pay_date,1,7) as pay_month,
    department_id,
    case
        when avg(amount)>(select avg_march_salary from march_avg_salary) then 'higher'
        when avg(amount)<(select avg_march_salary from march_avg_salary) then 'lower'
        when avg(amount)=(select avg_march_salary from march_avg_salary) then 'same'
    end as comparison
from
    salary_main_table
inner join
    employee
on
    salary_main_table.employee_id=employee.employee_id
where
    month_value=3
group by
    pay_month,department_id)
, feb_result as (
select
    substring(pay_date,1,7) as pay_month,
    department_id,
    case
        when avg(amount)>(select avg_feb_salary from feb_avg_salary) then 'higher'
        when avg(amount)<(select avg_feb_salary from feb_avg_salary) then 'lower'
        when avg(amount)=(select avg_feb_salary from feb_avg_salary) then 'same'
    end as comparison
from
    salary_main_table
inner join
    employee
on
    salary_main_table.employee_id=employee.employee_id
where
    month_value=2
group by
    pay_month,department_id)
select
    *
from
    feb_result
union all
select
    *
from
    march_result
order by
    department_id;
