drop database leetcode;
create database leetcode;
use leetcode;
SET GLOBAL time_zone = '+3:00';

create table Customers(
    customer_id int,
    name varchar(100)
);

insert into Customers (customer_id, name)
values (1,'Daniel');
insert into Customers (customer_id, name)
values (2,'Diana');
insert into Customers (customer_id, name)
values (3,'Elizabeth');
insert into Customers (customer_id, name)
values (4,'john');


create table Orders(
    order_id int,
    customer_id int,
    product_name varchar(100)
);
truncate table Orders;
insert into Orders (order_id, customer_id, product_name)
values (10,1,'A');
insert into Orders (order_id, customer_id, product_name)
values (20,1,'B');
insert into Orders (order_id, customer_id, product_name)
values (30,1,'D');
insert into Orders (order_id, customer_id, product_name)
values (40,1,'C');
insert into Orders (order_id, customer_id, product_name)
values (50,2,'A');
insert into Orders (order_id, customer_id, product_name)
values (60,3,'A');
insert into Orders (order_id, customer_id, product_name)
values (70,3,'B');
insert into Orders (order_id, customer_id, product_name)
values (80,3,'D');
insert into Orders (order_id, customer_id, product_name)
values (90,4,'C');


select * from Orders;


with answer as (
select
    customer_id
from
    Orders
where
    product_name in ('A','B') and customer_id not in (select customer_id from Orders where product_name in ('C'))
group by
    customer_id
having
    count(*) > 1)
select
    Customers.customer_id,
    name
from
    Customers
inner join
    answer
on
    Customers.customer_id=answer.customer_id;


select
    Customers.customer_id,
    name
from
    (select
    customer_id,
    sum(case
        when product_name='A' then 1 else 0
    end) as p_A,
    sum(case
        when product_name='B' then 1 else 0
    end) as p_B,
    sum(case
        when product_name='C' then 1 else 0
    end) as p_C
from
    Orders
group by
    customer_id) calc_table
inner join
    Customers
on
    calc_table.customer_id = Customers.customer_id
where
    p_A=1 and p_B=1 and p_C!=1;


