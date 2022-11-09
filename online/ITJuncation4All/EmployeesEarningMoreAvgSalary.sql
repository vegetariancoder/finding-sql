drop database online;
create database online;
use online;

CREATE Table Employee
(
EmpID INT,
EmpName Varchar(30),
Salary Float,
DeptID INT
);

INSERT INTO Employee VALUES(1001,'Mark',60000,2);
INSERT INTO Employee VALUES(1002,'Antony',40000,2);
INSERT INTO Employee VALUES(1003,'Andrew',15000,1);
INSERT INTO Employee VALUES(1004,'Peter',35000,1);
INSERT INTO Employee VALUES(1005,'John',55000,1);
INSERT INTO Employee VALUES(1006,'Albert',25000,3);
INSERT INTO Employee VALUES(1007,'Donald',35000,3);

select * from Employee;

select
    DeptID,
    avg(Salary) as avg_salary
from
    Employee
group by
    DeptID;

with answer as (
select
    EmpID,
    EmpName,
    Salary,
    avg_salary,
    Employee.DeptID,
    if(Salary>avg_salary,'Yes','No') as flag
from
    Employee
inner join
    (select
    DeptID,
    avg(Salary) as avg_salary
from
    Employee
group by
    DeptID) calc_table
on
    Employee.DeptID = calc_table.DeptID)
select
    EmpID,
    EmpName,
    Salary
from
    answer
where
    flag='Yes';


select
    EmpID,
    DeptID,
    EmpName,
    Salary
from
    Employee E1
where
    Salary >
(select
    avg(Salary) as avg_salary
from
    Employee E2
where
    E1.DeptID=E2.DeptID);

