use leetcode;

SET GLOBAL time_zone = '+3:00';

CREATE TABLE IF NOT EXISTS Customers (
customer_id INT,
name varchar(100));

insert into Customers (customer_id,name) values (1,'Winston'),
(2,'Jonathan'),
(3,'Annabelle'),
(4,'Marwan'),
(5,'Khaled');


CREATE TABLE IF NOT EXISTS Orders (
order_id INT,
order_date date,
customer_id int,
product_id int);


insert into Orders (order_id,order_date,customer_id,product_id) values (1,'2020-07-31',1,1),
  (2,'2020-07-30',2,2),
  (3,'2020-08-29',3,3),
  (4,'2020-07-29',4,1),
  (5,'2020-06-10',1,2),
  (6,'2020-08-01',2,1),
  (7,'2020-08-01',3,1),
  (8,'2020-08-03',1,2),
  (9,'2020-08-07',2,3),
  (10,'2020-07-15',1,2);


CREATE TABLE IF NOT EXISTS Products (
product_id INT,
product_name varchar(100),
price int);

insert into Products (product_id,product_name,price) values (1,'keyboard',120),
(2,'mouse',80),
(3,'screen',600),
(4,'hard disk',450);




select
    product_name,
    Orders.product_id,
    order_id,
    order_date
from
    Orders
left join
    Products P on Orders.product_id = P.product_id
where
    order_date in (
select
    max(order_date) as max_date
from
    Orders
group by
    product_id)
order by
    product_id;


