drop database strata;
create database strata;
use strata;
create table sat_scores
(
school varchar(10),
teacher varchar(10),
student_id float,
sat_writing float,
sat_verbal float,
sat_math float,
hrs_studied float,
id int,
average_sat float,
love varchar(100)
);

select * from sat_scores;

with answer as (
select
    student_id,
    sat_writing,
    row_number() over (order by sat_writing) as r_no,
    count(*) over (order by student_id rows between unbounded preceding and unbounded following) as cnt
from
    sat_scores
order by
    r_no)
select
    student_id,
    sat_writing
from
    answer
where
    r_no between cnt*1.0/2 and cnt*1.0/2+1;