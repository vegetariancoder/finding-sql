drop database leetcode;
create database leetcode;
use leetcode;
CREATE TABLE IF NOT EXISTS Activity (player_id int, device_id  int, event_date date, games_played int);
insert into Activity (player_id, device_id, event_date,games_played) values (1,2,'2016-03-01',5);
insert into Activity (player_id, device_id, event_date,games_played) values (1,2,'2016-03-02',6);
insert into Activity (player_id, device_id, event_date,games_played) values (2,3,'2017-06-25',1);
insert into Activity (player_id, device_id, event_date,games_played) values (3,1,'2016-03-01',0);
insert into Activity (player_id, device_id, event_date,games_played) values (3,4,'2016-07-03',5);




with next_logins as (
select
    *,
    lead(event_date) over (partition by player_id order by event_date) as next_login
from
    Activity),
install_dates as (select
    player_id,
    min(event_date) as install_date
from
    Activity
group by
    player_id),
retention_count as (
select
    event_date,
    count(*) as retention_cnt
from
    next_logins
where
    next_login-event_date=1
group by
    event_date),
install_count as (
select
    install_date,
    count(*) as install_cnt
from
    install_dates
group by
    install_date)
select
    install_date as install_dt,
    install_cnt as installs,
    round(ifnull((retention_cnt/install_cnt),0),2) Day1_retention
from
    install_count
left join
    retention_count
on
    install_count.install_date = retention_count.event_date;


