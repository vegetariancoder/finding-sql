drop database datalemur;
create database datalemur;
use datalemur;

Create table If Not Exists user_transactions (transaction_id int, user_id int, spend int, transaction_date date);
insert into user_transactions (transaction_id, user_id, spend, transaction_date) values (759274,111,49.50,'2022-03-02');
insert into user_transactions (transaction_id, user_id, spend, transaction_date) values (850371,111,51.00,'2022-03-15');
insert into user_transactions (transaction_id, user_id, spend, transaction_date) values (615348,145,36.30,'2022-03-22');
insert into user_transactions (transaction_id, user_id, spend, transaction_date) values (137424,156,151.00,'2022-04-04');
insert into user_transactions (transaction_id, user_id, spend, transaction_date) values (248475,156,87.00,'2022-04-16');

select
    count(user_id) as count
from
    user_transactions
where
    (user_id,transaction_date) in(
select
    user_id,
    min(transaction_date) as min_date
from
    user_transactions
group by
    user_id)
and
    spend>50;