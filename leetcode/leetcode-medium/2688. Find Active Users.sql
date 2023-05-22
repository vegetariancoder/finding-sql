drop database leetcode;
create database leetcode;
use leetcode;

CREATE TABLE Users (
  user_id INT,
  item VARCHAR(50),
  created_at DATE,
  amount INT
);

INSERT INTO Users (user_id, item, created_at, amount)
VALUES
  (5, 'Smart Crock Pot', '2021-09-18', 698882),
  (6, 'Smart Lock', '2021-09-14', 11487),
  (6, 'Smart Thermostat', '2021-09-10', 674762),
  (8, 'Smart Light Strip', '2021-09-29', 630773),
  (4, 'Smart Cat Feeder', '2021-09-02', 693545),
  (4, 'Smart Bed', '2021-09-13', 170249);

select * from Users;

with answer as (
select
    user_id,
    created_at as first_purchase,
    lead(created_at) over (partition by user_id order by created_at) as second_purchase
from
    Users)
select
    distinct user_id
from
    answer
where
    datediff(second_purchase,first_purchase)<=7;
