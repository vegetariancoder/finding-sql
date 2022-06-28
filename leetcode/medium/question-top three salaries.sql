use leetcode;

select * from raw_data;

with main_table as (
select
    *,
    dense_rank() over (partition by department order by salary) as rn,
    count(1) over (partition by department) as cnt
from
    raw_data)
select
    *
from
    main_table
where
    rn=3 or (cnt<3 and rn=cnt);

select
    distinct department
from
    raw_data;






select
    *,
    dense_rank() over (partition by department order by salary) as rankins,
    count(1) over (partition by department) as cnt
from
    raw_data;

select
    department,salary
from(
select
    department,
    salary,
    max(rankings) over (partition by department)as maxrank
from
    (
select
    department,
    salary,
    dense_rank() over (partition by department order by salary desc ) as rankings
from
    raw_data) table1) table2
where
    (maxrank==3) or (maxrank<=2 and maxrank==rankings)


