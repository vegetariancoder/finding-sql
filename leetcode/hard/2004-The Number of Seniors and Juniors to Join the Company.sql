drop database leetcode;
create database leetcode;
use leetcode;

create table Candidates
(
employee_id int,
experience Varchar(20),
salary int
);
INSERT INTO Candidates values(1,'Junior',10000);
INSERT INTO Candidates values(9,'Junior',10000);
INSERT INTO Candidates values(2,'Senior',20000);
INSERT INTO Candidates values(11,'Senior',20000);
INSERT INTO Candidates values(13,'Senior',50000);
INSERT INTO Candidates values(4,'Junior',40000);


select * from Candidates;

select
    experience,
    count(*) as accepted_candidates
from
    (
with answer as (
select
    *,
    sum(salary) over (partition by experience order by salary rows between unbounded preceding and current row ) as _running_salary
from
    Candidates),
seniors as (
select
    *
from
    answer
where
    experience='Senior' and _running_salary <= 70000)
select
    *
from
    answer
where
    experience='Junior' and _running_salary <= 70000 - (select sum(salary) from seniors)
union
    select * from seniors) calculated_table
group by
    experience;





