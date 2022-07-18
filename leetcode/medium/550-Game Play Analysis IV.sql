drop table  Activity;
CREATE TABLE IF NOT EXISTS Activity (player_id int, device_id int, event_date date, games_played int);
insert into Activity (player_id, device_id,event_date,games_played) values (1,2,'2016-03-01',5);
insert into Activity (player_id, device_id,event_date,games_played) values (1,2,'2016-03-02',6);
insert into Activity (player_id, device_id,event_date,games_played) values (2,3,'2017-06-25',1);
insert into Activity (player_id, device_id,event_date,games_played) values (3,1,'2016-03-02',0);
insert into Activity (player_id, device_id,event_date,games_played) values (3,1,'2016-03-03',0);
#insert into Activity (player_id, device_id,event_date,games_played) values (3,4,'2018-07-03',5);


with 550_leetcode as (
select
    player_id,
    device_id,
    event_date,
    dense_rank() over (partition by device_id order by event_date) as drnk
from
    Activity)
select
    round(count(player_id)/(select count(distinct player_id) from Activity),2) as fraction
from
    550_leetcode
where
    drnk=2;


select
    round(count(A1.device_id)/(select count(distinct player_id) from Activity),2) as fraction
from
    Activity A1, Activity A2
where
    A1.device_id=A2.device_id
and
    A1.event_date < A2.event_date;
