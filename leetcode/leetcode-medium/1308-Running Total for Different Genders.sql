drop database leetcode;
create database leetcode;
use leetcode;
SET GLOBAL time_zone = '+3:00';


CREATE TABLE IF NOT EXISTS Scores (
    player_name varchar(100),
    gender varchar(100),
    day_value date ,
    score_points int);

insert into Scores (player_name,gender,day_value,score_points) values ('Aron','F','2020-01-01', 17);
insert into Scores (player_name,gender,day_value,score_points) values ('Alice','F','2020-01-07', 23);
insert into Scores (player_name,gender,day_value,score_points) values ('Bajrang','M','2020-01-07', 7);
insert into Scores (player_name,gender,day_value,score_points) values ('Khali','M','2019-12-25', 11);
insert into Scores (player_name,gender,day_value,score_points) values ('Slaman','M','2019-12-30', 13);
insert into Scores (player_name,gender,day_value,score_points) values ('Joe','M','2019-12-31', 3);
insert into Scores (player_name,gender,day_value,score_points) values ('Jose','M','2019-12-18', 2);
insert into Scores (player_name,gender,day_value,score_points) values ('Priya','F','2019-12-31', 23);
insert into Scores (player_name,gender,day_value,score_points) values ('Priyanka','F','2019-12-30', 17);



select
    gender,
    day_value,
    sum(score_points) over (partition by gender order by day_value) as total
from
    Scores;