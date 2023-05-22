drop database leetcode;
create database leetcode;
use leetcode;

CREATE TABLE delivery (
  delivery_id INT,
  customer_id INT,
  order_date DATE,
  customer_pref_delivery_date DATE
);

INSERT INTO delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date)
VALUES
  (1, 1, '2019-08-01', '2019-08-02'),
  (2, 2, '2019-08-01', '2019-08-01'),
  (3, 1, '2019-08-01', '2019-08-01'),
  (4, 3, '2019-08-02', '2019-08-13'),
  (5, 3, '2019-08-02', '2019-08-02'),
  (6, 2, '2019-08-02', '2019-08-02'),
  (7, 4, '2019-08-03', '2019-08-03'),
  (8, 1, '2019-08-03', '2019-08-03'),
  (9, 5, '2019-08-04', '2019-08-08'),
  (10, 2, '2019-08-04', '2019-08-18');


with flag_table as (
select
    order_date,
    count(*) as flag_cnt
from
    (
select
    *,
    if(order_date=customer_pref_delivery_date,'Yes','No') as flag
from
    delivery) calc
where
    flag='Yes'
group by
    order_date)
, main_del as (
select
    delivery.order_date,
    count(*) as cnt
from
    delivery
group by
    delivery.order_date)
select
    main_del.order_date,
    round((ifnull(flag_cnt,0)/cnt),2)*100 as immediate_percentage
from
    flag_table
right join
    main_del
on
    flag_table.order_date = main_del.order_date;



select
    order_date,
    round(sum(if(order_date = customer_pref_delivery_date, 1, 0))/ count(*), 2) * 100 as cnt
from
    delivery
group by
    order_date;

