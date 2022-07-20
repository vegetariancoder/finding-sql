-- What are the top 5 offices by state in terms of opportunities received?

use autodesk;


select
    offices.location_state,
    office_id,
    count(opportunities.id) as count,
    rank() over (partition by offices.location_state order by count(opportunities.id) desc ) as drnk
from
    offices
inner join
    opportunities on offices.id = opportunities.office_id
where
    offices.location_state='CA'
group by
    offices.location_state,office_id
order by
    count desc;


