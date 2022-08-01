drop database leetcode;
create database leetcode;
use leetcode;

Create table If Not Exists Student (student_id int, student_name varchar(100));

insert into Student (student_id,student_name) values(1,'Daniel');
insert into Student (student_id,student_name) values(2,'Jade');
insert into Student (student_id,student_name) values(3,'Stella');
insert into Student (student_id,student_name) values(4,'Jonathan');
insert into Student (student_id,student_name) values(5,'Will');


Create table If Not Exists Exam (exam_id int, student_id int, score int);

insert into Exam (exam_id,student_id,score) values(10,1,70);
insert into Exam (exam_id,student_id,score) values(10,2,80);
insert into Exam (exam_id,student_id,score) values(10,3,90);
insert into Exam (exam_id,student_id,score) values(20,1,80);
insert into Exam (exam_id,student_id,score) values(30,1,70);
insert into Exam (exam_id,student_id,score) values(30,3,80);
insert into Exam (exam_id,student_id,score) values(30,4,90);
insert into Exam (exam_id,student_id,score) values(40,1,60);
insert into Exam (exam_id,student_id,score) values(40,2,70);
insert into Exam (exam_id,student_id,score) values(40,4,80);

with 1412_leetcode as (
select
    student_id
from
    (
select
    *,
    dense_rank() over (partition by exam_id order by score) as drnk
from
    Exam) ranking_tab
where
    drnk not in (1,3)
group by
    student_id
having
    count(1) >=2)
select
    student_id,
    student_name
from
    Student
right join
    1412_leetcode
using
    (student_id);