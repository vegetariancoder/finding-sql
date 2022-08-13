drop database hackerRank;
create database hackerRank;
use hackerRank;

CREATE TABLE IF NOT EXISTS Hackers (
hacker_id int,
name varchar(100));

CREATE TABLE IF NOT EXISTS Submissions (
submission_date date,
submission_id int,
hacker_id int,
score int
);


insert into Hackers (hacker_id,name) values (15758,'Rose');
insert into Hackers (hacker_id,name) values (20703,'Angela');
insert into Hackers (hacker_id,name) values (36396,'Frank');
insert into Hackers (hacker_id,name) values (38289,'Patrick');
insert into Hackers (hacker_id,name) values (44065,'Lisa');
insert into Hackers (hacker_id,name) values (53473,'Kimberly');
insert into Hackers (hacker_id,name) values (62529,'Bonnie');
insert into Hackers (hacker_id,name) values (79722,'Micheal');


insert into Submissions (submission_date,submission_id,hacker_id,score) values ('2016-03-01',8494,20703,0);
insert into Submissions (submission_date,submission_id,hacker_id,score) values ('2016-03-01',22403,53473,15);
insert into Submissions (submission_date,submission_id,hacker_id,score) values ('2016-03-01',23965,79722,60);
insert into Submissions (submission_date,submission_id,hacker_id,score) values ('2016-03-01',30173,36396,70);
insert into Submissions (submission_date,submission_id,hacker_id,score) values ('2016-03-02',34928,20703,0);
insert into Submissions (submission_date,submission_id,hacker_id,score) values ('2016-03-02',38740,15758,60);
insert into Submissions (submission_date,submission_id,hacker_id,score) values ('2016-03-02',42769,79722,25);
insert into Submissions (submission_date,submission_id,hacker_id,score) values ('2016-03-02',44364,79722,60);
insert into Submissions (submission_date,submission_id,hacker_id,score) values ('2016-03-03',45440,20703,0);
insert into Submissions (submission_date,submission_id,hacker_id,score) values ('2016-03-03',49050,36396,70);
insert into Submissions (submission_date,submission_id,hacker_id,score) values ('2016-03-03',50273,79722,5);
insert into Submissions (submission_date,submission_id,hacker_id,score) values ('2016-03-04',50344,20703,0);
insert into Submissions (submission_date,submission_id,hacker_id,score) values ('2016-03-04',51360,44065,90);
insert into Submissions (submission_date,submission_id,hacker_id,score) values ('2016-03-04',54404,53473,65);
insert into Submissions (submission_date,submission_id,hacker_id,score) values ('2016-03-04',61533,79722,45);
insert into Submissions (submission_date,submission_id,hacker_id,score) values ('2016-03-05',72852,20703,0);
insert into Submissions (submission_date,submission_id,hacker_id,score) values ('2016-03-05',74546,38289,0);
insert into Submissions (submission_date,submission_id,hacker_id,score) values ('2016-03-05',76487,62529,0);
insert into Submissions (submission_date,submission_id,hacker_id,score) values ('2016-03-05',82439,36396,10);
insert into Submissions (submission_date,submission_id,hacker_id,score) values ('2016-03-05',90006,36396,40);
insert into Submissions (submission_date,submission_id,hacker_id,score) values ('2016-03-06',90404,20703,0);


with answer as (
select
    submission_date,
    hacker_id,
    count(score) as counting,
    dense_rank() over (partition by submission_date order by count(score) desc,hacker_id) as drnk
from
    Submissions
group by
    submission_date,hacker_id)
select
    submission_date,
    answer.hacker_id,
    name
from
    answer
left join
    Hackers
on
    answer.hacker_id = Hackers.hacker_id
where
    drnk=1;


