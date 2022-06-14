drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Project (project_id int,employee_id int);
insert into Project (project_id,employee_id) value (1,1);
insert into Project (project_id,employee_id) value (1,2);
insert into Project (project_id,employee_id) value (1,3);
insert into Project (project_id,employee_id) value (2,1);
insert into Project (project_id,employee_id) value (2,4);


Create table If Not Exists Employee (employee_id int,name varchar(100), experience_years int);
insert into Employee (employee_id,name,experience_years) value (1,'khaled',3);
insert into Employee (employee_id,name,experience_years) value (2,'Ali',2);
insert into Employee (employee_id,name,experience_years) value (3,'John',3);
insert into Employee (employee_id,name,experience_years) value (4,'Doe',2);

with 1077_leetcode as (
select
    project_id,
    E.employee_id,
    dense_rank() over (partition by project_id order by max(experience_years)) as ranks
from
    Project
inner join
    Employee E on Project.employee_id = E.employee_id
group by
    project_id, E.employee_id)
select
    project_id,
    employee_id
from
    1077_leetcode
where
    ranks = 2;


with main_table as (
select
    employee_id
from
    Employee
where
    experience_years in (
select
    max(experience_years) max_expr
from
    Project
inner join
    Employee E on Project.employee_id = E.employee_id
group by
    project_id))
select
    project_id,
    Project.employee_id
from
    Project
inner join
    main_table
on
    Project.employee_id = main_table.employee_id;



