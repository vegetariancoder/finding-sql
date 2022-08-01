drop database leetcode;
create database leetcode;
use leetcode;

Create table If Not Exists Listens (user_id int, song_id int , day date);

insert into Listens (user_id,song_id,day) values(1,10,'2021-03-15');
insert into Listens (user_id,song_id,day) values(1,11,'2021-03-15');
insert into Listens (user_id,song_id,day) values(1,12,'2021-03-15');
insert into Listens (user_id,song_id,day) values(2,10,'2021-03-15');
insert into Listens (user_id,song_id,day) values(2,11,'2021-03-15');
insert into Listens (user_id,song_id,day) values(2,12,'2021-03-15');
insert into Listens (user_id,song_id,day) values(3,10,'2021-03-15');
insert into Listens (user_id,song_id,day) values(3,11,'2021-03-15');
insert into Listens (user_id,song_id,day) values(3,12,'2021-03-15');
insert into Listens (user_id,song_id,day) values(4,10,'2021-03-15');
insert into Listens (user_id,song_id,day) values(4,11,'2021-03-15');
insert into Listens (user_id,song_id,day) values(4,13,'2021-03-15');
insert into Listens (user_id,song_id,day) values(5,10,'2021-03-16');
insert into Listens (user_id,song_id,day) values(5,11,'2021-03-16');
insert into Listens (user_id,song_id,day) values(5,12,'2021-03-16');


Create table If Not Exists Friendship (user1_id int, user2_id int);

insert into Friendship (user1_id,user2_id) values(1,2);
insert into Friendship (user1_id,user2_id) values(2,4);
insert into Friendship (user1_id,user2_id) values(2,5);

select
    user_id
from
    (

select
    user_id,
    max(day) as max_day
from
    (
select
    *
from
    Listens
where
    user_id in (
select
    user_id
from
    (
select
    user_id,
    lead(song_id) over (partition by user_id order by day) - song_id as diff
from
    Listens) as diff_table
group by
    user_id
having
    max(diff) < 2)) defined_table
where
    user_id in (
select
    user1_id
from
    Friendship
union
select
    user2_id
from
    Friendship)
group by
    user_id) final_table
where
    max_day = (select
    max_day
from
    (
select
    user_id,
    max(day) as max_day
from
    (
select
    *
from
    Listens
where
    user_id in (
select
    user_id
from
    (
select
    user_id,
    lead(song_id) over (partition by user_id order by day) - song_id as diff
from
    Listens) as diff_table
group by
    user_id
having
    max(diff) < 2)) defined_table
where
    user_id in (
select
    user1_id
from
    Friendship
union
select
    user2_id
from
    Friendship)
group by
    user_id) g_table
group by
    max_day
having
    count(*) >=2);


select distinct user1_id, user2_id
    from (
        select user1_id, user2_id, day, count(song_id)
        from (
            select a.user_id as user1_id, b.user_id as user2_id, a.song_id, a.day
            from (
                select distinct * from Listens
            ) as a
            inner join (
                select distinct * from Listens
            ) as b
            on a.song_id = b.song_id and a.day = b.day and a.user_id != b.user_id
        ) as c
        group by user1_id, user2_id, day
        having count(song_id) >= 3
    ) as d
    inner join (
        select user1_id as u1, user2_id as u2
        from Friendship
        union all
        select user2_id as u1, user1_id as u2
        from Friendship
    ) as e
    on d.user1_id = e.u1 and d.user2_id = e.u2 and d.user1_id < d.user2_id;



