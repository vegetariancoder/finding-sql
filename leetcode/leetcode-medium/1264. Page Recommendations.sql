drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Friendship (user1_id int,user2_id int);
insert into Friendship (user1_id,user2_id) value (1,2);
insert into Friendship (user1_id,user2_id) value (1,3);
insert into Friendship (user1_id,user2_id) value (1,4);
insert into Friendship (user1_id,user2_id) value (2,3);
insert into Friendship (user1_id,user2_id) value (2,4);
insert into Friendship (user1_id,user2_id) value (2,5);
insert into Friendship (user1_id,user2_id) value (6,1);


Create table If Not Exists Likes (user_id int,page_id int);
insert into Likes (user_id,page_id) value (1,88);
insert into Likes (user_id,page_id) value (2,23);
insert into Likes (user_id,page_id) value (3,24);
insert into Likes (user_id,page_id) value (4,56);
insert into Likes (user_id,page_id) value (5,11);
insert into Likes (user_id,page_id) value (6,33);
insert into Likes (user_id,page_id) value (2,77);
insert into Likes (user_id,page_id) value (3,77);
insert into Likes (user_id,page_id) value (6,88);


select * from Friendship;


with answer as (
select
    user1_id,
    user2_id,
    page_id
from
    Friendship
inner join
    Likes
on
    Friendship.user2_id = Likes.user_id
where
    user1_id=1
and
    page_id != (select page_id from Likes where user_id=1)
union
select
    user1_id,
    user2_id,
    page_id
from
    Friendship
inner join
    Likes
on
    Friendship.user1_id = Likes.user_id
where
    user2_id=1
and
    page_id != (select page_id from Likes where user_id=1))
select
    distinct page_id
from
    answer;