with sum_bonus as (select
    worker_ref_id,
    sum(bonus) as sm_bonus
from
    sf_bonus
group by
    worker_ref_id)
select
    employee_title,
    sex,
    avg(salary+sm_bonus) as total
from
    sf_employee
inner join
   sum_bonus
on
    sf_employee.id = sum_bonus.worker_ref_id
group by
    sex,
    employee_title;