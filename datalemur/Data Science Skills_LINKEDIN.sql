drop database datalemur;
create database datalemur;
use datalemur;


Create table If Not Exists candidates (candidate_id int, skill varchar(100));
insert into candidates (candidate_id, skill) values (123,'Python');
insert into candidates (candidate_id, skill) values (123,'Tableau');
insert into candidates (candidate_id, skill) values (123,'PostgreSQL');
insert into candidates (candidate_id, skill) values (234,'R');
insert into candidates (candidate_id, skill) values (234,'PowerBI');
insert into candidates (candidate_id, skill) values (234,'SQL Server');
insert into candidates (candidate_id, skill) values (345,'Python');
insert into candidates (candidate_id, skill) values (345,'Tableau');


select * from candidates;

with answer as (
select
    candidate_id
from
    candidates
where
    skill='Python'
union all
select
    candidate_id
from
    candidates
where
    skill='Tableau'
union all
select
    candidate_id
from
    candidates
where
    skill='PostgreSQL')
select candidate_id from answer group by candidate_id having count(*)=3;