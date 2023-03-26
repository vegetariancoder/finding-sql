drop database leetcode;
create database leetcode;
use leetcode;
CREATE TABLE IF NOT EXISTS Teams (
team_id INT,
team_name varchar(100));

insert into Teams (team_id,team_name) values (1,'Ajax'),
                                             (4,'Dortmund'),
                                             (6,'Arsenal');

CREATE TABLE IF NOT EXISTS Matches (
home_team_id INT,
away_team_id int,
home_team_goals int,
away_team_goals int);

insert into Matches (home_team_id, away_team_id, home_team_goals, away_team_goals)
values (1,4,0,1);
insert into Matches (home_team_id, away_team_id, home_team_goals, away_team_goals)
values (1,6,3,3);
insert into Matches (home_team_id, away_team_id, home_team_goals, away_team_goals)
values (4,1,5,2);
insert into Matches (home_team_id, away_team_id, home_team_goals, away_team_goals)
values (6,1,0,0);



with answer as (
select
    home_team_id as t_id,
    count(home_team_id) as matches_played,
    sum(home_team) as total_points,
    sum(home_team_goals) as goal_for,
    sum(away_team_goals) as goal_against
from
    (
select
    home_team_id,
    home_team_goals,
    away_team_goals,
    case
        when home_team_goals>away_team_goals then 3
        when home_team_goals=away_team_goals then 1
    else 0 end as home_team
from
    Matches)calc
group by
    home_team_id
union all
select
    away_team_id as t_id,
    count(away_team_id) as matches_played,
    sum(away_team) as total_points,
    sum(away_team_goals) as goal_for,
    sum(home_team_goals) as goal_against
from
    (
select
    away_team_id,
    away_team_goals,
    home_team_goals,
    case
        when home_team_goals<away_team_goals then 3
        when home_team_goals=away_team_goals then 1
    else 0 end as away_team
from
    Matches)calc
group by
    away_team_id)
select
    team_name,
    sum(matches_played) as matches_played,
    sum(total_points) as total_points,
    sum(goal_for) as goal_for,
    sum(goal_against) as goal_against,
    sum(goal_for) - sum(goal_against) as goal_diff

from
    answer
left join
    Teams
on
    answer.t_id=Teams.team_id
group by
    team_name
order by
    total_points desc ;


