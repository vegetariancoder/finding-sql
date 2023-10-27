drop database online;
create database online;

use online;

create table match_score
(
	balls	int,
	runs	int
);

create table testing as (
SELECT row_number() over (order by (select null)) as number
FROM (
    SELECT 0 as n UNION ALL
    SELECT 1 UNION ALL
    SELECT 2 UNION ALL
    SELECT 3 UNION ALL
    SELECT 4 UNION ALL
    SELECT 5 UNION ALL
    SELECT 6 UNION ALL
    SELECT 7 UNION ALL
    SELECT 8 UNION ALL
    SELECT 9 UNION ALL
    SELECT 10
) a
CROSS JOIN (
    SELECT 0 as m UNION ALL
    SELECT 10 UNION ALL
    SELECT 20 UNION ALL
    SELECT 30 UNION ALL
    SELECT 40 UNION ALL
    SELECT 50 UNION ALL
    SELECT 60 UNION ALL
    SELECT 70 UNION ALL
    SELECT 80 UNION ALL
    SELECT 90 UNION ALL
    Select 100

) b);

insert into match_score(
select
    *,
    FLOOR(1 + (RAND() * 7)) AS runs
from
    testing
where
    number <=120);

select * from match_score;

with answer as (
select
    *,
    ntile(20) over (order by balls) as bucket
from
    match_score
)
select
    bucket as cricket_over,
    sum(runs) as total_rums
from
    answer
group by
    cricket_over;



