drop database datalemur;
create database datalemur;
use datalemur;


Create table If Not Exists transactions (user_id int, spend float, transaction_date datetime);

with answer as (
select
    user_id,
    spend,
    transaction_date,
    rank() over (partition by user_id order by transaction_date) as r_no
from
    transactions)
select
    user_id,
    spend,
    transaction_date
from
    answer
where
    r_no=3;
