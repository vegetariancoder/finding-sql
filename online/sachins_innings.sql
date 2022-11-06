use online;

select * from sachin_batting;


select
    milestone_number,
    milestone_run,
    Innings,
    `Match`

from
     (
with answer1 as (
select
    `Match`,
    Innings,
    Runs,
    sum(Runs) over (order by `Match`, Innings rows unbounded preceding) as rolling_sum
from
    sachin_batting),
answer2 as (
select
    1 as milestone_number, 1000 as milestone_run
union
select
    2 as milestone_number, 5000 as milestone_run
union
select
    3 as milestone_number, 10000 as milestone_run
    )
select
    *,
    row_number() over (partition by milestone_number order by `Match`,Innings) as r_no
from
answer2
inner join
answer1
on
    rolling_sum>milestone_run) calc_table
where
    r_no=1;

