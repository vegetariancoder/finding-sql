create database strata;
use strata;
select * from sf_transactions;

with answer as (
select
    ym,
    current_month_income,
    lag(current_month_income) over (order by ym) as last_month_income
from
    (
select
    date_format(created_at,'%Y-%m') as ym,
    sum(value) as current_month_income
from
    sf_transactions
group by
    ym) as calc_table)
select
    ym,
    round((current_month_income-last_month_income)/last_month_income*100,2) as revenue_diff_pct
from
    answer;