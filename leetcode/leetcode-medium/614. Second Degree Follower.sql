drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Employee (followee varchar(100), follower varchar(100));
insert into Employee (followee,follower) value ('Alice','Bob');
insert into Employee (followee,follower) value ('Bob','Cena');
insert into Employee (followee,follower) value ('Bob','Donald');
insert into Employee (followee,follower) value ('Donald','Edward');

with answer as (
select
    followee
from
    Employee
where
    followee in (select follower from Employee))
select
    followee,
    count(*) as cnt
from
    answer
group by
    followee;