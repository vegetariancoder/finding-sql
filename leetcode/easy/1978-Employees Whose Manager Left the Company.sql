drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Employees (employee_id int, name varchar (100), manager_id int, salary int);
insert into Employees (employee_id,name,manager_id,salary) value (3,'Mila',9,60301);
insert into Employees (employee_id,name,manager_id,salary) value (12,'Antonella',null,31000);
insert into Employees (employee_id,name,manager_id,salary) value (13,'Emery',null,67084);
insert into Employees (employee_id,name,manager_id,salary) value (1,'Kalel',11,21241);
insert into Employees (employee_id,name,manager_id,salary) value (9,'Mikaela',null,50937);
insert into Employees (employee_id,name,manager_id,salary) value (11,'Joziah',6,28485);


select
    employee_id
from
    Employees
where
    salary < 30000
and
    manager_id not in (select employee_id from Employees);


