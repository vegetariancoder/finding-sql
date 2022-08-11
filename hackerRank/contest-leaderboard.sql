drop database hackerRank;
create database hackerRank;
use hackerRank;

CREATE TABLE IF NOT EXISTS Hackers (
hacker_id int,
name varchar(100));

CREATE TABLE IF NOT EXISTS Submissions (
submission_id int,
hacker_id int,
challenge_id int,
score int);

insert into Hackers (hacker_id,name) values (4071,'Rose');
insert into Hackers (hacker_id,name) values (4806,'Angela');
insert into Hackers (hacker_id,name) values (26071,'Frank');
insert into Hackers (hacker_id,name) values (49438,'Patrick');
insert into Hackers (hacker_id,name) values (74842,'Lisa');
insert into Hackers (hacker_id,name) values (80305,'Kimberly');
insert into Hackers (hacker_id,name) values (84072,'Bonnie');
insert into Hackers (hacker_id,name) values (87868,'Michael');
insert into Hackers (hacker_id,name) values (92118,'Todd');
insert into Hackers (hacker_id,name) values (95895,'Joe');

insert into Submissions (submission_id,hacker_id,challenge_id,score) values (67194,74842,63132,76);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (64479,74842,19797,98);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (40742,26071,49593,20);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (17513,4806,49593,32);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (69846,80305,19797,19);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (41002,26071,89343,36);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (52826,49438,49593,9);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (31093,26071,19797,2);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (81614,84072,49593,100);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (44829,26071,89343,17);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (75147,80305,49593,48);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (14115,4806,49593,76);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (6943,4071,19797,95);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (12855,4806,25917,13);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (73343,80305,49593,42);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (84264,84072,63132,0);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (9951,4071,49593,43);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (45104,49438,25917,34);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (53795,74842,19797,5);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (26363,26071,19797,29);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (10063,4071,49593,96);

with answer as (
select
    Submissions.hacker_id,
    name,
    challenge_id,
    max(score) as max_score
from
    Hackers
inner join
    Submissions on Hackers.hacker_id = Submissions.hacker_id
group by
    Submissions.hacker_id, name, challenge_id)
select
    hacker_id,
    name,
    sum(max_score) as score
from
    answer
group by
    hacker_id, name
order by
    score desc ;