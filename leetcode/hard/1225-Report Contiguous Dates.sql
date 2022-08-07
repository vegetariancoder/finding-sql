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


select
    'succeeded' as period_state,
    start_date,
    date_add(start_date,interval counted_days-1 day) as end_date
from
    (
select
    min(success_date) as start_date,
    count(*) as counted_days
from
    (
select
    *,
    datediff(success_date,'1970-01-01')-row_number() over (order by success_date) as partition_id
from
    Succeeded
where
    year(success_date) = '2019') partitioned_table
group by
    partition_id) nt
union all
select
    'failed' as period_state,
    start_date,
    date_add(start_date,interval counted_days-1 day ) as end_date
from
    (
select
    min(fail_date) as start_date,
    count(*) as counted_days
from
    (
select
    *,
    datediff(fail_date,'1970-01-01')-row_number() over (order by fail_date) as partitioned_id
from
    Failed
where
    year(fail_date)='2019') partitioned_table
group by
    partitioned_id) nt2
order by
    start_date;





