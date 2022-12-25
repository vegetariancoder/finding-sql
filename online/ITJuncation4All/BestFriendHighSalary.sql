drop database online;
create database online;
use online;

Create Table Students_Tbl
(
Id int,
Student_Name varchar(30)
);

Insert into Students_Tbl values(1,'Mark');
Insert into Students_Tbl values(2,'David');
Insert into Students_Tbl values(3,'John');
Insert into Students_Tbl values(4,'Albert');

Create Table Friends_Tbl(
Id int,
Friend_Id int
);

Insert into Friends_Tbl values(1,2);
Insert into Friends_Tbl values(2,3);
Insert into Friends_Tbl values(3,4);
Insert into Friends_Tbl values(4,1);

Create Table Package_Tbl
(Id int,
Salary int );

Insert into Package_Tbl values(1,18);
Insert into Package_Tbl values(2,12);
Insert into Package_Tbl values(3,13);
Insert into Package_Tbl values(4,15);

with answer as (
select
    student_table.Id,
    student_table.Friend_Id,
    student_table.student_salary,
    friend_salary,
    if(friend_salary>student_salary,'Yes','No') as flag
from
    (
select
    Friends_Tbl.id,
    Friend_Id,
    Salary as student_salary
from
    Friends_Tbl
inner join
    Package_Tbl
on
    Friends_Tbl.Id=Package_Tbl.Id)student_table
inner join
(select
    Friends_Tbl.id,
    Friends_Tbl.Friend_Id,
    Salary as friend_salary
from
    Friends_Tbl
inner join
    Package_Tbl
on
    Friends_Tbl.Friend_Id=Package_Tbl.Id) friend_table
on
    student_table.id=friend_table.Id
order by
    id)
select
    Student_Name
from
    Students_Tbl
where
    Students_Tbl.Id in (select id from answer where flag='Yes');


