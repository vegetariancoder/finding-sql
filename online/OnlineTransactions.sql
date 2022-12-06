create database online;
use online;

create table account_balance
(
    account_no          varchar(20),
    transaction_date    date,
    debit_credit        varchar(10),
    transaction_amount  int
);

insert into account_balance values ('acc_1', '2022-01-20', 'credit', 100);
insert into account_balance values ('acc_1', '2022-01-21', 'credit', 500);
insert into account_balance values ('acc_1', '2022-01-22', 'credit', 300);
insert into account_balance values ('acc_1', '2022-01-23', 'credit', 200);
insert into account_balance values ('acc_2', '2022-01-20', 'credit', 500);
insert into account_balance values ('acc_2', '2022-01-21', 'credit', 1100);
insert into account_balance values ('acc_2', '2022-01-22', 'debit', 1000);
insert into account_balance values ('acc_3', '2022-01-20', 'credit', 1000);
insert into account_balance values ('acc_4', '2022-01-20', 'credit', 1500);
insert into account_balance values ('acc_4', '2022-01-21', 'debit', 500);
insert into account_balance values ('acc_5', '2022-01-20', 'credit', 900);

select * from account_balance;


with answer as (
select
    *,
    if(cum_sum>=1000,'Yes','No') as checks
from
    (
select
    *,
    sum(case when debit_credit='credit' then transaction_amount else -transaction_amount end) over (partition by account_no order by transaction_date) as cum_sum
from
    account_balance
where
    account_no in (
select
    distinct account_no
from
    (
select
    *,
    last_value(cum_sum) over (partition by account_no) as last_amount
from
    (
select
    *,
    sum(case when debit_credit='credit' then transaction_amount else -transaction_amount end) over (partition by account_no order by transaction_date) as cum_sum
from
    account_balance) calc_table) more_calc_table
where
    last_amount >=1000)) calx_table)
select
    account_no,
    min(transaction_date) as transaction_date
from
    answer
where
    checks='Yes'
group by
    account_no;