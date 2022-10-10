drop database leetcode;
create database leetcode;
use leetcode;
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
    table_1.name,
    total_visits,
    most_visited_floor,
    resources_used
from
    (
select
    name,
    count(name) as total_visits,
    group_concat(distinct resources) as resources_used
from
    entries
group by
    name) table_1
inner join
    (
select
    name,
    floor as most_visited_floor
from
    (
select
    name,
    floor,
    dense_rank() over (partition by name order by count(floor) desc ) as drnk
from
    entries
group by
    name,floor)calc_table
where
    drnk=1) table_2
on
    table_1.name=table_2.name;
