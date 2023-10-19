select * from yelp;

with answer as (
select
    state,
    count(business_id) as five_star_counts,
    rank() over (order by count(business_id) desc) as rnk
from
    yelp
where
    stars=5
group by
    state)
select
    state,
    five_star_counts
from
    answer
where
    rnk <=5
order by
    five_star_counts desc ,state;
