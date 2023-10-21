use strata;

select * from facebook;

with total_friends as (
select
    user1 as user,
    count(user2) as friends
from
    facebook
group by
    user1
union all
select
    user2 as user,
    count(user1) as friends
from
    facebook
group by
    user2),
answer as (
select
    user,
    sum(friends) as total_friends,
    (select count(distinct user1) from facebook )+ (select count(distinct user2) from facebook where user2 not in (select user1 from facebook)) as total_users
from
    total_friends
group by
    user
order by
    user)
select
    user,
    (total_friends/total_users)*100 as popularity_percent
from
    answer;
