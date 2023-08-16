select
    business_name,
    review_text,
    dense_rank() over (order by cool desc) as drnk
from
    yelp_reviews