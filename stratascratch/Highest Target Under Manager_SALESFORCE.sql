with answer as (
select
    first_name,
    target,
    rank() over(order by target desc) as rnk
from
    salesforce_employees
where
    manager_id=13)
select
    first_name,
    target
from
    answer
where
    rnk=1