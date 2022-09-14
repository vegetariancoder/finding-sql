use strata;

select
    date,
    non_paying,
    paying
from
    (
with answer as (
select
    date,
    paying_customer,
    sum(downloads) as cnt_dwn
from
    (
select
    date,
    downloads,
    paying_customer
from
    download_facts
left join
    user_dim
on
    download_facts.user_id=user_dim.user_id
left join
    acc_dim
on
    user_dim.acc_id = acc_dim.acc_id) calc_table
group by
    date, paying_customer)
select
    date,
    sum(case
        when paying_customer='yes' then cnt_dwn
    end) as paying,
    sum(case
        when paying_customer='no' then cnt_dwn
    end) as non_paying
from
    answer
group by
    date) mt
where
    non_paying>paying
order by
    date;
