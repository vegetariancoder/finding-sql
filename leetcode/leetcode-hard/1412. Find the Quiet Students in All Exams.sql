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


select
    distinct exam_id as exam,
    min(score) as min_score,
    max(score) as max_score
from
    Exam
group by
    exam;



with min_max_cte as (
select
    student_id
from
    Exam
where
    (exam_id,score) in (
select
    distinct exam_id as exam,
    min(score) as min_score
from
    Exam
group by
    exam)
union
select
    student_id
from
    Exam
where
    (exam_id,score) in (
select
    distinct exam_id as exam,
    max(score) as max_score
from
    Exam
group by
    exam))
select
    student_id,
    student_name
from
    Student
where
    student_id not in (select student_id from min_max_cte) and student_id in (select distinct student_id from Exam);