drop database strata;
create database strata;
use strata;

select * from events;

with selected_events as (
select
    user_id,
    count(id) as selected_cnt
from
    events
where
    event_type in ('video call received', 'video call sent', 'voice call received', 'voice call sent')
group by
    user_id),
all_events as (select
    user_id,
    count(*) as all_cnt
from
    events
group by
    user_id)
, percentage_check as (
select
    selected_events.*,
    all_events.all_cnt,
    if(selected_events.selected_cnt/all_events.all_cnt>=0.50,'Yes','No') as flagging

from
    selected_events
inner join
    all_events
on
    selected_events.user_id = all_events.user_id),
answer as (
select
    client_id,
    count(*) as cnt,
    dense_rank() over (order by count(*) desc ) as drnk
from
    events
where
    user_id in (select user_id from percentage_check where flagging='Yes')
group by
    client_id)
select
    client_id
from
    answer
where
    drnk=1;