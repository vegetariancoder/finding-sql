drop database leetcode;
create database leetcode;
use leetcode;
CREATE TABLE IF NOT EXISTS Salaries (
    company_id INT,
    employee_id INT,
    employee_name VARCHAR(19),
    salary INT);

insert into Salaries (company_id,employee_id,employee_name,salary) values (1,1,'Tony',2000);
insert into Salaries (company_id,employee_id,employee_name,salary) values (1,2,'Pronub',21300);
insert into Salaries (company_id,employee_id,employee_name,salary) values (1,3,'Tyrrox',10800);
insert into Salaries (company_id,employee_id,employee_name,salary) values (2,1,'Pam',300);
insert into Salaries (company_id,employee_id,employee_name,salary) values (2,7,'Bassem',450);
insert into Salaries (company_id,employee_id,employee_name,salary) values (2,9,'Hermione',700);
insert into Salaries (company_id,employee_id,employee_name,salary) values (3,7,'Bocaben',100);
insert into Salaries (company_id,employee_id,employee_name,salary) values (3,2,'Ognjen',2200);
insert into Salaries (company_id,employee_id,employee_name,salary) values (3,13,'Nyancat',3300);
insert into Salaries (company_id,employee_id,employee_name,salary) values (3,15,'Morninngcat',1866);


with 1468_leetcode as (
select
    company_id,
    employee_id,
    employee_name,
    salary,
    case
        when max(salary) over (partition by company_id) < 1000 then 0.0
        when max(salary) over (partition by company_id) between 1000 and 10001 then 0.24
        when max(salary) over (partition by company_id) > 10002 then 0.49
    end as tax_deducation,
    round(salary*(case
        when max(salary) over (partition by company_id) < 1000 then 0.0
        when max(salary) over (partition by company_id) between 1000 and 10001 then 0.24
        when max(salary) over (partition by company_id) > 10002 then 0.49
    end),0) as tax_deducation_values
from
    Salaries)
select
    company_id,
    employee_id,
    employee_name,
    salary-tax_deducation_values as salary
from
    1468_leetcode;

with maintable as (
select
    table1.company_id,
    table2.employee_id,
    table2.employee_name,
    table2.salary,
    case
        when max_salaries > 10002 then 0.49
        when max_salaries < 1000 then 0.0
        when max_salaries between 1000 and 10001 then 0.24
    end as tax_deduct,
    round(table2.salary*case
        when max_salaries > 10002 then 0.49
        when max_salaries < 1000 then 0.0
        when max_salaries between 1000 and 10001 then 0.24
    end,0) as tax_deduct_values
from
    (
(select
    company_id,
    max(salary) as max_salaries
from
    Salaries
group by
    company_id) table1
inner join
(select
    *
from
    Salaries) table2
on
    table1.company_id = table2.company_id))
select
    company_id,
    employee_id,
    employee_name,
    salary-tax_deduct_values as salary
from
    maintable;





