select
    count(distinct cust_id)
from
    orders;


select
    count(distinct id)
from
    customers
where
    address is not null;


with answer as (
select
    orders.*,
    case
        when address is not null then 'Yes' else 'No'
    end as shippable
from
    orders
inner join
    customers
on
    orders.cust_id = customers.id)
select
    (sum(case
        when shippable = 'Yes' then 1 else 0
    end)/count(*)) * 100 as percent_shipable
from
    answer;