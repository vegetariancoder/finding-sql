drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Student (name varchar(100), continent varchar(100));
insert into Student (name,continent) value ('Jane','America');
insert into Student (name,continent) value ('Pascal','Europe');
insert into Student (name,continent) value ('Xi','Asia');
insert into Student (name,continent) value ('Jack','America');



select * from Student;



select
    America,
    Asia,
    Europe
from
    (
select
    name as America,
    row_number() over () as row_num
from
    Student
where
    continent ='America'
order by
    America) America
left join
(select
    name as Asia,
    row_number() over () as row_num
from
    Student
where
    continent ='Asia'
order by
    Asia) Asia
on
    America.row_num=Asia.row_num
left join
(select
    name as Europe,
    row_number() over () as row_num
from
    Student
where
    continent ='Europe'
order by
    Europe) Europe
on
    America.row_num=Europe.row_num;