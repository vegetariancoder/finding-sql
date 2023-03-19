CREATE TABLE IF NOT EXISTS student (
    student_id INT,
    student_name VARCHAR(45),
    gender VARCHAR(6),
    dept_id INT);
CREATE TABLE IF NOT EXISTS department (
    dept_id INT,
    dept_name VARCHAR(255));


insert into student (student_id, student_name, gender, dept_id)
    values ('1', 'Jack', 'M', '1');
insert into student (student_id, student_name, gender, dept_id)
    values ('2', 'Jane', 'F', '1');
insert into student (student_id, student_name, gender, dept_id)
    values ('3', 'Mark', 'M', '2');


insert into department (dept_id, dept_name)
    values ('1', 'Engineering');
insert into department (dept_id, dept_name)
    values ('2', 'Science');
insert into department (dept_id, dept_name)
    values ('3', 'Law');



select
    dept_name,
    count(student_id) as cnt
from
    student
right join
    department
on
    student.dept_id = department.dept_id
group by
    dept_name;


select
    department.dept_id,
    dept_name,
    count(*)
from
    student
right join
    department
on
    student.dept_id = department.dept_id
group by
    department.dept_id, dept_name;