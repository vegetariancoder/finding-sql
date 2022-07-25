Create table If Not Exists Employees (employee_id int, name varchar(30));
Create table If Not Exists Salaries (employee_id int, salary int);
insert into Employees (employee_id, name) values ('2', 'Crew');
insert into Employees (employee_id, name) values ('4', 'Haven');
insert into Employees (employee_id, name) values ('5', 'Kristian');
insert into Salaries (employee_id, salary) values ('5', '76071');
insert into Salaries (employee_id, salary) values ('1', '22517');
insert into Salaries (employee_id, salary) values ('4', '63539');



select
    employee_id
from
    Employees
where
    employee_id not in (
select
    Employees.employee_id
from
    Employees
inner join
    Salaries on Employees.employee_id = Salaries.employee_id)
union
select
    employee_id
from
    Salaries
where
    employee_id not in (
select
    Employees.employee_id
from
    Employees
inner join
    Salaries on Employees.employee_id = Salaries.employee_id)
order by
    employee_id;