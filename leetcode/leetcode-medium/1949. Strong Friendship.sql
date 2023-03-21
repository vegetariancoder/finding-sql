use leetcode;
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


select * from Friendship;


with friend as (
select
    user1_id as user,
    user2_id as friend
from
    Friendship
union all
select
    user2_id as user,
    user1_id as friend
from
    Friendship)
select
    f1.user,
    f2.user,
    count(f1.friend) as cnt
from
    friend f1
inner join
    friend f2
on
    f1.friend = f2.friend
where
    f1.user< f2.user
and
    (f1.user,f2.user) in (select user1_id,user2_id from Friendship)
group by
    f1.user, f2.user
having
    count(f2.friend) >=3;
