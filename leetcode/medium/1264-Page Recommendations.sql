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


with 1264_leetcode as (
select
    user_id
from
    (
select
    user2_id as user_id
from
    Friendship
where
    user1_id=1
union all
select
    user1_id as user_id
from
    Friendship
where
    user2_id=1) u_table)
select
    distinct page_id as recommended_page
from
    1264_leetcode
left join
    Likes
on
   1264_leetcode.user_id = Likes.user_id
where
    page_id not in (select page_id from Likes where Likes.user_id=1)
order by
recommended_page;


