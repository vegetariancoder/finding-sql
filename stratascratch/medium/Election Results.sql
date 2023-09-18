with cte as (
select
    voter,
    candidate,
    count(voter) over (partition by voter) as cnt,
    count(candidate) as cnd_cnt
from
    voting_result
group by
    voter, candidate),
answer as (
select
    candidate,
    sum((cnd_cnt/cnt)) as act_vote,
    dense_rank()  over (order by sum((cnd_cnt/cnt)) desc ) as drnk
from
    cte
group by
    candidate)
select
    candidate
from
    answer
where
    drnk=1;






