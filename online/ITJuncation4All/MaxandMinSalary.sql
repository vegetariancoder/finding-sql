drop database online;
create database online;
use online;

Create Table Employee_2(
EmpName Varchar(30),
DeptName Varchar(25),
DeptNo Bigint,
Salary Bigint);

Insert into Employee_2 Values('Mark','HR',101,30000);
Insert into Employee_2 Values('John','Accountant',101,20000);
Insert into Employee_2 Values('Smith','Analyst',101,25000);
Insert into Employee_2 Values('Donald','HR',201,40000);
Insert into Employee_2 Values('James','Analyst',201,22000);
Insert into Employee_2 Values('Maria','Analyst',201,38000);
Insert into Employee_2 Values('David','Manager',201,33000);
Insert into Employee_2 Values('Martin','Analyst',301,22000);
Insert into Employee_2 Values('Robert','Analyst',301,56000);
Insert into Employee_2 Values('Michael','Manager',301,34000);
Insert into Employee_2 Values('Robert','Accountant',301,37000);
Insert into Employee_2 Values('Michael','Analyst',301,28000);


select * from Employee_2;

with answer as (
select
    EmpName,
    DeptName,
    Employee_2.DeptNo,
    Salary
from
    Employee_2
inner join
(
select
    DeptNo,
    max(Salary) as max_salary,
    min(Salary) as min_salary
from
    Employee_2
group by
    DeptNo) calc_table
on
    Employee_2.DeptNo=calc_table.DeptNo and Employee_2.Salary=max_salary
union all
select
    EmpName,
    DeptName,
    Employee_2.DeptNo,
    Salary
from
    Employee_2
inner join
(
select
    DeptNo,
    max(Salary) as max_salary,
    min(Salary) as min_salary
from
    Employee_2
group by
    DeptNo) calc_table
on
    Employee_2.DeptNo=calc_table.DeptNo and Employee_2.Salary=min_salary)
select
    *
from
    answer
order by
    DeptNo,Salary;



with answer as (
select
    DeptNo,
    Salary
from
    (
select
    DeptNo,
    Salary,
    dense_rank() over (partition by DeptNo order by Salary) as drnk
from
    Employee_2) min_table
where
    drnk=1
union all
select
    DeptNo,
    Salary
from
    (
select
    DeptNo,
    Salary,
    dense_rank() over (partition by DeptNo order by Salary desc ) as drnk
from
    Employee_2) min_table
where
    drnk=1)
select
    *
from
    answer
order by
    DeptNo,Salary;