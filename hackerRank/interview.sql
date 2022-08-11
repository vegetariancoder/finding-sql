drop database hackerRank;
create database hackerRank;
use hackerRank;

CREATE TABLE IF NOT EXISTS Contests (
contest_id int,
hacker_id int,
name varchar(100));

CREATE TABLE IF NOT EXISTS Colleges (
college_id int,
contest_id int);

CREATE TABLE IF NOT EXISTS Challenges (
challenge_id int,
college_id int);

CREATE TABLE IF NOT EXISTS Views (
challenge_id int,
total_views int,
total_unique_views int);

CREATE TABLE IF NOT EXISTS Submission (
challenge_id int,
total_submission int,
total_accpeted_submission int);


insert into Contests (contest_id,hacker_id,name) values (66406,17973,'Rose');
insert into Contests (contest_id,hacker_id,name) values (66556,79153,'Angela');
insert into Contests (contest_id,hacker_id,name) values (94828,80275,'Frank');


insert into Colleges (college_id,contest_id) values (11219,66406);
insert into Colleges (college_id,contest_id) values (32473,66556);
insert into Colleges (college_id,contest_id) values (56685,94828);


insert into Challenges (challenge_id,college_id) values (18765,11219);
insert into Challenges (challenge_id,college_id) values (47127,11219);
insert into Challenges (challenge_id,college_id) values (60292,32473);
insert into Challenges (challenge_id,college_id) values (72974,56685);

insert into Views (challenge_id,total_views,total_unique_views) values (47127,26,19);
insert into Views (challenge_id,total_views,total_unique_views) values (47127,15,14);
insert into Views (challenge_id,total_views,total_unique_views) values (18765,43,10);
insert into Views (challenge_id,total_views,total_unique_views) values (18765,72,13);
insert into Views (challenge_id,total_views,total_unique_views) values (75516,35,17);
insert into Views (challenge_id,total_views,total_unique_views) values (60292,11,10);
insert into Views (challenge_id,total_views,total_unique_views) values (72974,41,15);
insert into Views (challenge_id,total_views,total_unique_views) values (75516,75,11);


insert into Submission (challenge_id,total_submission,total_accpeted_submission) values (75516,34,12);
insert into Submission (challenge_id,total_submission,total_accpeted_submission) values (47127,27,10);
insert into Submission (challenge_id,total_submission,total_accpeted_submission) values (47127,56,18);
insert into Submission (challenge_id,total_submission,total_accpeted_submission) values (75516,74,12);
insert into Submission (challenge_id,total_submission,total_accpeted_submission) values (75516,83,8);
insert into Submission (challenge_id,total_submission,total_accpeted_submission) values (72974,68,24);
insert into Submission (challenge_id,total_submission,total_accpeted_submission) values (72974,82,14);
insert into Submission (challenge_id,total_submission,total_accpeted_submission) values (47127,28,11);


select
    Contests.contest_id,
    hacker_id,
    name,
    total_views,
    total_unique_views,
    total_submission,
    total_accpeted_submission
from
    (
select
    views_tb.contest_id as contest_id,
    ifnull(total_views,0) as total_views,
    ifnull(total_unique_views,0) as total_unique_views,
    ifnull(total_submission,0) as total_submission,
    ifnull(total_accpeted_submission,0) as total_accpeted_submission
from
(select
    Colleges.contest_id,
    sum(Views.total_views) as total_views,
    sum(Views.total_unique_views) as total_unique_views
from
    Colleges
inner join
    Challenges on Colleges.college_id = Challenges.college_id
inner join
    Views on Challenges.challenge_id = Views.challenge_id
group by
    Colleges.contest_id) views_tb
left join
(select
    contest_id,
    sum(total_submission) as total_submission,
    sum(total_accpeted_submission) as total_accpeted_submission
from
    Submission
inner join
    Challenges on Submission.challenge_id = Challenges.challenge_id
inner join
    Colleges on Challenges.college_id = Colleges.college_id
group by
    contest_id) submission_tb
on
    views_tb.contest_id = submission_tb.contest_id) calculated_tb
inner join
    Contests
on
    calculated_tb.contest_id = Contests.contest_id;






