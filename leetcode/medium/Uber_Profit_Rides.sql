drop database leetcode;
create database leetcode;
use leetcode;

create table drivers(id varchar(10), start_time time, end_time time, start_loc varchar(10), end_loc varchar(10));
insert into drivers values('dri_1', '09:00', '09:30', 'a','b'),('dri_1', '09:30', '10:30', 'b','c'),('dri_1','11:00','11:30', 'd','e');
insert into drivers values('dri_1', '12:00', '12:30', 'f','g'),('dri_1', '13:30', '14:30', 'c','h');
insert into drivers values('dri_2', '12:15', '12:30', 'f','g'),('dri_2', '13:30', '14:30', 'c','h');


select * from drivers;

with answer as (
select
    *,
    if(end_loc=next_start_loc,'Yes','No') as checks
from
    (
select
    *,
    lead(start_loc) over (partition by id order by start_time rows between unbounded preceding and unbounded following) as next_start_loc
from
    drivers) calc_table)
select
    id,
    count(id) as total_rides,
    sum(IF(checks = 'Yes', 1, 0)) as profit_rides
from
    answer
group by
    id;