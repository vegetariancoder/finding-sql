drop database hackerRank;
create database hackerRank;
use hackerRank;

CREATE TABLE IF NOT EXISTS Hackers (
    hacker_id int,
    name varchar(100));

CREATE TABLE IF NOT EXISTS Challenges (
    challenge_id int,
    hacker_id int);

insert into Hackers (hacker_id,name) values (5077,'Rose');
insert into Hackers (hacker_id,name) values (21283,'Angela');
insert into Hackers (hacker_id,name) values (62743,'Frank');
insert into Hackers (hacker_id,name) values (88255,'Patrick');
insert into Hackers (hacker_id,name) values (96196,'Lisa');


insert into Challenges (challenge_id,hacker_id) values (61654,5077);
insert into Challenges (challenge_id,hacker_id) values (58302,21283);
insert into Challenges (challenge_id,hacker_id) values (40587,88255);
insert into Challenges (challenge_id,hacker_id) values (29477,5077);
insert into Challenges (challenge_id,hacker_id) values (1220,21283);
insert into Challenges (challenge_id,hacker_id) values (69514,21283);
insert into Challenges (challenge_id,hacker_id) values (46561,62743);
insert into Challenges (challenge_id,hacker_id) values (58077,62743);
insert into Challenges (challenge_id,hacker_id) values (18483,88255);
insert into Challenges (challenge_id,hacker_id) values (76766,21283);
insert into Challenges (challenge_id,hacker_id) values (52382,5077);
insert into Challenges (challenge_id,hacker_id) values (74467,21283);
insert into Challenges (challenge_id,hacker_id) values (33625,96196);
insert into Challenges (challenge_id,hacker_id) values (26053,88255);
insert into Challenges (challenge_id,hacker_id) values (42665,62743);
insert into Challenges (challenge_id,hacker_id) values (12859,62743);
insert into Challenges (challenge_id,hacker_id) values (70094,21283);
insert into Challenges (challenge_id,hacker_id) values (34599,88255);
insert into Challenges (challenge_id,hacker_id) values (54680,88255);
insert into Challenges (challenge_id,hacker_id) values (61881,5077);


with answer as (
select
    Hackers.hacker_id,
    name,
    count(challenge_id) as count_values
from
    Hackers
inner join
    Challenges on Hackers.hacker_id = Challenges.hacker_id
group by
    hacker_id, name
order by
    count_values)
select
    hacker_id,
    name,
    count_values
from
    answer
where
    count_values not in (select count_values from answer group by count_values having count(*) > 1)
order by
    count_values desc ;

