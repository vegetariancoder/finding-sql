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

select * from Salaries;


with answer as (
select
    Salaries.company_id,
    employee_id,
    employee_name,
    salary,
    case
        when max_salary < 1000 then 0.0
        when max_salary >=1000 and max_salary < 10000 then 0.24
        when max_salary >=10000 then 0.49
    end as interest_rate
from
    Salaries
left join
(select
    company_id,
    max(salary) as max_salary
from
    Salaries
group by
    company_id)max_salary_tb
on
   Salaries.company_id=max_salary_tb.company_id)
select
    company_id,
    employee_id,
    employee_name,
    round(salary - (salary*interest_rate),0) as salary
from
    answer;



