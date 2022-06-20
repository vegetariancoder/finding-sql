use leetcode;
Create table If Not Exists Employees (employee_id int, name varchar(100) , salary int);

insert into Employees (employee_id,name,salary) value (2,'Meir',3000);
insert into Employees (employee_id,name,salary) value (3,'Michael',3000);
insert into Employees (employee_id,name,salary) value (7,'Addilyn',7400);
insert into Employees (employee_id,name,salary) value (8,'Juan',6100);
insert into Employees (employee_id,name,salary) value (9,'Kannon',7400);



select
    *,
    dense_rank() over (order by salary) as rn
from
    Employees;


select
    *,
    dense_rank() over (order by salary) as team_id
from
    Employees
where
    salary in (
select
    salary
from
    Employees
group by
    salary
having
    count(*)>1);



