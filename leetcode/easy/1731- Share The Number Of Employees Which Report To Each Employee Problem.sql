Create table If Not Exists Employees (employee_id int, name varchar(100), reports_to int ,age int );
insert into Employees (employee_id,name, reports_to, age) value (9,'Hercy',null,43);
insert into Employees (employee_id,name, reports_to, age) value (6,'Alice',9,41);
insert into Employees (employee_id,name, reports_to, age) value (4,'Bob',9,36);
insert into Employees (employee_id,name, reports_to, age) value (2,'Winston',null,47);


with 1731_leetcode as (
select
    reports_to as employee_id,
    count(employee_id) as reports_count,
    ceil(avg(age)) as avg_age
from
    (
select
    employee_id,
    name,
    reports_to,
    age
from
    Employees
where
    reports_to is not null) tb
group by
    tb.reports_to)
select
    employee_id,
    name,
    reports_count,
    avg_age
from
    1731_leetcode
inner join
    Employees
using (employee_id);

