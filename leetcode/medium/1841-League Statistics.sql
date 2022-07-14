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




with 1841_leetcode as (
select
    team_id,
    sum(score) as score,
    sum(count_matches) as count_matches,
    sum(goal_for) as goal_for,
    sum(goal_against) as goal_against
from
    (
select
    home_team_id as team_id,
    sum(case
        when home_team_goals > away_team_goals then 3
        when home_team_goals = away_team_goals then 1
        else 0
    end) as score,
    count(*) as count_matches,
    sum(home_team_goals) as goal_for,
    sum(away_team_goals) as goal_against
from
    Matches
group by
    home_team_id
union all
select
    away_team_id as team_id,
    sum(case
        when away_team_goals > home_team_goals then 3
        when away_team_goals = home_team_goals then 1
        else 0
    end) as score,
    count(*) as count_matches,
    sum(away_team_goals) as goal_for,
    sum(home_team_goals) as goal_against
from
    Matches
group by
    away_team_id) ut
group by
    team_id)
select
    team_name,
    score,
    count_matches,
    goal_for,
    goal_against
from
    Teams
right join
    1841_leetcode
on
    Teams.team_id = 1841_leetcode.team_id
order by
    team_name desc ;