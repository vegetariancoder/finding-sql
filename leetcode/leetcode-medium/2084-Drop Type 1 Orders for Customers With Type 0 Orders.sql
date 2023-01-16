drop database leetcode;
create database leetcode;
use leetcode;
CREATE TABLE OrdersLeetCode (
order_id int,
customer_id int,
order_type int
);

INSERT into OrdersLeetCode values (1,1,0),
  (2,1,0),
  (11,2,0),
  (12,2,1),
  (21,3,1),
  (22,3,0),
  (31,4,1),
  (32,4,1);


select * from OrdersLeetCode;


with answer as (
select
    *
from
    OrdersLeetCode
where
    order_type in (0) and order_type not in (1)
union all
select
    *
from
    OrdersLeetCode
where
    order_type in (1) and customer_id not in (select customer_id from OrdersLeetCode where order_type=0))
select
    *
from
    answer
order by
    order_type desc ;



with answer as (
select
    *,
    dense_rank() over (partition by customer_id order by order_type) as drnk
from
    OrdersLeetCode)
select
    order_id,
    customer_id,
    order_type
from
    answer
where
    drnk=1
order by
    order_type desc ;
