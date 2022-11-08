drop database online;
create database online;
use online;

CREATE TABLE Student(
Student_Name varchar(30),
Total_Marks  int ,
Year int);

INSERT INTO Student VALUES('Rahul',90,2010);
INSERT INTO Student VALUES('Sanjay',80,2010);
INSERT INTO Student VALUES('Mohan',70,2010);
INSERT INTO Student VALUES('Rahul',90,2011);
INSERT INTO Student VALUES('Sanjay',85,2011);
INSERT INTO Student VALUES('Mohan',65,2011);
INSERT INTO Student VALUES('Rahul',80,2012);
INSERT INTO Student VALUES('Sanjay',80,2012);
INSERT INTO Student VALUES('Mohan',90,2012);

select * from Student;

with answer as (
select
    Student_Name,
    Total_Marks,
    max(Year) as Year
from
     (
select
    *,
    dense_rank() over (partition by Student_Name order by Total_Marks desc ) as rno
from
    Student
) calc_table
where
    rno=1
group by
    Student_Name, Total_Marks)
select
    answer.Student_Name,
    answer.Total_Marks,
    answer.Year,
    Student.Total_Marks
from
    answer
left join
    Student
on
    answer.Year-1 = Student.Year and answer.Student_Name=Student.Student_Name
order by
    answer.Year;