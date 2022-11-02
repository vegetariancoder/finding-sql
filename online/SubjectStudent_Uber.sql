drop database online;
create database online;
use online;

create table marks_data(student_id int, subject varchar(50), marks int);
insert into marks_data values(1001, "English", 88);
insert into marks_data values(1001, "Science", 90);
insert into marks_data values(1001, "Maths", 85);
insert into marks_data values(1002, "English", 70);
insert into marks_data values(1002, "Science", 80);
insert into marks_data values(1002, "Maths", 83);


select
    student_id,
    sum(case
        when subject='English' then marks
    end) as English,
    sum(case
        when subject='Science' then marks
    end) as Science,
    sum(case
        when subject='Maths' then marks
    end) as Maths
from
    marks_data
group by
    student_id;