use leetcode;

drop table leetcode.Friendship;
create table Friendship (user1_id int, user2_id int);
insert into Friendship values (1,2),
                                   (1,3),
                                   (2,3),
                                   (1,4),
                                   (2,4),
                                   (1,5),
                                   (1,4),
                                   (2,5),
                                   (1,7),
                                   (3,7),
                                   (1,6),
                                   (3,6),
                                   (2,6);


with friends as (
select
    user1_id as user_id,
    user2_id as friend
from
    Friendship
union
select
    user2_id as user_id,
    user1_id as friend
from
    Friendship)
select
    f1.user_id,
    f2.user_id,
    count(f1.friend) as count
from
    friends f1
inner join
    friends f2
on
    f1.friend = f2.friend
where
    f1.user_id<f2.user_id
and
    (f1.user_id,f2.user_id) in (select user1_id,user2_id from Friendship)
group by
    f1.user_id, f2.user_id
having
    count(f2.friend)>=3;
