drop database datalemur;
create database datalemur;
use datalemur;


Create table If Not Exists search_frequency (searches int, num_users int);
insert into search_frequency (searches, num_users) values (1,2);
insert into search_frequency (searches, num_users) values (2,2);
insert into search_frequency (searches, num_users) values (3,3);
insert into search_frequency (searches, num_users) values (4,1);



with mt as (
with recursive exploding as (
    select
        searches,
        num_users,
        1 as cnt
    from
        search_frequency
    union
    select
        searches,
        num_users,
        cnt+1 as cnt
    from
        exploding
    where
        cnt<num_users
)
select
    searches,
    row_number() over (order by searches) as r_no,
    count(searches) over (order by searches rows between unbounded preceding and unbounded following) as cnt
from
    exploding
order by
    searches)
select
    round(sum(searches)/2,2) as result
from
    mt
where
    r_no between cnt*1.0/2 and cnt*1.0/2+1;