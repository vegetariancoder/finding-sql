Create table If Not Exists Candidate (id int, Name varchar(255));
Create table If Not Exists Vote (id int, CandidateId int);

Truncate table Candidate;
insert into Candidate (id, Name) values ('1', 'A');
insert into Candidate (id, Name) values ('2', 'B');
insert into Candidate (id, Name) values ('3', 'C');
insert into Candidate (id, Name) values ('4', 'D');
insert into Candidate (id, Name) values ('5', 'E');

Truncate table Vote;
insert into Vote (id, CandidateId) values ('1', '2');
insert into Vote (id, CandidateId) values ('2', '4');
insert into Vote (id, CandidateId) values ('3', '3');
insert into Vote (id, CandidateId) values ('4', '2');
insert into Vote (id, CandidateId) values ('5', '5');

with 574_leetcode as (
select
    name,
    count(Vote.id) as vote_count,
    dense_rank() over (order by count(Vote.id) desc ) drnk
from
    Vote
inner join
    Candidate
on
    Vote.CandidateId = Candidate.id
group by
    name)
select
    name
from
    574_leetcode
where
    drnk = 1;




