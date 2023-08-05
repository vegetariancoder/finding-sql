use strata;

select * from tesla_new_products;


with calc as (
select
    company_name,
    year,
    count(*) as cnt
from
    tesla_new_products
group by
    company_name, year)
, answer as (
select
    company_name,
    cnt,
    lead(cnt) over (partition by company_name order by year) as next_cnt
from
    calc)
select
    company_name,
    next_cnt-cnt as total_launch
from
    answer
where
    next_cnt is not null;