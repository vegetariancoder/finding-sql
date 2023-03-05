use leetcode;
Create table If Not Exists Employee (
     Id int,
     Name varchar(255),
     Department varchar(255),
     ManagerId int);

insert into Employee (Id, Name, Department, ManagerId)
     values ('101', 'John', 'A', null);
insert into Employee (Id, Name, Department, ManagerId)
     values ('102', 'Dan', 'A', '101');
insert into Employee (Id, Name, Department, ManagerId)
     values ('103', 'James', 'A', '101');
insert into Employee (Id, Name, Department, ManagerId)
     values ('104', 'Amy', 'A', '101');
insert into Employee (Id, Name, Department, ManagerId)
     values ('105', 'Anne', 'A', '101');
insert into Employee (Id, Name, Department, ManagerId)
     values ('106', 'Ron', 'B', '101');


select * from Employee;

with answer as (
select
    ManagerId
from
    Employee
where
    id != ManagerId
group by
    ManagerId
having
    count(*) >= 5)
select
    Name
from
    Employee
where
    id in (select ManagerId from answer);