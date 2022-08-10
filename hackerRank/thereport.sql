
create database hackerRank;
use hackerRank;

CREATE TABLE IF NOT EXISTS Students (
    id int,
    name varchar(100),
    marks int);

insert into Students (id,name,marks) values (1,'Julia',88);
insert into Students (id,name,marks) values (2,'Samantha',68);
insert into Students (id,name,marks) values (3,'Maria',99);
insert into Students (id,name,marks) values (4,'Scarlet',78);
insert into Students (id,name,marks) values (5,'Ashley',63);
insert into Students (id,name,marks) values (6,'Jane',81);


CREATE TABLE IF NOT EXISTS Grades (
    grade int,
    min_mark int,
    max_mark int);

insert into Grades (grade,min_mark,max_mark) values (1,0,9);
insert into Grades (grade,min_mark,max_mark) values (2,10,19);
insert into Grades (grade,min_mark,max_mark) values (3,20,29);
insert into Grades (grade,min_mark,max_mark) values (4,30,39);
insert into Grades (grade,min_mark,max_mark) values (5,40,49);
insert into Grades (grade,min_mark,max_mark) values (6,50,59);
insert into Grades (grade,min_mark,max_mark) values (7,60,69);
insert into Grades (grade,min_mark,max_mark) values (8,70,79);
insert into Grades (grade,min_mark,max_mark) values (9,80,89);
insert into Grades (grade,min_mark,max_mark) values (10,90,100);


select
    name,
    grade,
    marks
from
    (
select
    name,
    grade,
    marks,
    dense_rank() over (order by grade desc,name) as drnk
from
    Students
inner join
    Grades
on
    Students.marks between Grades.min_mark and Grades.max_mark
where
    grade >= 8) top_students
union all
select
    name,
    grade,
    marks
from
    (
select
    'null' as name,
    grade,
    marks,
    dense_rank() over (order by grade desc,name) as drnk
from
    Students
inner join
    Grades
on
    Students.marks between Grades.min_mark and Grades.max_mark
where
    grade < 8)least_student;