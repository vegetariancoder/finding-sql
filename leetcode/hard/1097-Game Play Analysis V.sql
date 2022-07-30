drop database leetcode;
create database leetcode;
use leetcode;
CREATE TABLE IF NOT EXISTS Activity (player_id int, device_id  int, event_date date, games_played int);
insert into Activity (player_id, device_id, event_date,games_played) values (1,2,'2016-03-01',5);
insert into Activity (player_id, device_id, event_date,games_played) values (1,2,'2016-03-02',6);
insert into Activity (player_id, device_id, event_date,games_played) values (2,3,'2017-06-25',1);
insert into Activity (player_id, device_id, event_date,games_played) values (3,1,'2016-03-01',0);
insert into Activity (player_id, device_id, event_date,games_played) values (3,4,'2016-07-03',5);


select
    install_dt,
    installs,
    round((retention_sum/installs),2) as Day1_retention
from
    (
select
    min_date as install_dt,
    count(min_date) as installs
from
    (
select
    min(event_date) as min_date
from
    Activity
group by
    player_id) installs_tab
group by
    min_date) inst_table
left join
(select
    event_date,
    sum(if(diff=1,1,0)) as retention_sum
from
    (
select
    *,
    lead(event_date) over (partition by player_id order by event_date) - Activity.event_date as diff
from
    Activity) retention_tab
group by
    event_date) ret_table
on
    inst_table.install_dt = ret_table.event_date;