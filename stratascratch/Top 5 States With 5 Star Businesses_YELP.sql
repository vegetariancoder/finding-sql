drop database strata;
create database strata;
use strata;
Create table If Not Exists yelp_business (state varchar(100), stars float);

select * from yelp_business;

with answer as (
select
    state ,
    count(state) as n_businesses,
    rank()  over (order by count(state) desc ) as rnk
from
    yelp_business
where
    stars=5
group by
    state)
select
    state,
    n_businesses
from
    answer
where
    rnk<=5
order by
    n_businesses desc ,state;