drop database leetcode;
create database leetcode;
use leetcode;

-- Create the Orders table
CREATE TABLE Orders (
    minute INT,
    order_count INT
);

-- Insert data into the Orders table
INSERT INTO Orders (minute, order_count) VALUES
    (1, 0),
    (2, 2),
    (3, 4),
    (4, 6),
    (5, 1),
    (6, 4),
    (7, 1),
    (8, 2),
    (9, 4),
    (10, 1),
    (11, 4),
    (12, 6);

select * from Orders;

with cte as (
select
    *,
    case when minute <= 6 then row_number() over (order by minute) else (row_number() over (order by minute))+1 end as interval_values
from
    Orders)
select
    if(interval_values-minute=0,1,2) as interval_no,
    sum(order_count) as total_orders
from
    cte
group by
    interval_no;

