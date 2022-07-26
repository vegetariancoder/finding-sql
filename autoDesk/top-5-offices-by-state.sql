-- What are the top 5 offices by state in terms of opportunities received?

use autodesk;


with answer as (
select
    offices.location_state,
    office_id,
    count(opportunities.id) as opps_received,
    rank() over (partition by offices.location_state order by count(opportunities.id) desc ) as drnk
from
    offices
inner join
    opportunities on offices.id = opportunities.office_id
where
    offices.location_state is not null
group by
    offices.location_state,office_id
order by
    location_state)
select
    location_state,
    drnk,
    office_id,
    opps_received
from
    answer
where
    drnk <=5;



