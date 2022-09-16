drop database strata;
create database strata;
use strata;

CREATE TABLE emp_salary
(
    emp_id INTEGER  NOT NULL,
    name varchar(20)  NOT NULL,
    salary varchar(30),
    dept_id INTEGER
);


INSERT INTO emp_salary
(emp_id, name, salary, dept_id)
VALUES(101, 'sohan', '3000', '11'),
(102, 'rohan', '4000', '12'),
(103, 'mohan', '5000', '13'),
(104, 'cat', '3000', '11'),
(105, 'suresh', '4000', '12'),
(109, 'mahesh', '7000', '12'),
(108, 'kamal', '8000', '11');


select * from emp_salary;

# approach -1

with answer as (
select
    *,
    count(*) over (partition by dept_id,salary) as checks
from
    emp_salary)
select
    emp_id,
    name,
    salary,
    dept_id
from
    answer
where
    checks >1;

# approach -2
with answer as (
select
    salary,
    dept_id
from
    emp_salary
group by
    salary, dept_id
having
    count(*) > 1)
select
    *
from
    emp_salary
where
    (salary,dept_id) in (select salary,dept_id from answer);