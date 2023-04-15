drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Employee (id int, salary int);
insert into Employee (id,salary) value (1,1000);
insert into Employee (id,salary) value (2,2000);
insert into Employee (id,salary) value (3,3000);
insert into Employee (id,salary) value (4,4000);


CREATE PROCEDURE getNthHighestSalary(N INT)
BEGIN
   select
        salary
    from
      (select
          *,
          dense_rank() over (order by salary desc ) as drnk
      from
          Employee) calc
    where
        drnk=N;
END;

CALL getNthHighestSalary(1);


CREATE PROCEDURE getAllEmployeeData()
BEGIN
   select
        *
    from
        Employee;
END;

CALL getAllEmployeeData();