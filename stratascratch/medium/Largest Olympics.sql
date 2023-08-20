select
    games,
    count(distinct id) as athletes_count
from
    olympics_athletes_events
group by
    games
order by
    athletes_count desc
limit 1;