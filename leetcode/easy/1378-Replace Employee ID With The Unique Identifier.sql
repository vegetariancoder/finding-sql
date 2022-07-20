
use leetcode;
drop table Employees;
CREATE TABLE IF NOT EXISTS Employees (
    id INT,
    name varchar(100));

insert into Employees (id, name) values (1,'Alice');
insert into Employees (id, name) values (7,'Bob');
insert into Employees (id, name) values (11,'Meir');
insert into Employees (id, name) values (90,'Winston');
insert into Employees (id, name) values (3,'Jonathan');


CREATE TABLE IF NOT EXISTS EmployeeUNI (
    id INT,
    unique_id int);

insert into EmployeeUNI (id, unique_id) values (3,1);
insert into EmployeeUNI (id, unique_id) values (11,2);
insert into EmployeeUNI (id, unique_id) values (90,3);


select
    unique_id,
    name
from
    Employees
left join
    EmployeeUNI
on
    Employees.id = EmployeeUNI.id;


select
    id
from
    Employees
where
    id not in (
select
    Employees.id
from
    Employees
right join
    EmployeeUNI
on
    Employees.id = EmployeeUNI.id);

select
    Employees.id
from
    Employees
left join
    EmployeeUNI
on
    Employees.id = EmployeeUNI.id
where
    unique_id is null;


