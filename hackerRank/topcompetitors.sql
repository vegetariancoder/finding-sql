use hackerRank;

CREATE TABLE IF NOT EXISTS Hackers (
    hacker_id int,
    name varchar(100));

CREATE TABLE IF NOT EXISTS Difficulty (
    difficult_level int,
    score int);

CREATE TABLE IF NOT EXISTS Challenges (
    challenge_id int,
    hacker_id int,
    difficulty_level int);

CREATE TABLE IF NOT EXISTS Submissions (
    submission_id int,
    hacker_id int,
    challenge_id int,
    score int);

insert into Hackers (hacker_id,name) values (5580,'Rose');
insert into Hackers (hacker_id,name) values (8439,'Angela');
insert into Hackers (hacker_id,name) values (27205,'Frank');
insert into Hackers (hacker_id,name) values (52243,'Patrick');
insert into Hackers (hacker_id,name) values (52348,'Lisa');
insert into Hackers (hacker_id,name) values (57645,'Kimberly');
insert into Hackers (hacker_id,name) values (77726,'Bonnie');
insert into Hackers (hacker_id,name) values (83082,'Michael');
insert into Hackers (hacker_id,name) values (86870,'Todd');
insert into Hackers (hacker_id,name) values (90411,'Joe');



insert into Difficulty (difficult_level,score) values (1,20);
insert into Difficulty (difficult_level,score) values (2,30);
insert into Difficulty (difficult_level,score) values (3,40);
insert into Difficulty (difficult_level,score) values (4,60);
insert into Difficulty (difficult_level,score) values (5,80);
insert into Difficulty (difficult_level,score) values (6,100);
insert into Difficulty (difficult_level,score) values (7,120);


insert into Challenges (challenge_id,hacker_id,difficulty_level) values (4810,77726,4);
insert into Challenges (challenge_id,hacker_id,difficulty_level) values (21089,27205,1);
insert into Challenges (challenge_id,hacker_id,difficulty_level) values (36566,5580,7);
insert into Challenges (challenge_id,hacker_id,difficulty_level) values (66730,52243,6);
insert into Challenges (challenge_id,hacker_id,difficulty_level) values (71055,52243,2);


insert into Submissions (submission_id,hacker_id,challenge_id,score) values (68628,77726,36566,30);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (65300,77726,21089,10);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (40326,52243,36566,77);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (8941,27205,4810,4);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (83554,77726,66730,30);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (43353,52243,66730,0);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (55385,52348,71055,20);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (39784,27205,71055,23);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (94613,86870,71055,30);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (45788,52348,36566,0);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (93058,86870,36566,30);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (7344,8439,66730,92);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (2721,8439,4810,36);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (523,5580,71055,4);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (49105,52348,66730,0);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (55877,57645,66730,80);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (38355,27205,66730,35);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (3924,8439,36566,80);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (97397,90411,66730,100);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (84162,83082,4810,40);
insert into Submissions (submission_id,hacker_id,challenge_id,score) values (97431,90411,71055,30);

select
    hacker_id,
    name
from
    Hackers
where
    hacker_id in (
with answer as (
select
    hacker_id,
    difficulty_table.score as actual_score,
    Difficulty.score as max_Score,
    case
        when difficulty_table.score = Difficulty.score then 'yes' else 'no'
    end as boolean_values
from
    (
select
    Submissions.hacker_id,
    score,
    difficulty_level
from
    Submissions
left join
    Challenges
on
    Submissions.challenge_id = Challenges.challenge_id) difficulty_table #here i find difficulty for each hacker
left join
    Difficulty
on
    difficulty_table.difficulty_level = Difficulty.difficult_level)
select
    hacker_id
from
    answer
where
    boolean_values = 'yes'
group by
    hacker_id
having
    count(*) > 1);

