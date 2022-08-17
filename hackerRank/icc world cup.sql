drop database hackerRank;
create database hackerRank;
use hackerRank;
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



select
    'India' as Team,
    count(*) as Matches_played,
    sum(case
        when Winner='India' then 1 else 0
    end) as no_of_wins,
    (count(*)-sum(case
        when Winner='India' then 1 else 0
    end)) as no_of_loss
from
    icc_world_cup
where
    Team_1 = 'India' or Team_2='India'
group by
    Team
union all
select
    'NZ' as Team,
    count(*) as Matches_played,
    sum(case
        when Winner='NZ' then 1 else 0
    end) as no_of_wins,
    (count(*)-sum(case
        when Winner='NZ' then 1 else 0
    end)) as no_of_loss
from
    icc_world_cup
where
    Team_1 = 'NZ' or Team_2='NZ'
group by
    Team
union all
select
    'Aus' as Team,
    count(*) as Matches_played,
    sum(case
        when Winner='Aus' then 1 else 0
    end) as no_of_wins,
    (count(*)-sum(case
        when Winner='Aus' then 1 else 0
    end)) as no_of_loss
from
    icc_world_cup
where
    Team_1 = 'Aus' or Team_2='Aus'
group by
    Team
union all
select
    'Eng' as Team,
    count(*) as Matches_played,
    sum(case
        when Winner='Eng' then 1 else 0
    end) as no_of_wins,
    (count(*)-sum(case
        when Winner='Eng' then 1 else 0
    end)) as no_of_loss
from
    icc_world_cup
where
    Team_1 = 'Eng' or Team_2='Eng'
group by
    Team
union all
select
    'SA' as Team,
    count(*) as Matches_played,
    sum(case
        when Winner='SA' then 1 else 0
    end) as no_of_wins,
    (count(*)-sum(case
        when Winner='SA' then 1 else 0
    end)) as no_of_loss
from
    icc_world_cup
where
    Team_1 = 'SA' or Team_2='SA'
group by
    Team
union all
select
    'SL' as Team,
    count(*) as Matches_played,
    sum(case
        when Winner='SL' then 1 else 0
    end) as no_of_wins,
    (count(*)-sum(case
        when Winner='SL' then 1 else 0
    end)) as no_of_loss
from
    icc_world_cup
where
    Team_1 = 'SL' or Team_2='SL'
group by
    Team;




select team_name,count(team_name) as matches_played,sum(no_of_win) as no_of_win,(count(team_name)-sum(no_of_win)) as no_of_loss
from (
select team_name,
case when winner=Team_name then 1 else 0 end as no_of_win
from (
select Team_1 as team_name,Winner from icc_world_cup
union all
select Team_2 as team_name,Winner from icc_world_cup) a) b
group by team_name
order by no_of_win desc;



