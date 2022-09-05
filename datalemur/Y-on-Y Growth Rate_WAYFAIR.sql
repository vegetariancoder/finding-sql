drop database datalemur;
create database datalemur;
use datalemur;


Create table If Not Exists user_transactions (transaction_id int, product_id int, spend float,transaction_date date);
insert into user_transactions (transaction_id, product_id,spend,transaction_date) values (1341,123424,1500.60,'2019-12-31');
insert into user_transactions (transaction_id, product_id,spend,transaction_date) values (1423,123424,1000.20,'2020-12-31');
insert into user_transactions (transaction_id, product_id,spend,transaction_date) values (1623,123424,1246.44,'2021-12-31');
insert into user_transactions (transaction_id, product_id,spend,transaction_date) values (1322,123424,2145.32,'2022-12-31');


select
    year(transaction_date) as year,
    product_id,
    spend as curr_year_spend,
    round(ifnull(lag(spend,1) over (order by year(transaction_date)),0),2) as prev_year_spend,
    round((spend-round(ifnull(lag(spend,1) over (order by year(transaction_date)),0),2))/round(ifnull(lag(spend,1) over (order by year(transaction_date)),0),2)*100,2) as yoy_rate
from
    user_transactions;
