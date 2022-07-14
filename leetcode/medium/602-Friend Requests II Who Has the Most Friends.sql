use leetcode;

create table RequestAccepted (requester_id int, accepter_id int);
insert into RequestAccepted values (1,2),
                                   (1,3),
                                   (2,3),
                                   (3,4);

select * from RequestAccepted;

SET GLOBAL time_zone = '+3:00';

with 602_leetcode as (
select
    id,
    sum(cv) as sum_cv,
    dense_rank() over (order by sum(cv) desc ) drnk
from
    (
select
    requester_id as id,
    count(requester_id) as cv
from
    RequestAccepted
group by
    requester_id
union all
select
    accepter_id as id,
    count(accepter_id) as cv
from
    RequestAccepted
group by
    accepter_id) tab1
group by
    id)
select
    id,
    sum_cv as num
from
    602_leetcode
where
    drnk=1;


