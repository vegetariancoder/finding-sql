drop database leetcode;
create database leetcode;
use leetcode;

Create table If Not Exists UserActivity (username varchar(100), activity varchar(100) , startDate date, endDate date);

insert into UserActivity (username,activity,startDate,endDate) values('Alice','Travel','2020-02-12','2020-02-20');
insert into UserActivity (username,activity,startDate,endDate) values('Alice','Dancing','2020-02-21','2020-02-23');
insert into UserActivity (username,activity,startDate,endDate) values('Alice','Travel','2020-02-24','2020-02-28');
insert into UserActivity (username,activity,startDate,endDate) values('Bob','Travel','2020-02-11','2020-02-18');


with 1369_leetcode as (
select
    *,
    dense_rank() over (partition by username order by startDate) as drnk,
    count(1) over (partition by username) as counting
from
    UserActivity)
select
    username,
    activity,
    startDate,
    endDate
from
    1369_leetcode
where
    drnk=2 or(counting<3 and drnk=counting);
