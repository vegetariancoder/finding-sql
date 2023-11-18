drop database online;
create database online;
use online;


CREATE TABLE player (
    playerid INT,
    deviceid int,
    event date,
    games int
);

INSERT INTO player (playerid, deviceid, event,games)
VALUES
    (1, 2, '2016-03-01',5),
    (1, 2, '2016-03-02',5),
    (2, 3, '2017-06-25',5),
    (3, 1, '2016-03-02',5),
    (3, 4, '2018-07-03',5);


select * from player;


with answer as (
select
    *,
    if(datediff(lead(event) over (partition by playerid order by playerid),event)=1,'Yes','No') as consec
from
    player)
select
    round(count(playerid)/ (select count(distinct playerid) from player),2) as fraction
from
    answer
where
    consec='Yes';