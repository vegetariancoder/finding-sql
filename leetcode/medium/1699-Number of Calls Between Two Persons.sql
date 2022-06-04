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

with 1699_leetcode as
(select
    *
from
    Calls
union all
select
    to_id,
    from_id,
    duration
from
    Calls)
select
    from_id as person_1,
    to_id as person_2,
    count(1) as call_count,
    sum(duration) as sum
from
    1699_leetcode
where
    from_id < to_id
group by
    person_1,
    person_2;

