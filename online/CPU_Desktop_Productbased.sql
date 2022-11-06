drop database online;
create database online;
use online;

create table entries (
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries
values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR');


select *
from entries;


select
    floor_table.name,
    total_visits,
    most_visited_floor,
    resources_used
from
    (
select
    name,
    floor as most_visited_floor
from
     (
select
    name,
    floor,
    count(floor),
    dense_rank() over (partition by name order by count(floor) desc) as drnk
from
    entries
group by
    name,floor) calc_table
where
    drnk=1) floor_table
inner join
(select
    name,
    count(name) as total_visits
from
    entries
group by
    name) visit_table
on
    floor_table.name=visit_table.name
inner join
(select
    name,
    group_concat(distinct resources) as resources_used
from
    entries
group by
    name) resources_table
on
    floor_table.name = resources_table.name;
