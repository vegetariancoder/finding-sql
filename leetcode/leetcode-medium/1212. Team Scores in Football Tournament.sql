use leetcode;

SET GLOBAL time_zone = '+3:00';

CREATE TABLE IF NOT EXISTS Teams (
team_id INT,
team_name varchar(100));

insert into Teams (team_id,team_name) values (10,'Leetcode FC'),
(20,'NewYork FC'),
(30,'Atlanta FC'),
(40,'Chicago FC'),
(50,'Toronto FC');



CREATE TABLE IF NOT EXISTS MatchesTable (
match_id INT,
host_team int,
guest_team int,
host_goals int,
guest_goals int);


insert into MatchesTable (match_id,host_team,guest_team,host_goals,guest_goals) values (1,10,20,3,0),
(2,30,10,2,2),
(3,10,50,5,1),
(4,20,30,1,0),
(5,50,30,1,0);


with answer as (
select
    host_team as team,
    sum(host_point) + sum(common_point) as num_points
from
    (
select
    *,
    if(host_goals>guest_goals,3,0) as host_point,
    if(host_goals=guest_goals,1,0) as common_point
from
    MatchesTable) host_calc
group by
    host_team
union all
select
    guest_team as team,
    sum(guest_point) + sum(common_point) as num_points
from
    (
select
    *,
    if(host_goals<guest_goals,3,0) as guest_point,
    if(host_goals=guest_goals,1,0) as common_point
from
    MatchesTable) host_calc
group by
    guest_team)
select
    team_id,
    team_name,
    ifnull(sum(num_points),0) as num_points
from
    answer
right join
    Teams
on
    answer.team=Teams.team_id
group by
    team_id,team_name
order by
    num_points desc ;