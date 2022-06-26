drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Project (project_id int,employee_id int);
insert into Project (project_id,employee_id) value (1,1);
insert into Project (project_id,employee_id) value (1,2);
insert into Project (project_id,employee_id) value (1,3);
insert into Project (project_id,employee_id) value (2,1);
insert into Project (project_id,employee_id) value (2,4);



with 1076_leetcode as (
select
    project_id,
    count(employee_id) as count_values
from
    Project
group by
    project_id)
select
    project_id
from
    1076_leetcode
where
    count_values = (
select
    max(count_values)
from
    (
select
    count(employee_id) as count_values
from
    Project
group by
    project_id) maintable);



with main_table as (
select
    project_id,
    dense_rank() over (order by count(employee_id) desc ) as rankings
from
    Project
group by
    project_id)
select
    project_id
from
    main_table
where
    rankings = 1;