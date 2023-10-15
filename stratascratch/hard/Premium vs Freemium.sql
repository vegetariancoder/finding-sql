use strata;

select * from ms_acc_dimension;

select * from ms_download_facts;

select * from ms_user_dimension;


with joined_all as (
select
    ms_download_facts.*,
    ms_acc_dimension.paying_customer
from
    ms_acc_dimension
inner join
    ms_user_dimension
on
    ms_acc_dimension.acc_id = ms_user_dimension.acc_id
inner join
    ms_download_facts
on
    ms_download_facts.user_id = ms_user_dimension.user_id)
select
    date,
    sum(case when paying_customer='no' then downloads * 1 else 0 end) as non_paying,
    sum(case when paying_customer='yes' then downloads * 1 else 0 end) as paying
from
    joined_all
group by
    date
having
    non_paying>paying
order by
    date;