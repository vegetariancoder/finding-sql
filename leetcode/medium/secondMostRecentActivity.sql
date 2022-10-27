drop database leetcode;
create database leetcode;
use leetcode;
create table user_activity
(
username varchar(100),
activity varchar(100),
start_date date
);

insert into user_activity values ('Amy','Travel','2020-02-12');
insert into user_activity values ('Amy','Dancing','2020-02-21');
insert into user_activity values ('Amy','Travel','2020-02-24');
insert into user_activity values ('Joe','Travel','2020-02-11');


select * from user_activity;

with answer as (
select
    *,
    dense_rank() over (partition by username order by start_date) as drnk,
    count(username) over (partition by username) as cnt
from
    user_activity)
select
    username,
    activity,
    start_date
from
    answer
where
    drnk=2 or (drnk < 2 and drnk=cnt);