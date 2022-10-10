drop database datalemur;
create database datalemur;
use datalemur;

Create table If Not Exists transactions (transaction_id int, type varchar(100), amount float, transaction_date date);
insert into transactions (transaction_id, type, amount,transaction_date) values (19153,'deposit',65.90,'2022-07-10');
insert into transactions (transaction_id, type, amount,transaction_date) values (53151,'deposit',178.55,'2022-07-08');
insert into transactions (transaction_id, type, amount,transaction_date) values (29776,'withdrawal',25.90,'2022-07-08');
insert into transactions (transaction_id, type, amount,transaction_date) values (16461,'withdrawal',45.99,'2022-07-08');
insert into transactions (transaction_id, type, amount,transaction_date) values (77134,'deposit',32.60,'2022-07-10');

# with answers as (
# select
#     transaction_date,
#     round(deposit_amount-withdrawl_amount,2) as total_amount
# from
#     (
# select
#     transaction_date,
#     ifnull(round(sum(case
#         when type='deposit' then amount
#     end),2),0) as deposit_amount,
#     ifnull(round(sum(case
#         when type='withdrawal' then amount
#     end),2),0) as withdrawl_amount
# from
#     transactions
# group by
#     transaction_date
# order by
#     transaction_date) calc_table)
# select
#     transaction_date,
#     sum(total_amount) over (order by transaction_date) as balance
# from
#     answers;



select
    *
from
    transactions
order by
    transaction_date;

select
    distinct transaction_date,
    round(sum(case when type='deposit' then amount else -amount end) over (order by transaction_date),2) as balance
from
    transactions;


select
    transaction_date,
    sum(ifnull(round(deposit_amt-withdrawl_amt,2),deposit_amt)) over (order by transaction_date) as balance
from
    (
select
    transaction_date,
    sum(case
        when type='deposit' then amount
    end) as deposit_amt,
    sum(case
        when type='withdrawal' then amount
    end) as withdrawl_amt
from
    transactions
group by
    transaction_date
order by
    transaction_date) calc_table;


with answer as (
select
    transaction_date,
    sum(case when type='withdrawal' then -amount else amount end) as balance
from
    transactions
group by
    transaction_date
order by
    transaction_date)
select
    transaction_date,
    round(sum(balance) over (partition by extract(year from transaction_date),extract(month from transaction_date) order by transaction_date),2) as balance
from
    answer;


WITH daily_balances AS (
  SELECT
    extract(day from transaction_date) AS transaction_day,
    extract(month from transaction_date) AS transaction_month,
    SUM(CASE WHEN type = 'deposit' THEN amount
      WHEN type = 'withdrawal' THEN -amount END) AS balance
  FROM transactions
  GROUP BY
    extract(day from transaction_date),
    extract(month from transaction_date))

SELECT
  transaction_day,
  SUM(balance) OVER (
    PARTITION BY transaction_month
    ORDER BY transaction_day) AS balance
FROM daily_balances
ORDER BY transaction_day;


