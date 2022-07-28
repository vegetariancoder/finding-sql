drop database leetcode;
create database leetcode;
use leetcode;

CREATE TABLE IF NOT EXISTS Student (name varchar(100), continent varchar(100));
insert into Student (name, continent) values ('Jane','America');
insert into Student (name, continent) values ('Pascal','Europe');
insert into Student (name, continent) values ('Xi','Asia');
insert into Student (name, continent) values ('Jack','America');

select * from Student;


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