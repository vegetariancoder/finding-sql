drop database leetcode;
create database leetcode;
use leetcode;

CREATE TABLE IF NOT EXISTS Employee (id int, month int, salary int);
insert into Employee (id, month, salary) values (1,1,20);
insert into Employee (id, month, salary) values (2,1,20);
insert into Employee (id, month, salary) values (1,2,30);
insert into Employee (id, month, salary) values (2,2,30);
insert into Employee (id, month, salary) values (3,2,40);
insert into Employee (id, month, salary) values (1,3,40);
insert into Employee (id, month, salary) values (3,3,60);
insert into Employee (id, month, salary) values (1,4,60);
insert into Employee (id, month, salary) values (3,4,70);
insert into Employee (id, month, salary) values (1,7,90);
insert into Employee (id, month, salary) values (1,8,90);


select * from Employee;


select
    e1.id,
    e1.month,
    (ifnull(e1.salary,0) + ifnull(e2.salary,0) + ifnull(e3.salary,0)) as salary
from
    (
select
    id,
    max(month) as month
from
    Employee
group by
    id
having
    count(*) > 1) maxmonth
left join
    Employee e1
on
    (maxmonth.id = e1.id and maxmonth.month > e1.month)
left join
    Employee e2
on
    (e2.id = e1.id and e2.month = e1.month-1)
left join
    Employee e3
on
    (e3.id = e1.id and e3.month = e1.month-2)
order by
    id,month desc ;