drop database strata;
create database strata;
use strata;
Create table If Not Exists players_results (player_id int, match_date date, match_result varchar(100));

select * from players_results;

with answer as (
select
    player_id,
    win_values,
    count(*) as counting,
    row_number() over (partition by player_id order by count(*) desc ) as _rnk
from
    (
select
    player_id,
    r_no - (row_number() over (partition by player_id order by match_date)) as win_values
from
    (
select
    player_id,
    match_date,
    match_result,
    row_number() over (partition by player_id order by match_date) as r_no
from
    players_results) calc_table
where
    match_result='W') calc_table2
group by
    player_id, win_values)
select player_id,counting from answer where _rnk=1;

