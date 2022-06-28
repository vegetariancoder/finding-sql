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


with 1951_leetcode as (
select
    user_id
from
    (
select
    *,
    dense_rank() over (order by follower_id) as data
from
    Relations
order by
    follower_id) temp_table
where
    data >3)
select
    min(user_id) as user_id1,
    max(user_id) as user_id2
from
    Relations
where
    user_id not in (select user_id from 1951_leetcode);
