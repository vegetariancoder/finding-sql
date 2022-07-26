-- What is the cumulative % of opportunities by day?
use autodesk;
with main_answer as (
with answer as (
select
    date_created,
    location_state,
    count(opportunities.id) as opp_count
from
    opportunities
group by
    date_created, location_state)
select
    date_created,
    location_state,
    opp_count,
    sum(opp_count) over (partition by location_state order by date_created) as cumulative_opps_received
from
    answer
where
    location_state is not null)
select
    date_created,
    location_state,
    opp_count,
    percent_rank() over (partition by location_state order by cumulative_opps_received) * 100
from
    main_answer;