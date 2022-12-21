drop database online;
create database online;
use online;

Create Table user_transactions(
product_id integer,
users_id integer,
spend float,
transaction_date datetime
);

INSERT INTO user_transactions Values(3673, 123, 68.90 ,'2022-07-08 10:00:00');
INSERT INTO user_transactions Values(9623, 123, 274.10 ,'2022-07-08 10:00:00');
INSERT INTO user_transactions Values(1467, 115, 19.90 ,'2022-07-08 10:00:00');
INSERT INTO user_transactions Values(2513, 159, 25.00 ,'2022-07-08 10:00:00');
INSERT INTO user_transactions Values(1452, 159, 74.50 ,'2022-07-10 10:00:00');
INSERT INTO user_transactions Values(1452, 123, 74.50 ,'2022-07-10 10:00:00');
INSERT INTO user_transactions Values(9765, 123, 100.15 ,'2022-07-11 10:00:00');
INSERT INTO user_transactions Values(6536, 115, 57.00 ,'2022-07-12 10:00:00');
INSERT INTO user_transactions Values(7384, 159, 15.50 ,'2022-07-12 10:00:00');
INSERT INTO user_transactions Values(1247, 159, 23.40 ,'2022-07-12 10:00:00');

select * from user_transactions;

with answer as (
select
    *
from
    user_transactions
where
    (users_id,transaction_date) in (
select
    users_id,
    max(transaction_date) as max_date
from
    user_transactions
group by
    users_id))
select
    transaction_date,
    count(distinct users_id) as number_of_user,
    count(product_id) as number_of_products
from
    answer
group by
    transaction_date;