drop database leetcode;
create database leetcode;
use leetcode;
create table If Not Exists Genders (user_id int, gender varchar(100));
insert into Genders (user_id,gender) values (4,'male');
insert into Genders (user_id,gender) values (7,'female');
insert into Genders (user_id,gender) values (2,'other');
insert into Genders (user_id,gender) values (5,'male');
insert into Genders (user_id,gender) values (3,'female');
insert into Genders (user_id,gender) values (8,'male');
insert into Genders (user_id,gender) values (6,'other');
insert into Genders (user_id,gender) values (1,'other');
insert into Genders (user_id,gender) values (9,'female');



select
    user_id,
    gender
from
    (
select
    user_id,
    length(gender) as len_value,
    gender,
    dense_rank() over (partition by length(gender) order by user_id) as rankings
from
    Genders
order by
    len_value desc,user_id) table1
where
    rankings=1
union
select
    user_id,
    gender
from
    (
select
    user_id,
    length(gender) as len_value,
    gender,
    dense_rank() over (partition by length(gender) order by user_id) as rankings
from
    Genders
order by
    len_value desc,user_id) table1
where
    rankings=2
union
select
    user_id,
    gender
from
    (
select
    user_id,
    length(gender) as len_value,
    gender,
    dense_rank() over (partition by length(gender) order by user_id) as rankings
from
    Genders
order by
    len_value desc,user_id) table1
where
    rankings=3;