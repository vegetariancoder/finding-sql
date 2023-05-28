drop database leetcode;
create database leetcode;
use leetcode;

-- Create Orders table
CREATE TABLE Orders (
  order_id INT,
  customer_id INT,
  order_date DATE,
  price INT
);

-- Insert data into Orders table
INSERT INTO Orders (order_id, customer_id, order_date, price)
VALUES
  (1, 1, '2019-07-01', 1100),
  (2, 1, '2019-11-01', 1200),
  (3, 1, '2020-05-26', 3000),
  (4, 1, '2021-08-31', 3100),
  (5, 1, '2022-12-07', 4700),
  (6, 2, '2015-01-01', 700),
  (7, 2, '2017-11-07', 1000),
  (8, 3, '2017-01-01', 900),
  (9, 3, '2018-11-07', 900);


select * from Orders;


with maintable as (
select
    customer_id,
    year(order_date) as year,
    sum(price) as sm
from
    Orders
group by
    customer_id, year(order_date))
, right_customer as (
select
    distinct mt1.customer_id as customer_id
from
    maintable mt1
join
    maintable mt2
where
    mt1.year-mt2.year=1
and
    mt1.customer_id=mt2.customer_id)
select
distinct mt1.customer_id
from
    maintable mt1
join
    maintable mt2
where
    mt1.customer_id in (select customer_id from right_customer )
and
    mt1.year>mt2.year
and
    mt1.sm > mt2.sm
and
    mt1.customer_id=mt2.customer_id;


