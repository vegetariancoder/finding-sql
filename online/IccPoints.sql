use online;
create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

select * from icc_world_cup;

with total_matches as (
select
    Team_1 as Team_Name,
    count(*) as Matches_Played
from
    icc_world_cup
group by
    Team_1
union all
select
    Team_2 as Team_Name,
    count(*) as Matches_Played
from
    icc_world_cup
group by
    Team_2)
,number_of_wins as (
select
    Team_1 as Team_Name,
    case
        when Winner=Team_1 then 1 else 0
    end as winner
from
    icc_world_cup
union all
select
    Team_2 as Team_Name,
    case
        when Winner=Team_2 then 1 else 0
    end as winner
from
    icc_world_cup
),
total_matches_played as (
select
    Team_Name,
    sum(Matches_Played) as Matches_Played
from
    total_matches
group by
    Team_Name)
, total_matches_win as (
select
    Team_Name,
    sum(winner) as no_of_wins
from
    number_of_wins
group by
    Team_Name)
, number_of_loss as (
    select
    Team_1 as Team_Name,
    case
        when Winner!=Team_1 then 1 else 0
    end as loser
from
    icc_world_cup
union all
select
    Team_2 as Team_Name,
    case
        when Winner!=Team_2 then 1 else 0
    end as loser
from
    icc_world_cup
),
 total_matches_loss as (
select
    Team_Name,
    sum(loser) as no_of_losses
from
    number_of_loss
group by
    Team_Name)
select
    total_matches_played.Team_Name,
    total_matches_played.Matches_Played,
    total_matches_win.no_of_wins,
    total_matches_loss.no_of_losses
from
    total_matches_played
inner join
    total_matches_win
on
    total_matches_played.Team_Name = total_matches_win.Team_Name
inner join
    total_matches_loss
on
    total_matches_played.Team_Name = total_matches_loss.Team_Name;