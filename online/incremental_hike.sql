drop database online;
create database online;
use online;

create table emp (
    emp_name varchar(100),
    doj date,
    increment_date date,
    salary int
);

insert into emp (emp_name, doj, increment_date, salary)
values ('A', '2003-06-09', '2022-06-09', 100);

insert into emp (emp_name, doj, increment_date, salary)
values ('B', '2010-06-09', '2023-06-09', 200);

insert into emp (emp_name, doj, increment_date, salary)
values ('C', '2015-06-09', '2022-06-09', 250);

insert into emp (emp_name, doj, increment_date, salary)
values ('D', '2012-06-09', '2023-06-09', 400);

insert into emp (emp_name, doj, increment_date, salary)
values ('E', '2018-06-09', '2022-06-09', 90);

insert into emp (emp_name, doj, increment_date, salary)
values ('B', '2010-06-09', '2022-06-09', 280);

insert into emp (emp_name, doj, increment_date, salary)
values ('F', '2010-06-09', '2022-06-09', 120);

insert into emp (emp_name, doj, increment_date, salary)
values ('G', '2020-06-09', '2023-06-09', 80);

insert into emp (emp_name, doj, increment_date, salary)
values ('K', '2010-06-09', '2023-06-09', 40);

insert into emp (emp_name, doj, increment_date, salary)
values ('E', '2018-06-09', '2023-06-09', 110);

insert into emp (emp_name, doj, increment_date, salary)
values ('Z', '2021-06-09', '2023-06-09', 220);

insert into emp (emp_name, doj, increment_date, salary)
values ('A', '2003-06-09', '2023-06-09', 110);

insert into emp (emp_name, doj, increment_date, salary)
values ('C', '2015-06-09', '2023-06-09', 260);

insert into emp (emp_name, doj, increment_date, salary)
values ('B', '2010-06-09', '2021-06-09', 250);

select * from emp order by emp_name,year(increment_date);

with answer as (
select
    *,
    dense_rank() over (partition by emp_name order by year(increment_date) desc ) as date_drnk,
    dense_rank() over (partition by emp_name order by salary desc ) as sal_drnk,
    count(emp_name) over (partition by emp_name) as cnt
from
    emp)
select
    distinct emp_name
from
    answer
where
    date_drnk = sal_drnk and cnt > 1;
