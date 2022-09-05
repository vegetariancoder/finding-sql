drop database datalemur;
create database datalemur;
use datalemur;


Create table If Not Exists user_actionsExample (user_id int, event_id int, event_type varchar(100), event_date date);
insert into user_actionsExample (user_id, event_id,event_type,event_date) values (445,7765,'sign-in','2022-05-31');
insert into user_actionsExample (user_id, event_id,event_type,event_date) values (742,6458,'sign-in','2022-06-03');
insert into user_actionsExample (user_id, event_id,event_type,event_date) values (445,3634,'like','2022-06-05');
insert into user_actionsExample (user_id, event_id,event_type,event_date) values (742,1374,'comment','2022-06-05');
insert into user_actionsExample (user_id, event_id,event_type,event_date) values (648,3124,'like','2022-06-18')

select * from user_actionsExample;

with answer as
(select
    distinct tab1.user_id
from
    user_actionsExample tab1
join
    user_actionsExample tab2
where
    tab1.user_id=tab2.user_id and month(tab1.event_date) != month(tab2.event_date) and tab1.event_type in ('sign-in','like','comment'))
select
    month(event_date) as month,
    count(*) as monthly_active_users
from
    user_actionsExample
where
    month(event_date)=6 and user_id in (select user_id from answer)
group by
    month;
