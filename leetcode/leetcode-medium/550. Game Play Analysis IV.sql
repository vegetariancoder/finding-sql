drop database leetcode;
create database leetcode;
use leetcode;
CREATE TABLE IF NOT EXISTS Activity (player_id int, device_id int, event_date date, games_played int);
insert into Activity (player_id, device_id,event_date,games_played) values (1,2,'2016-03-01',5);
insert into Activity (player_id, device_id,event_date,games_played) values (1,2,'2016-03-02',6);
insert into Activity (player_id, device_id,event_date,games_played) values (2,3,'2017-06-25',1);
insert into Activity (player_id, device_id,event_date,games_played) values (3,1,'2016-03-02',0);
# insert into Activity (player_id, device_id,event_date,games_played) values (3,1,'2016-03-03',0);
insert into Activity (player_id, device_id,event_date,games_played) values (3,4,'2018-07-03',5);

with answer as (
select
    *,
    if(datediff(lead(event_date) over (partition by player_id order by event_date),event_date)=1,'Yes','No') as if_yes
from
    Activity)
select
    round(count(distinct player_id)/(select count(distinct player_id) from Activity),2) as fraction
from
    answer
where
    if_yes='Yes';



with answer as (
select
    player_id,
    lead(event_date) over (partition by player_id order by event_date) - Activity.event_date as diff
from
    Activity)
select round(sum(distinct(case when diff=1 then player_id else null end))/count(distinct player_id),2) as fraction from answer;



with stage as (select player_id, lead(event_date) over (partition by player_id order by event_date)-event_date as dif from activity)
select round(sum(distinct(case when dif=1 then player_id else null end))/count(distinct player_id),2) as fraction from stage;

with cte as
(select player_id,
event_date,
lead(event_date) over (partition by player_id order by event_date)next_date,
dense_rank() over (partition by player_id order by event_date) as rnk from activity
)
select round(sum(case when datediff(next_date,event_date) = 1 then 1 else 0 end)/count(distinct player_id),2)fraction
from cte where rnk = 1





