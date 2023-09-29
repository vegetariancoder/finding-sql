select * from airbnb;


select
    city,
    amenities
from
    airbnb;

with cte as (
SELECT
    city,
    replace(replace(SUBSTRING_INDEX(SUBSTRING_INDEX(amenities, ',', n.n), ',', -1),'{',''),'"','') AS amenity
FROM
    airbnb
JOIN
    (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5) AS n
ON
    LENGTH(amenities) - LENGTH(REPLACE(amenities, ',', '')) >= n.n - 1),
answer as (
select
    city,
    count(distinct amenity),
    dense_rank() over (order by count(distinct amenity) desc ) as drnk
from
    cte
group by
    city)
select city from answer where drnk=1;