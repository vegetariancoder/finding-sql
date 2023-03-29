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


with answer as (
select
    Employee.name,
    Employee.salary,
    Department.dept_name,
    rank() over (partition by dept_name order by salary desc ) as rnk
from
    Employee
inner join
    Department
on
    Employee.departmentId=Department.id)
select
    name,
    salary,
    dept_name
from
    answer
where
    rnk=1
order by
    name;