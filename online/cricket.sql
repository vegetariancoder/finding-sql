drop database online;

create database online;
use online;


create table icc_world_cup
(
match_no int,
team_1 Varchar(20),
team_2 Varchar(20),
winner Varchar(20)
);
INSERT INTO icc_world_cup values(1,'ENG','NZ','NZ');
INSERT INTO icc_world_cup values(2,'PAK','NED','PAK');
INSERT INTO icc_world_cup values(3,'AFG','BAN','BAN');
INSERT INTO icc_world_cup values(4,'SA','SL','SA');
INSERT INTO icc_world_cup values(5,'AUS','IND','IND');
INSERT INTO icc_world_cup values(6,'NZ','NED','NZ');
INSERT INTO icc_world_cup values(7,'ENG','BAN','ENG');
INSERT INTO icc_world_cup values(8,'SL','PAK','PAK');
INSERT INTO icc_world_cup values(9,'AFG','IND','IND');
INSERT INTO icc_world_cup values(10,'SA','AUS','SA');
INSERT INTO icc_world_cup values(11,'BAN','NZ','NZ');
INSERT INTO icc_world_cup values(12,'PAK','IND','IND');



select * from icc_world_cup;

with played as (
select
    team_1 as team,
    count(*) as cnt
from
    icc_world_cup
group by
    team_1
union all
select
    team_2 as team,
    count(*) as cnt
from
    icc_world_cup
group by
    team_2),
total_played as (
select
    team,
    sum(cnt) as total_played
from
    played
group by
    team),
total_win as (
select
    winner,
    count(*) as total_win
from
    icc_world_cup
group by
    winner)
select
    team,
    total_played,
    ifnull(total_win,0) as total_win,
    ifnull(total_played-total_win,total_played) as total_loss,
    ifnull(total_win*2,0) as points
from
    total_played
left join
    total_win
on
    total_played.team = total_win.winner
order by
    points desc ;



with all as (
select
    team_1 as team,
    count(*) as cnt,
    sum(if(team_1 = winner, 1, 0)) as winner
from
    icc_world_cup
group by
    team_1
union all
select
    team_2 as team,
    count(*) as cnt,
    sum(if(team_2 = winner, 1, 0)) as winner
from
    icc_world_cup
group by
    team_2)
select

from




select
    team_1 as team,
    count(*) as cnt,
    sum(if(team_1 = winner, 1, 0)) as winner

from
    icc_world_cup
group by
    team_1;
