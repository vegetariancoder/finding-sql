drop database leetcode;
create database leetcode;
use leetcode;

CREATE TABLE IF NOT EXISTS Student (name varchar(100), continent varchar(100));
insert into Student (name, continent) values ('Jane','America');
insert into Student (name, continent) values ('Pascal','Europe');
insert into Student (name, continent) values ('Xi','Asia');
insert into Student (name, continent) values ('Jack','America');

select * from Student;

create table players_location
(
name varchar(20),
city varchar(20)
);

insert into players_location
values ('Sachin','Mumbai'),('Virat','Delhi') , ('Rahul','Bangalore'),('Rohit','Mumbai'),('Mayank','Bangalore');


select
    America,
    Asia,
    Europe
from
    (
with america_cte as (
select
    case
        when continent='America' then name
    end as America
from
    Student)
select
    row_number() over (order by America) as row_num_america,
    America
from
    america_cte
where
    America is not null) America_tb
left join
(
with asia_cte as (
select
    case
        when continent='Asia' then name
    end as Asia
from
    Student)
select
    row_number() over (order by Asia) as row_num_asia,
    Asia
from
    asia_cte
where
    Asia is not null) Asia_tb
on
    America_tb.row_num_america=Asia_tb.row_num_asia
left join
(with europe_cte as (
select
    case
        when continent='Europe' then name
    end as Europe
from
    Student)
select
    row_number() over (order by Europe) as row_num_europe,
    Europe
from
    europe_cte
where
    Europe is not null) Europe_tb
on
    America_tb.row_num_america = Europe_tb.row_num_europe;





select * from players_location;


select
    Bangalore,
    Mumbai,
    Delhi
from
    (
select
    Bangalore,
    row_number() over (order by Bangalore desc ) as rno
from
    (
select
    case
        when city='Bangalore' then name
    end as 'Bangalore'
from
    players_location
order by
    Bangalore desc) table1) bangalore
inner join
(select
    Mumbai,
    row_number() over (order by Mumbai desc ) as rno
from
    (
select
    case
        when city='Mumbai' then name
    end as 'Mumbai'
from
    players_location
order by
    Mumbai desc) table2) mumbai
on
    bangalore.rno = mumbai.rno
inner join
(select
    Delhi,
    row_number() over (order by Delhi desc ) as rno
from
    (
select
    case
        when city='Delhi' then name
    end as 'Delhi'
from
    players_location
order by
    Delhi desc) table2) delhi
on
    Bangalore.rno=delhi.rno
limit 2;




select * from players_location;


select
    max(case
        when city='Bangalore' then name
    end) as  Bangalore,
    max(case
        when city='Mumbai' then name
    end) as  Mumbai,
    max(case
        when city='Delhi' then name
    end) as  Delhi
from
    (
select
    *,
    row_number() over (partition by city order by name) as r_no
from
    players_location) calculated_table
group by
    r_no;