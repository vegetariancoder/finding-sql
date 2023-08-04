drop database strata;
create database strata;
use strata;


select * from userpurchase;

with answer as (
select
    *,
    lead(created_at) over (partition by user_id order by created_at) as next_date
from
    userpurchase),
main_answer as (
select
    user_id,
    datediff(next_date,created_at) as diff
from
    answer)
select
    distinct user_id
from
    main_answer
where
    diff <=7;