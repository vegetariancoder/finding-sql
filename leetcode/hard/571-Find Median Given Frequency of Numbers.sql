drop database leetcode;
create database leetcode;
use leetcode;

create table Numbers
(
num int,
frequency int
);
INSERT INTO Numbers values(0,7);
INSERT INTO Numbers values(1,1);
INSERT INTO Numbers values(2,3);
INSERT INTO Numbers values(3,1);

select * from Numbers;





# with answer as (
# select
#     *,
#     row_number() over (order by num) as rno,
#     count(num) over (order by num range between unbounded preceding and unbounded following) as cnt
# from
#     Numbers)
# select
#     sum(num)/2 as median_value
# from
#     answer
# where
#     rno between cnt*1.0/2 and cnt*1.0/2+1;

with answer as (
with recursive exploded_values as (
    select
        num,
        frequency,
        1 as cnt
    from
        Numbers
    union
    select
        num,
        frequency,
        cnt+1 as cnt
    from
        exploded_values
    where
        cnt<frequency
)
select
    num,
    row_number() over (order by num) as r_no,
    count(num) over (order by num rows between unbounded preceding and unbounded following) as count_values
from
    exploded_values)
select
    round(sum(num)/2,2) as median
from
    answer
where
    r_no between count_values*1.0/2 and count_values*1.0/2+1;
