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


with 615_leetcode as (
select
    distinct department_id,
    final_table.pay_month,
    case
        when final_amount>avg_amount then 'higher'
        when final_amount<avg_amount then 'lower'
        when final_amount=avg_amount then 'same'
    end as comparison
from
    (
select
    date_format(pay_date,'%Y-%m') as pay_month,
    avg(amount) as avg_amount
from
    salary
group by
    pay_month) avg_table
right join
(select
     department_id,
    date_format(pay_date,'%Y-%m') as pay_month,
    avg(amount) over (partition by department_id) final_amount
from
    salary
left join
    employee e on salary.employee_id = e.employee_id
where
    date_format(pay_date,'%Y-%m') = '2017-03') final_table
on
    avg_table.pay_month = final_table.pay_month
union all
select
    distinct department_id,
    final_table.pay_month,
    case
        when final_amount>avg_amount then 'higher'
        when final_amount<avg_amount then 'lower'
        when final_amount=avg_amount then 'same'
    end as comparison

from
    (
select
    date_format(pay_date,'%Y-%m') as pay_month,
    avg(amount) as avg_amount
from
    salary
group by
    pay_month) avg_table
right join
(select
     department_id,
    date_format(pay_date,'%Y-%m') as pay_month,
    avg(amount) over (partition by department_id) final_amount
from
    salary
left join
    employee e on salary.employee_id = e.employee_id
where
    date_format(pay_date,'%Y-%m') = '2017-02') final_table
on
    avg_table.pay_month = final_table.pay_month)
select
    pay_month,
    department_id,
    comparison
from
    615_leetcode
order by
    department_id,pay_month;


select

    dept.paymonth,
    department_id,
    case
        when dept_Avg>comp_Avg then 'higher'
        when dept_Avg<comp_Avg then 'lower'
        when dept_Avg=comp_Avg then 'same'
    end as comparison

from
    (
select
    department_id,
    avg(amount) as dept_Avg,
    date_format(pay_date,'%Y-%m') as paymonth
from
    salary
inner join
    employee e on salary.employee_id = e.employee_id
group by
    department_id, date_format(pay_date,'%Y-%m')) dept
left join
(select
    date_format(pay_date,'%Y-%m') as paymonth,
    avg(amount) as comp_Avg
from
    salary
group by
    paymonth) comp
on
    dept.paymonth = comp.paymonth
order by
    department_id,paymonth;
