drop database strata;
create database strata;
use strata;
create table customers  (
id int,
first_name varchar(100),
last_name varchar(100),
city varchar(100),
address varchar(100),
phone_number varchar(100)
);

create table orders  (
id int,
cust_id int,
order_date date,
order_details varchar(100),
total_order_cost int
);

select
    round(count(address)/(select count(id) from orders )*100,2) as percentage
from
    orders
left join
    customers
on
    orders.cust_id = customers.id
where
    address is not null;

