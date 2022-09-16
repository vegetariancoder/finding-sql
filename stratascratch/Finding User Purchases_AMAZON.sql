drop database strata;
create database strata;
use strata;

CREATE TABLE amazon_transactions
(
    id int  NOT NULL,
    user_id int  NOT NULL,
    item varchar(30),
    created_at date,
    revenue INTEGER
);

select * from amazon_transactions;

with answer as (
select
    user_id,
    created_at,
    ifnull(lag(created_at) over (partition by user_id order by created_at),created_at) as prev_date
from
    (
select
    user_id,
    created_at,
    row_number() over (partition by user_id order by created_at) as r_no
from
    amazon_transactions) calc_table)
select
    distinct user_id

from
    answer
where
    created_at!= prev_date
and
    datediff(created_at,prev_date) <=7;

with asnwer as (
select
    *,
    lead(created_at) over (partition by user_id order by created_at ) as next_pur
from
    amazon_transactions)
select
    distinct user_id
from
    asnwer
where
    datediff(next_pur,created_at) <=7;

