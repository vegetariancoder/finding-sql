use leetcode;

CREATE TABLE IF NOT EXISTS Employee (id int, salary float);
insert into Employee (id, salary) values (1,100);
insert into Employee (id, salary) values (1,200);
insert into Employee (id, salary) values (1,300);
insert into Employee (id, salary) values (1,400);
insert into Employee (id, salary) values (1,500);



select
    max(salary) as second_highest_salary
from
    Employee
where
    salary < (select max(salary) from Employee);


select
    salary
from
    Employee
order by
    salary
limit 1
offset 2;