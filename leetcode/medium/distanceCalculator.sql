drop database leetcode;
create database leetcode;
use leetcode;
create table src_dest_dist
(
    src         varchar(20),
    dest        varchar(20),
    distance    float
);
insert into src_dest_dist values ('A', 'B', 21);
insert into src_dest_dist values ('B', 'A', 28);
insert into src_dest_dist values ('A', 'B', 19);
insert into src_dest_dist values ('C', 'D', 15);
insert into src_dest_dist values ('C', 'D', 17);
insert into src_dest_dist values ('D', 'C', 16.5);
insert into src_dest_dist values ('D', 'C', 18);

select * from src_dest_dist;

with answer as (
select
    src,
    dest,
    sum_dist,
    cnt,
    lead(dest) over (order by (select null)) as next_src,
    lead(src) over (order by (select null)) as next_dest,
    lead(sum_dist) over (order by (select null)) as next_dist,
    lead(cnt) over (order by (select null)) as next_cnt
from
    (
select
    src,
    dest,
    sum(distance) as sum_dist,
    count(*) as cnt
from
    src_dest_dist
group by
    src, dest) calc_table)
select
    src,
    dest,
    round((sum_dist + next_dist)/(cnt+next_cnt),2) as distance
from
    answer
where
    src=next_src and dest=next_dest;
