drop database online;
create database online;
use online;


Create Table Match_Result (
Team_1 Varchar(20),
Team_2 Varchar(20),
Result Varchar(20)
);

Insert into Match_Result Values('India', 'Australia','India');
Insert into Match_Result Values('India', 'England','England');
Insert into Match_Result Values('SouthAfrica', 'India','India');
Insert into Match_Result Values('Australia', 'England',NULL);
Insert into Match_Result Values('England', 'SouthAfrica','SouthAfrica');
Insert into Match_Result Values('Australia', 'India','Australia');


select * from Match_Result;

#total matches played


select
    play_table.Team,
    Match_Played,
    Match_Won,
    Match_Tie,
    Match_Played-(Match_Won+Match_Tie) as Match_Lost
from
    (
select
    Team,
    count(*) as Match_Played
from
     (
select
    Team_1 as Team
from
    Match_Result
union all
select
    Team_2 as Team
from
    Match_Result) calc_table
group by
    Team) play_table
inner join
(select
    Team,
    sum(tie) as Match_Tie
from
     (
select
    Team_1 as Team,
    sum(case
        when Result is null then 1 else 0
    end) as tie
from
    Match_Result
group by
    Team_1
union all
select
    Team_2 as Team,
    sum(case
        when Result is null then 1 else 0
    end) as tie
from
    Match_Result
group by
    Team_2) calc_table
group by
    Team) tie_table
on
    play_table.Team=tie_table.Team
inner join
(select
    Result,
    count(*) as Match_Won
from
    Match_Result
where
    Result is not null
group by
    Result) won_table
on
    play_table.Team=won_table.Result
order by
    Team;







-- final answer
select
    Team,
    count(*) as Total_Matches,
    sum(case
        when Result=Team then 1 else 0
    end) as Match_Won,
    sum(case
        when Result is null then 1 else 0
    end) as Match_Tie,
    sum(case
        when Result!=Team then 1 else 0
    end) as Match_Lost
from
     (
select
    Team_1 as Team,
    Result
from
    Match_Result
union all
select
    Team_2 as Team,
    Result
from
    Match_Result)calc_table
group by
    Team
order by
    Team;
