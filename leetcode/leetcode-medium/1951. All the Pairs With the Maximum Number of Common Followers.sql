drop database leetcode;
create database leetcode;
use leetcode;

CREATE TABLE IF NOT EXISTS Relations (
    user_id int,
    follower_id int);


insert into Relations (user_id,follower_id) values (1,3);
insert into Relations (user_id,follower_id) values (2,3);
insert into Relations (user_id,follower_id) values (7,3);
insert into Relations (user_id,follower_id) values (1,4);
insert into Relations (user_id,follower_id) values (2,4);
insert into Relations (user_id,follower_id) values (7,4);
insert into Relations (user_id,follower_id) values (1,5);
insert into Relations (user_id,follower_id) values (2,6);
insert into Relations (user_id,follower_id) values (7,5);
select * from Relations;


with answer as (
select
     user1_id,
     user2_id,
     cnt,
     dense_rank() over (order by cnt desc ) as drnk
from
    (
select
    user1_id,
    user2_id,
    count(*) as cnt
from
    (
select
    user_id as user1_id,
    follower_id
from
    Relations
where
    user_id=1)table_1
inner join
(select
    user_id as user2_id,
    follower_id
from
    Relations
where
    user_id=2) table_2
on
    table_1.follower_id = table_2.follower_id
union all
select
    user1_id,
    user2_id,
    count(*) as cnt
from
    (
select
    user_id as user1_id,
    follower_id
from
    Relations
where
    user_id=1)table_1
inner join
(select
    user_id as user2_id,
    follower_id
from
    Relations
where
    user_id=7) table_7
on
    table_1.follower_id = table_7.follower_id
union all
select
    user1_id,
    user2_id,
    count(*) as cnt
from
    (
select
    user_id as user1_id,
    follower_id
from
    Relations
where
    user_id=2)table_2
inner join
(select
    user_id as user2_id,
    follower_id
from
    Relations
where
    user_id=7) table_7
on
    table_2.follower_id = table_7.follower_id)calc_table)
select
    user1_id,
    user2_id
from
    answer
where
    drnk=1;