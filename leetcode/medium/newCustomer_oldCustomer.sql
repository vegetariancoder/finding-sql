drop database leetcode;
create database leetcode;
use leetcode;
create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);
select * from customer_orders;
insert into customer_orders values(1,100,'2022-01-01',2000),(2,200,'2022-01-01',2500),(3,300,'2022-01-01',2100)
,(4,100,'2022-01-02',2000),(5,400,'2022-01-02',2200),(6,500,'2022-01-02',2700)
,(7,100,'2022-01-03',3000),(8,400,'2022-01-03',1000),(9,600,'2022-01-03',3000)
;

select * from customer_orders;

select
    new_customer_table.order_date,
    ifnull(new_customer,0) as new_customer,
    ifnull(old_customer,0) as old_customer

from
    (
select
    order_date,
    count(checks) as new_customer
from
    (select
    order_date,
    if(order_date=first_visit_date,'Yes','No') as checks
from
    customer_orders
inner join
(select
    customer_id,
    min(order_date) as first_visit_date
from
    customer_orders
group by
    customer_id) first_visit_table
on
    customer_orders.customer_id=first_visit_table.customer_id
order by
    order_id) yes_table
where
    checks = 'Yes'
group by
    order_date) new_customer_table
left join
(select
    order_date,
    count(checks) as old_customer
from
    (select
    order_date,
    if(order_date=first_visit_date,'Yes','No') as checks
from
    customer_orders
inner join
(select
    customer_id,
    min(order_date) as first_visit_date
from
    customer_orders
group by
    customer_id) first_visit_table
on
    customer_orders.customer_id=first_visit_table.customer_id
order by
    order_id) yes_table
where
    checks = 'No'
group by
    order_date) old_customer_table
on
    new_customer_table.order_date = old_customer_table.order_date;

