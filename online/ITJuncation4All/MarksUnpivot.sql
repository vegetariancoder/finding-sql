drop database online;
create database online;
use online;

Create Table Subject
(
StudentName varchar(100),
English int,
Maths int,
Science int
);

Insert into Subject Values ('David',85,90,88);
Insert into Subject Values ('John',75,85,80);
Insert into Subject Values ('Tom',83,80,92);


select * from Subject;

with answer as (
select
    StudentName,
    'English' as Subjects,
    English as Marks
from
    Subject
union all
select
    StudentName,
    'Maths' as Subjects,
    Maths as Marks
from
    Subject
union all
select
    StudentName,
    'Science' as Subjects,
    Science as Marks
from
    Subject)
select
    StudentName,
    Subjects,
    Marks
from
    answer
order by
    StudentName;
