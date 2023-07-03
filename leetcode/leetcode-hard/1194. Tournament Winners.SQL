use leetcode;
SET GLOBAL time_zone = '+3:00';

Create table If Not Exists Matches (match_id int, first_player int , second_player int, first_score int, second_score int    );

insert into Matches (match_id,first_player,second_player,first_score,second_score) values(1,15,45,3,0),
                                                                                          (2,30,25,1,2),
                                                                                          (3,30,15,2,0),
                                                                                          (4,40,20,5,2),
                                                                                          (5,35,50,1,1);

Create table If Not Exists Players (player_id int, group_id int );

insert into Players (player_id,group_id) values(15,1),
                                                (25,1),
                                                (30,1),
                                                (45,1),
                                                (10,2),
                                                (35,2),
                                                (50,2),
                                                (20,3),
                                                (40,3);


with players_score as (
select
    first_player as player,
    sum(case
        when first_score > second_score then 1
    end) as points
from
    Matches
group by
    first_player
union all
select
    second_player as player,
    sum(case
        when first_score < second_score then 1
    end) as points
from
    Matches
group by
    second_player)
, players_points as (
select
    player,
    ifnull(sum(points),0) as points
from
    players_score
group by
    player)
, answer as (
select
    player,
    group_id,
    points,
    dense_rank() over (partition by group_id order by points desc ,player ) as drnk
from
    players_points
inner join
    Players
on
    players_points.player = Players.player_id)
select
    group_id,
    player
from
    answer
where
    drnk=1;