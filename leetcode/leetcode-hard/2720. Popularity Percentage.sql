use leetcode;
CREATE TABLE Friends (
  user1 INT,
  user2 INT
);

-- Insert data
INSERT INTO Friends (user1, user2) VALUES
(2, 1),
(1, 3),
(4, 1),
(1, 5),
(1, 6),
(2, 6),
(7, 2),
(8, 3),
(3, 9);

select * from Friends;

with answer as (
select
    user1,
    count(user2)/(select count(*) from (select user1 from Friends union select user2 from Friends) as distinct_vals)*100 as percentage_popularity
from
    Friends
group by
    user1
union all
select
    user2,
    count(user1)/(select count(*) from (select user1 from Friends union select user2 from Friends) as distinct_vals)*100 as percentage_popularity
from
    Friends
group by
    user2)
select
    user1,
    round(sum(percentage_popularity),2) as percentage_popularity
from
    answer
group by
    user1
order by
    user1;

