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

with 1194_leetcode as (
select
    player_id,
    group_id,
    ifnull(max_score,0) as score,
    dense_rank() over (partition by group_id order by max_score desc,player_id ) as drnk
from
    (
select
    first_player as player,
    max(first_score) as max_score
from
    Matches
where
    first_score>Matches.second_score
group by
    first_player
union all
select
    second_player as player,
    max(second_score) as max_score
from
    Matches
where
    first_score<Matches.second_score
group by
    second_player
union all
select
    first_player,
    max(first_score) as max_score_1
from
    Matches
where
    first_score=Matches.second_score
group by
    first_player
union all
select
    second_player,
    max(second_score) as max_score_1
from
    Matches
where
    first_score=Matches.second_score
group by
    second_player)full_table
right join
        Players
on
    full_table.player = Players.player_id)
select
    group_id,
    player_id
from
    1194_leetcode
where
    drnk=1;





