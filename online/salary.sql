drop database online;
create database online;
use online;


create table emp  (
    emp_id int,
    name varchar(100),
    salary int
);

insert into emp (emp_id, name, salary)
values (2,'meir',3000);
insert into emp (emp_id, name, salary)
values (3,'mike',3000);
insert into emp (emp_id, name, salary)
values (7,'addilyn',7400);
insert into emp (emp_id, name, salary)
values (8,'juan',6100);
insert into emp (emp_id, name, salary)
values (9,'kannon',7400);

select * from emp;

with cte as (
select
    *,
    dense_rank() over (order by salary) as drnk
from
    emp),
cte2 as (
select
    *,
    count(emp_id) over (partition by drnk) as cnt
from
    cte),
answer as (
select
    *
from
    cte2)
select emp_id,name,salary, dense_rank() over (order by salary) as team_id from answer where cnt>1;