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

select
    name
from
    Employee
where
    id = (
select
    ManagerId
from
    Employee
group by
    ManagerId
having
    count(id) >= 5);






