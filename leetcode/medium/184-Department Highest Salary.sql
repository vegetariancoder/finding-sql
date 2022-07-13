use leetcode;
CREATE TABLE IF NOT EXISTS Employee (id int, name varchar(100), salary int, departmentId int);
insert into Employee (id, name,salary,departmentId) values (1,'Joe' ,70000,1);
insert into Employee (id, name,salary,departmentId) values (2,'Jim' ,90000,1);
insert into Employee (id, name,salary,departmentId) values (3,'Henry',80000,2);
insert into Employee (id, name,salary,departmentId) values (4,'Sam' ,60000,2);
insert into Employee (id, name,salary,departmentId) values (5,'Max' ,90000,1);

CREATE TABLE IF NOT EXISTS Department (id int, dept_name varchar(100));
insert into Department (id, dept_name) values (1,'IT');
insert into Department (id, dept_name) values (2,'Sales');


with 184_leetcode as (
select
    dept_name,
    name,
    salary,
    dense_rank() over (partition by dept_name order by salary desc ) as drnk
from
    Employee
left join
    Department
on
    Employee.departmentId = Department.id)
select
    dept_name,
    name,
    salary
from
   184_leetcode
where
    drnk = 1;
