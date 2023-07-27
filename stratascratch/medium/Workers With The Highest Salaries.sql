with answer as (
select
    *,
    dense_rank() over (order by salary desc) as drnk
from
    worker)
select
    worker_title
from
    title
inner join
    answer
on
    title.worker_ref_id = answer.worker_id
where
    drnk = 1;