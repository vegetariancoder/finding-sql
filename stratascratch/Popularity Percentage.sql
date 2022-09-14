drop database strata;
create database strata;
use strata;
Create table If Not Exists facebook_friends (user1 int, user2 int);
insert into facebook_friends (user1,user2) value (2,1);
insert into facebook_friends (user1,user2) value (1,3);
insert into facebook_friends (user1,user2) value (4,1);
insert into facebook_friends (user1,user2) value (1,5);
insert into facebook_friends (user1,user2) value (1,6);
insert into facebook_friends (user1,user2) value (2,6);
insert into facebook_friends (user1,user2) value (7,2);
insert into facebook_friends (user1,user2) value (8,3);
insert into facebook_friends (user1,user2) value (3,9);

with answer as (
select
    user,
    sum(friends_1) as summing
from
    (
select
    user1 as user,
    count(distinct user2) as friends_1
from
    facebook_friends
group by
    user1
union
select
    user2,
    count(distinct user1) as friends_1
from
    facebook_friends
group by
    user2)calc_table
group by
    user
order by
    user)
select
    user as user1,
    round(summing/(select count(distinct user) from answer) *100,3) as popularity_percent
from
    answer;