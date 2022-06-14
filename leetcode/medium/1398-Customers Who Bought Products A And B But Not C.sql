use leetcode;

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

with 1398_leetcode as (
select
    customer_id,
    product_name
from
    Orders
where
    customer_id in (
select
    customer_id
from
    Orders
group by
    customer_id
having
    count(product_name) > 2)
and
    product_name != 'D')
select
    customer_id
from
    1398_leetcode
group by
    customer_id
having
    count(customer_id) = 2;

