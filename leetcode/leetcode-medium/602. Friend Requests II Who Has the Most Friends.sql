
use leetcode;

create table RequestAccepted (requester_id int, accepter_id int);
insert into RequestAccepted values (1,2),
                                   (1,3),
                                   (2,3),
                                   (3,4);


select * from RequestAccepted;

with answer as (
select
    id,
    sum(cnt) as num,
    dense_rank() over (order by sum(cnt) desc ) as drnk
from
    (
select
    requester_id as id,
    count(*) as cnt
from
    RequestAccepted
group by
    requester_id
union all
select
    accepter_id as id,
    count(*) as cnt
from
    RequestAccepted
group by
    accepter_id)calc_table
group by
    id)
select
    id,
    num
from
    answer
where
    drnk=1;