with answer as (select
    company,
    profits,
    dense_rank() over (order by profits desc) as drnk
from
    forbes_global_2010_2014)
select company,profits from answer where drnk<=3;

