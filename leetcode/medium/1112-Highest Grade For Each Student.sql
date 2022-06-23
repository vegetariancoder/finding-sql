drop database leetcode;
create database leetcode;
use leetcode;
create table If Not Exists Enrollments (student_id int, course_id int, grade int);
insert into Enrollments (student_id,course_id,grade) values (2,2,95);
insert into Enrollments (student_id,course_id,grade) values (2,3,95);
insert into Enrollments (student_id,course_id,grade) values (1,1,90);
insert into Enrollments (student_id,course_id,grade) values (1,2,99);
insert into Enrollments (student_id,course_id,grade) values (3,1,80);
insert into Enrollments (student_id,course_id,grade) values (3,2,75);
insert into Enrollments (student_id,course_id,grade) values (3,3,82);



with 1112_leetcode as (
select
    student_id,
    course_id,
    grade,
    dense_rank() over (partition by student_id order by grade desc,course_id) as rankings
from
    Enrollments)
select
    student_id,
    course_id,
    grade
from
    1112_leetcode
where
    rankings =1 ;


