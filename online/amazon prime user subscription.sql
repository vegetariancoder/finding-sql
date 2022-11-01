drop database online;
create database online;
use online;

create table users
(
user_id integer,
name varchar(20),
join_date date
);
insert into users
values (1, 'Jon', '2020-02-14'),
(2, 'Jane', '2020-02-14'),
(3, 'Jill', '2020-02-15'),
(4, 'Josh', '2020-02-15'),
(5, 'Jean', '2020-02-16'),
(6, 'Justin', '2020-02-17'),
(7, 'Jeremy', '2020-02-18');

create table events
(
user_id integer,
type varchar(10),
access_date date
);

insert into events values
(1, 'Pay', '2020-03-01'),
(2, 'Music', '2020-03-02'),
(2, 'P', '2020-03-12'),
(3, 'Music', '2020-03-15'),
(4, 'Music', '2020-03-15'),
(1, 'P', '2020-03-16'),
(3, 'P', '2020-03-22');


select * from events;

select * from users;


with answer as (
select
    users.user_id,
    join_date,
    type,
    access_date
from
    users
left join
    events on users.user_id = events.user_id
and
    type='P'
where
    users.user_id in (select user_id from events where type='Music'))
select
    round(count(*)/(select count(*) from answer)*100,2) as agg_result
from
    answer
where
    datediff(access_date,join_date)<30;



