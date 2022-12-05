drop database datalemur;
create database datalemur;
use datalemur;

Create table If Not Exists inbox_stats (user_id int, email_count int);
insert into inbox_stats (user_id, email_count) values (123,100);
insert into inbox_stats (user_id, email_count) values (234,200);
insert into inbox_stats (user_id, email_count) values (345,300);
insert into inbox_stats (user_id, email_count) values (456,200);
insert into inbox_stats (user_id, email_count) values (567,200);
insert into inbox_stats (user_id, email_count) values (415,999);
insert into inbox_stats (user_id, email_count) values (5,12);
insert into inbox_stats (user_id, email_count) values (334,343);
insert into inbox_stats (user_id, email_count) values (514,150);
insert into inbox_stats (user_id, email_count) values (105,1396);
insert into inbox_stats (user_id, email_count) values (124,0);
insert into inbox_stats (user_id, email_count) values (55,0);
insert into inbox_stats (user_id, email_count) values (950,150);
insert into inbox_stats (user_id, email_count) values (6,125);


select
    mean,
    median,
    mode
from
    (
select
    row_number() over (order by (select null)) as rno,
    round(sum(email_count)/(select count(1) from inbox_stats),0) as mean
from
    inbox_stats) mean_table
inner join
(with answer as (
select
    *,
    row_number() over (order by email_count) as rno,
    count(email_count) over (order by email_count rows between unbounded preceding and unbounded following) as cnt
from
    inbox_stats)
select
    row_number() over (order by (select null)) as rno,
    round(avg(email_count),0) as median
from
    answer
where
    rno between cnt/2 and cnt/2+1)median_table
on
    mean_table.rno=median_table.rno
inner join
(with answer as (
select
    email_count,
    count(1) as count,
    dense_rank() over (order by count(1) desc ) drnk
from
    inbox_stats
group by
    email_count)
select
    row_number() over (order by (select null)) as rno,
    email_count as mode
from
    answer
where
    drnk=1) mode_table
on
    mean_table.rno=mode_table.rno;



select
    round(avg(email_count),0) as median
from
    (
select
    *,
    row_number() over (order by email_count) as rno,
    count(email_count) over (order by email_count rows between unbounded preceding and unbounded following) as cnt
from
    inbox_stats) calc_table
where
    rno between cnt*1.0/2 and cnt*1.0/2+1;

