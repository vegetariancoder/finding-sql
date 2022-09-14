select
    'New' as host_pop_rating,
    min_price,
    avg_price,
    max_price
from
    (
select
    number_of_reviews,
    count(id) as count,
    min(price) as min_price,
    avg(price) as avg_price,
    max(price) as max_price
from
    airbnb_host_searches
group by
    number_of_reviews) as zero_rev
where
    number_of_reviews=0
union all
select
    'Rising' as host_pop_rating,
    min(min_price) min_price,
    avg(avg_price) avg_price,
    max(max_price) max_price
from
    (
select
    number_of_reviews,
    count(id) as count,
    min(price) as min_price,
    avg(price) as avg_price,
    max(price) as max_price
from
    airbnb_host_searches
group by
    number_of_reviews) as rising_rev
where
    number_of_reviews between 1 and 5
union all
select
    'Trending Up' as host_pop_rating,
    min(min_price) min_price,
    avg(avg_price) avg_price,
    max(max_price) max_price
from
    (
select
    number_of_reviews,
    count(id) as count,
    min(price) as min_price,
    avg(price) as avg_price,
    max(price) as max_price
from
    airbnb_host_searches
group by
    number_of_reviews) as trending_rev
where
    number_of_reviews between 6 and 15
union all
select
    'Popular' as host_pop_rating,
    min(min_price) min_price,
    avg(avg_price) avg_price,
    max(max_price) max_price
from
    (
select
    number_of_reviews,
    count(id) as count,
    min(price) as min_price,
    avg(price) as avg_price,
    max(price) as max_price
from
    airbnb_host_searches
group by
    number_of_reviews) as popular_rev
where
    number_of_reviews between 16 and 40
union all
select
    'Hot' as host_pop_rating,
    min(min_price) min_price,
    avg(avg_price) avg_price,
    max(max_price) max_price
from
    (
select
    number_of_reviews,
    count(id) as count,
    min(price) as min_price,
    avg(price) as avg_price,
    max(price) as max_price
from
    airbnb_host_searches
group by
    number_of_reviews) as hot_rev
where
    number_of_reviews > 40