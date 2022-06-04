drop database leetcode;
create database leetcode;
use leetcode;

CREATE TABLE IF NOT EXISTS Employees (
    employee_id int,
    employee_name varchar(100),
    manager_id int);

insert into Employees (employee_id,employee_name,manager_id) values (1,'Boss',1);
insert into Employees (employee_id,employee_name,manager_id) values (3,'Alice',3);
insert into Employees (employee_id,employee_name,manager_id) values (2,'Bob',1);
insert into Employees (employee_id,employee_name,manager_id) values (4,'Daniel',2);
insert into Employees (employee_id,employee_name,manager_id) values (7,'Luis',4);
insert into Employees (employee_id,employee_name,manager_id) values (8,'Jhon',3);
insert into Employees (employee_id,employee_name,manager_id) values (9,'Angela',8);
insert into Employees (employee_id,employee_name,manager_id) values (77,'Robert',1);

select
    e1.employee_id
from
    Employees e1,
    Employees e2,
    Employees e3
where
    e1.manager_id = e2.employee_id
and
    e2.manager_id = e3.employee_id
and
    e3.manager_id = 1
and
    e1.employee_id != 1;