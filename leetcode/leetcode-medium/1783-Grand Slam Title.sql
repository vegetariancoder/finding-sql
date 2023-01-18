drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Players (player_id int, player_name varchar(100));
insert into Players (player_id,player_name) value (1,'Nadal');
insert into Players (player_id,player_name) value (2,'Federer');
insert into Players (player_id,player_name) value (3,'Novak');

select * from Players;
Create table If Not Exists Championships (year int, Wimbledon int, Fr_open int, US_open int, Au_open int);
insert into Championships (year,Wimbledon,Fr_open,US_open,Au_open) value (2018,1,1,1,1);
insert into Championships (year,Wimbledon,Fr_open,US_open,Au_open) value (2019,1,1,2,2);
insert into Championships (year,Wimbledon,Fr_open,US_open,Au_open) value (2020,2,1,2,2);


select * from Championships;

with answer as (
select
    player_id,
    sum(cnt) as sum_cnt
from
    (
select
    Wimbledon as player_id,
    count(1) as cnt
from
    Championships
group by
    Wimbledon
union all
select
    Fr_open,
    count(1) as cnt
from
    Championships
group by
    Fr_open
union all
select
    US_open,
    count(1) as cnt
from
    Championships
group by
    US_open
union all
select
    Au_open,
    count(1) as cnt
from
    Championships
group by
    Au_open) calc_table
group by
    player_id)
select
    answer.player_id,
    player_name,
    sum_cnt
from
    answer
left join
    Players
on
    answer.player_id=Players.player_id
order by
    player_id


select
    1 as id,
    sum()
