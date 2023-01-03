drop database online;
create database online;
use online;

create table products
(
product_id varchar(20) ,
cost int
);
insert into products values ('P1',200),('P2',300),('P3',500),('P4',800);

create table customer_budget
(
customer_id int,
budget int
);

insert into customer_budget values (100,400),(200,800),(300,1500);


select * from products;

select * from customer_budget;

with answer as (
select
    customer_id,
    budget,
    product_id
from
    customer_budget
inner join
(select
    *,
    sum(cost) over (order by product_id) as r_sum
from
    products) calc_table
on
    customer_budget.budget >= calc_table.r_sum)
select
    customer_id,
    budget,
    count(product_id) as no_of_products,
    group_concat(product_id) as list_of_products
from
    answer
group by
    customer_id, budget;