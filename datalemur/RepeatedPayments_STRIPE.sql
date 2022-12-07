drop database datalemur;
create database datalemur;
use datalemur;

select * from transactions;

select
    minute(transaction_timestamp) as minutes
from
    transactions;

with answer as (
select
    *,
   timestampdiff(minute ,transaction_timestamp,next_transaction_timestamp) as diff
from
    (
select
    merchant_id,
    lead(merchant_id) over (partition by merchant_id order by transaction_timestamp) as next_merchant_id,
    credit_card_id,
    lead(credit_card_id) over (partition by credit_card_id order by transaction_timestamp) as next_credit_card_id,
    amount,
    lead(amount) over (partition by credit_card_id order by transaction_timestamp) as next_amount,
    transaction_timestamp,
    lead(transaction_timestamp) over (partition by credit_card_id order by transaction_timestamp) as next_transaction_timestamp
from
    transactions) calc_table)
select
    count(*) as payment_count
from
    answer
where
    merchant_id=next_merchant_id and credit_card_id=next_credit_card_id and amount=next_amount and diff <= 10;
