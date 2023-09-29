use strata;

select * from fraud;

with answer as (
select
    *,
    percent_rank()  over (partition by state order by fraud_score desc ) as pctl
from
    fraud)
select
    policy_num,
    state,
    claim_cost,
    fraud_score
from
    answer
where
    pctl <= .05;