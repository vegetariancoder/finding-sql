drop database leetcode;
create database leetcode;
use leetcode;
create table purchase_history
(userid int
,productid int
,purchasedate date
);
insert into purchase_history values
(1,1,'2012-01-23')
,(1,2,'2012-01-23')
,(1,3,'2012-01-25')
,(2,1,'2012-01-23')
,(2,2,'2012-01-23')
,(2,2,'2012-01-25')
,(2,4,'2012-01-25')
,(3,4,'2012-01-23')
,(3,1,'2012-01-23')
,(4,1,'2012-01-23')
,(4,2,'2012-01-25');


select * from purchase_history;


with answer as (
select
    distinct cnt_over_table.userid,
    cnt_over,
    cnt
from
    (
select
    *,
    count(productid) over (partition by userid) as cnt_over
from
    purchase_history
where
    userid
in (
select
    userid
from
    purchase_history
group by
    userid
having
    count(distinct purchasedate)>1))cnt_over_table
inner join
(select
    userid,
    count(distinct productid) as cnt
from
    purchase_history
where
    userid
in (
select
    userid
from
    purchase_history
group by
    userid
having
    count(distinct purchasedate)>1)
group by
    userid) dis_cnt_table
on
    cnt_over_table.userid=dis_cnt_table.userid)
select
    userid
from
    answer
where
    cnt_over=cnt;


with answer as (
select
    userid,
    count(distinct purchasedate) as no_of_dates,
    count(productid) as cnt_product,
    count(distinct productid) as cnt_dis_product
from
    purchase_history
group by
    userid)
select
    userid
from
    answer
where
    no_of_dates>1 and cnt_product=cnt_dis_product;