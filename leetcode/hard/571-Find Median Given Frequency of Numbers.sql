drop database leetcode;
create database leetcode;
use leetcode;

create table Numbers
(
num int
);
INSERT INTO Numbers values(0);
INSERT INTO Numbers values(0);
INSERT INTO Numbers values(0);
INSERT INTO Numbers values(0);
INSERT INTO Numbers values(0);
INSERT INTO Numbers values(0);
INSERT INTO Numbers values(0);
INSERT INTO Numbers values(1);
INSERT INTO Numbers values(2);
INSERT INTO Numbers values(2);
INSERT INTO Numbers values(2);
INSERT INTO Numbers values(3);

select * from Numbers;





with answer as (
select
    *,
    row_number() over (order by num) as rno,
    count(num) over (order by num range between unbounded preceding and unbounded following) as cnt
from
    Numbers)
select
    sum(num)/2 as median_value
from
    answer
where
    rno between cnt*1.0/2 and cnt*1.0/2+1;
