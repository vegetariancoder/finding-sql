drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Actions (user_id int,post_id int, action_date varchar(100), action varchar(100), extra varchar(100));
insert into Actions value (1,1,'2019-07-01','view',null);
insert into Actions value (1,1,'2019-07-01','like',null);
insert into Actions value (1,1,'2019-07-01','share',null);
insert into Actions value (2,2,'2019-07-04','view',null);
insert into Actions value (2,2,'2019-07-04','report','spam');
insert into Actions value (3,4,'2019-07-04','view',null);
insert into Actions value (3,4,'2019-07-04','report','spam');
insert into Actions value (4,3,'2019-07-02','view',null);
insert into Actions value (4,3,'2019-07-02','report','spam');
insert into Actions value (5,2,'2019-07-03','view',null);
insert into Actions value (5,2,'2019-07-03','report','racism');
insert into Actions value (5,5,'2019-07-03','view',null);
insert into Actions value (5,5,'2019-07-03','report','racism');

select * from Actions;

with answer as (
select
    action_date,
    sum(checking) as total
from
    (
select
    *,
    sum(case when extra='spam' then 1 else 0 end) over (partition by user_id) as spam_cnt,
    count(user_id) over (partition by user_id) as cnt,
    sum(case when extra='spam' then 1 else 0 end) over (partition by user_id)/count(user_id) over (partition by user_id) as checking
from
    Actions) calc
where
    extra='spam'
group by
    action_date)
select
    round(sum(total)/count(distinct action_date)*100,2) as average_daily_percent
from
    answer;
