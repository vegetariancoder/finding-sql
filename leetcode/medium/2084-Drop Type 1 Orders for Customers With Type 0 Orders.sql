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


(select
     order_id,
    customer_id,
    order_type
from
    OrdersLeetCode
where
    order_type = 0
union all
select
    *
from
    OrdersLeetCode
where
    customer_id = (
select
    customer_id
from
    OrdersLeetCode
where
    order_type = 1
group by
    customer_id
having
    count(*) > 1)) order by order_type desc ;


with leetcode2084 as (
select
    *,
    rank() over (partition by customer_id order by order_type) as rankings
from
    OrdersLeetCode)
select
    order_id, customer_id, order_type
from
    leetcode2084
where
    rankings = 1
order by
    order_type desc ;







