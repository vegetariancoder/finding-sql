use strata;

select * from linkedin_emp_projects;
select * from linkedin_employees;
select * from linkedin_projects;


with answer as (
select
    title,
    budget,
    ceiling((datediff(end_date, start_date) * sum(salary)/365)) as prorated_employee_expense,
    if(budget<ceiling((datediff(end_date, start_date) * sum(salary)/365)),'Risky','NotRisky') as flagging
from
    linkedin_projects
inner join
    linkedin_emp_projects
on
    linkedin_projects.id = linkedin_emp_projects.project_id
inner join
    linkedin_employees
on
    linkedin_emp_projects.emp_id = linkedin_employees.id
group by
    title,budget,start_date,end_date)
select
    title,
    budget,
    prorated_employee_expense
from
    answer
where
    flagging = 'Risky'
order by
    title;

select 10738.426+20204;