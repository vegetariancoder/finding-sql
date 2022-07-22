drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Problems (problem_id int, likes int, dislikes int);
insert into Problems (problem_id,likes,dislikes) value (6,1290,425);
insert into Problems (problem_id,likes,dislikes) value (11,2677,8659);
insert into Problems (problem_id,likes,dislikes) value (1,4446,2760);
insert into Problems (problem_id,likes,dislikes) value (7,8569,6086);
insert into Problems (problem_id,likes,dislikes) value (13,2050,4164);
insert into Problems (problem_id,likes,dislikes) value (10,9002,7446);

with 2026_leetcode as (
select
    problem_id,
    (likes/(dislikes+likes))*100 as percentages
from
    Problems)
select
    problem_id
from
    2026_leetcode
where
    percentages < 60;
