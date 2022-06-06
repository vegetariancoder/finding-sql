drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Orders (order_id int,order_date date, customer_id int, product_id int);
insert into Orders (order_id,order_date,customer_id,product_id) value (1,'2020-07-31',1,1);
insert into Orders (order_id,order_date,customer_id,product_id) value (2,'2020-07-30',2,2);
insert into Orders (order_id,order_date,customer_id,product_id) value (3,'2020-08-29',3,3);
insert into Orders (order_id,order_date,customer_id,product_id) value (4,'2020-07-29',4,1);
insert into Orders (order_id,order_date,customer_id,product_id) value (5,'2020-06-10',1,2);
insert into Orders (order_id,order_date,customer_id,product_id) value (6,'2020-08-01',2,1);
insert into Orders (order_id,order_date,customer_id,product_id) value (7,'2020-08-01',3,3);
insert into Orders (order_id,order_date,customer_id,product_id) value (8,'2020-08-03',1,2);
insert into Orders (order_id,order_date,customer_id,product_id) value (9,'2020-08-07',2,3);
insert into Orders (order_id,order_date,customer_id,product_id) value (10,'2020-07-15',1,2);


Create table If Not Exists Products (product_id int, product_name varchar (100), price int);
insert into Products (product_id,product_name,price) value (1,'keyboard',123);
insert into Products (product_id,product_name,price) value (2,'mouse',123);
insert into Products (product_id,product_name,price) value (3,'screen',123);
insert into Products (product_id,product_name,price) value (4,'hard disk',123);





with 1596_leetcode as (
select
    table1.customer_id,
    product_id
from
    (
select
    customer_id,
    Orders.product_id,
    count(Orders.product_id) as count_values
from
    Orders
group by
    1,2
order by
    1) table1
inner join
(select
    customer_id,
    max(count_vals) as max_values
from
    (
select
    customer_id,
    product_id,
    count(product_id) as count_vals
from
    Orders
group by
    1,2
order by
    1) max_table
group by
    1) table2
on
    table1.customer_id = table2.customer_id
and
    table1.count_values = table2.max_values)
select
    customer_id,
    1596_leetcode.product_id,
    product_name
from
    1596_leetcode
inner join
    Products
on
    1596_leetcode.product_id = Products.product_id
order by
    customer_id;


select
    customer_id,
    product_id,
    count(product_id),
    rank() over (partition by customer_id order by count(product_id) desc )
from
    Orders
group by
    1,2;







