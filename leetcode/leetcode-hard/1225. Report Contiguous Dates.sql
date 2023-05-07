drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Failed (fail_date date);
insert into Failed (fail_date) value ('2018-12-28');
insert into Failed (fail_date) value ('2018-12-29');
insert into Failed (fail_date) value ('2019-01-04');
insert into Failed (fail_date) value ('2019-01-05');

Create table If Not Exists Succeeded (success_date date);
insert into Succeeded (success_date) value ('2018-12-30');
insert into Succeeded (success_date) value ('2018-12-31');
insert into Succeeded (success_date) value ('2019-01-01');
insert into Succeeded (success_date) value ('2019-01-02');
insert into Succeeded (success_date) value ('2019-01-03');
insert into Succeeded (success_date) value ('2019-01-06');


with answer as (
select
    'succeeded' as period_state,
    min(success_date) as start_date,
    max(success_date) as end_date
from
    (
select
    *,
    row_number() over (order by success_date) as rn,
    day(success_date)-row_number() over (order by success_date) as checking
from
    Succeeded
where
    success_date between '2019-01-01' and '2019-12-31') calc_success
group by
    period_state,checking
union all
select
    'failed' as period_state,
    min(fail_date) as start_date,
    max(fail_date) as end_date
from
    (
select
    *,
    row_number() over (order by fail_date) as rn,
    day(fail_date)-row_number() over (order by fail_date) as checking
from
    Failed
where
    fail_date between '2019-01-01' and '2019-12-31') calc_fail
group by
    period_state,checking)
select
    *
from
    answer
order by
    start_date;