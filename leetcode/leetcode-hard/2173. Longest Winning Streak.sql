
use leetcode;

SET GLOBAL time_zone = '+3:00';

drop table if exists Matches;
CREATE TABLE IF NOT EXISTS Matches (
player_id INT,
match_day date,
result varchar(100));

insert into Matches (player_id,match_day,result) values (1,'2022-01-17','Win'),
                                                (1,'2022-01-18','Win'),
                                                (1,'2022-01-25','Win'),
                                                (1,'2022-01-31','Draw'),
                                                (1,'2022-02-01','Win'),
                                                (1,'2022-02-02','Win'),
                                                (1,'2022-02-03','Win'),
                                                (1,'2022-02-04','Win'),
                                                (2,'2022-02-06','Lose'),
                                                (2,'2022-02-08','Lose'),
                                                (3,'2022-03-30','Win');


with cte as (
select
    *,
    row_number() over (partition by player_id order by match_day) as rno
from
    Matches),
distinct_cte as (
    select distinct player_id from Matches
)
, temp_cte as (
select
    player_id,
    rno-row_number() over (partition by player_id order by match_day) as win_streak
from
    cte
where
    result='Win')
, answer as (
select
    player_id,
    count(win_streak) as cnt
from
    temp_cte
group by
    player_id,win_streak)
select
    distinct_cte.player_id,
    ifnull(max(cnt),0) as longest_streak
from
    answer
right join
    distinct_cte
on
    answer.player_id=distinct_cte.player_id
group by
    player_id;