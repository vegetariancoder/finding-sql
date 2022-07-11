use leetcode;

SET GLOBAL time_zone = '+3:00';

drop table Teams;
CREATE TABLE IF NOT EXISTS Teams (
team_id INT,
team_name varchar(100));

insert into Teams (team_id,team_name) values (10,'Leetcode FC'),
(20,'NewYork FC'),
(30,'Atlanta FC'),
(40,'Chicago FC'),
(50,'Toronto FC');


drop table MatchesTable;
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

select * from Teams;
select * from MatchesTable;


with 1212_leetcode as (
select
    team,
    sum(score) as score
from
(
select
    host_team as team,
    sum(case
        when host_goals > guest_goals then 3
        when host_goals = guest_goals then 1
    end) as score
from
    MatchesTable
group by
    host_team
union all
select
    guest_team as team,
    sum(case
        when guest_goals > host_goals then 3
        when guest_goals = host_goals then 1
    end) as score
from
    MatchesTable
group by
    guest_team) ut
group by
    team)
select
    team_id,
    team_name,
    ifnull(score,0) as score
from
    Teams
left join
    1212_leetcode
on
    Teams.team_id = 1212_leetcode.team
order by
    score desc ;
