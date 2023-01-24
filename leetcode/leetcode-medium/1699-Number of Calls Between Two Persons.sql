drop database leetcode;
create database leetcode;
use leetcode;

create table Calls
(
    from_id int null,
    to_id        int null,
    duration     int null
);

insert into Calls (from_id,to_id,duration) values (1,2,59),
                                                  (2,1,11),
                                                  (1,3,20),
                                                  (3,4,100),
                                                  (3,4,200),
                                                  (3,4,200),
                                                  (4,3,499);


select * from Calls;


with answer as (
select
    from_id,
    to_id,
    duration
from
    (
select
    from_id,
    to_id,
    duration
from
    Calls
union all
select
    to_id,
    from_id,
    duration
from
    Calls)calc_table
where
    from_id<to_id)
select
    from_id,
    to_id,
    count(1) as call_count,
    sum(duration) as total_duration
from
    answer
group by
    from_id, to_id;