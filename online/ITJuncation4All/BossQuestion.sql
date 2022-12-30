drop database online;
create database online;
use online;

Create Table Employee_1(
EmployeeID Varchar(20),
EmployeeName Varchar(20),
ManagerID varchar(20));

Insert Into Employee_1 Values(100,'Mark',103);
Insert Into Employee_1 Values(101,'John',104);
Insert Into Employee_1 Values(102,'Maria',103);
Insert Into Employee_1 Values(103,'Tom',NULL);
Insert Into Employee_1 Values(104, 'David',103);


select
    tab1.EmployeeID,
    tab1.EmployeeName,
    tab1.ManagerID,
    tab2.EmployeeName
from
(select
    e1.EmployeeID,
    e1.EmployeeName,
    e1.ManagerID
from
    Employee_1 e1) tab1
inner join
(select
    e2.EmployeeID,
    e2.EmployeeName,
    e2.ManagerID
from
    Employee_1 e2)tab2
on
    tab1.EmployeeID=tab2.ManagerID;


with answer as (
select
    e1.EmployeeID as emp_id,
    e1.ManagerID,
    e1.EmployeeName as EmployeeName,
    e2.EmployeeName as ManagerName
from
    Employee_1 e1
inner join
    Employee_1 e2
on
    e1.ManagerID=e2.EmployeeID)
select
    EmployeeName,
    ManagerName
from
    answer
order by
    emp_id;




with answer as (
select
    e1.EmployeeID as emp_id,
    e1.ManagerID,
    e1.EmployeeName as EmployeeName,
    e2.EmployeeName as ManagerName
from
    Employee_1 e1
left join
    Employee_1 e2
on
    e1.ManagerID=e2.EmployeeID)
select
    EmployeeName,
    ifnull(ManagerName,'Boss') as ManagerName
from
    answer;



