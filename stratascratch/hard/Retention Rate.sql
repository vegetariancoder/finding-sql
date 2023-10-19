use strata;
select * from sf_events;

select
    *
from
    sf_events;


with cte as (
select
    user_id,
    account_id,
    min(date) as start_date,
    max(date) as end_date
from
    sf_events
group by
    user_id,
    account_id
order by
    account_id),
retention as (
select
    *,
    if(substring(end_date,1,7)>'2020-12',1,0) as dec_subs,
    if(substring(end_date,1,7)>'2021-01',1,0) as jan_subs
from
    cte)
select
    account_id,
    round(sum(jan_subs)/sum(dec_subs)) as retention_rate
from
    retention
group by
    account_id
order by
    account_id;