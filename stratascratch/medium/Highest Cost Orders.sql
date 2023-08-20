use strata;

select * from customers_data;

select * from orders_data;

with answer as (
select
    first_name,
    order_date,
    sum(total_order_cost) as total_cost,
    dense_rank() over (order by sum(total_order_cost) desc) as drnk
from
    customers_data
inner join
    orders_data
on
    customers_data.id = orders_data.cust_id
where
    order_date between '2019-02-01' and '2019-05-01'
group by
    first_name, order_date)
select
    first_name,
    order_date,
    total_cost
from
    answer
where
    drnk=1;