drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Orders (order_id int, order_date date, customer_id int,
    invoice int);

insert into Orders (order_id, order_date, customer_id,invoice ) values (1,'2020-09-15',1,30);
insert into Orders (order_id, order_date, customer_id,invoice ) values (2,'2020-09-17',2,90);
insert into Orders (order_id, order_date, customer_id,invoice ) values (3,'2020-10-06',3,20);
insert into Orders (order_id, order_date, customer_id,invoice ) values (4,'2020-10-20',3,21);
insert into Orders (order_id, order_date, customer_id,invoice ) values (5,'2020-11-10',1,10);
insert into Orders (order_id, order_date, customer_id,invoice ) values (6,'2020-11-21',2,15);
insert into Orders (order_id, order_date, customer_id,invoice ) values (7,'2020-12-01',4,55);
insert into Orders (order_id, order_date, customer_id,invoice ) values (8,'2020-12-03',4,77);
insert into Orders (order_id, order_date, customer_id,invoice ) values (9,'2021-01-07',3,31);
insert into Orders (order_id, order_date, customer_id,invoice ) values (10,'2021-01-15',2,20);


select
    date_format(order_date,'%Y-%m') as year_month_value,
    count(customer_id) as order_count,
    count(distinct customer_id) as customer_count
from
    Orders
where
    invoice > 20
group by
   date_format(order_date,'%Y-%m');