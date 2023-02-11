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



select * from Genders;

select
    gender,
    user_id
from
    (
select
    gender,
    user_id,
    dense_rank() over (partition by length(gender) order by user_id) as drnk
from
    Genders
order by
    length(gender) desc) table_one
where
    drnk=1
union
select
    gender,
    user_id
from
    (
select
    gender,
    user_id,
    dense_rank() over (partition by length(gender) order by user_id) as drnk
from
    Genders
order by
    length(gender) desc) table_one
where
    drnk=2
union
select
    gender,
    user_id
from
    (
select
    gender,
    user_id,
    dense_rank() over (partition by length(gender) order by user_id) as drnk
from
    Genders
order by
    length(gender) desc) table_one
where
    drnk=3;

