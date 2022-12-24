drop database online;
create database online;
use online;

Create Table user_actions (
users_id int,
event_id int,
event_type varchar(50),
event_date datetime );

Insert into user_actions Values(445, 7765 ,'sign-in', '2022-05-31 12:00:00');
Insert into user_actions Values(445, 3634 ,'like', '2022-06-05 12:00:00');
Insert into user_actions Values(648, 3124 ,'like', '2022-06-18 12:00:00');
Insert into user_actions Values(648, 2725 ,'sign-in', '2022-06-22 12:00:00');
Insert into user_actions Values(648, 8568 ,'comment', '2022-07-03 12:00:00');
Insert into user_actions Values(445, 4363 ,'sign-in', '2022-07-05 12:00:00');
Insert into user_actions Values(445, 2425 ,'like', '2022-07-06 12:00:00');
Insert into user_actions Values(445, 2484 ,'like', '2022-07-22 12:00:00');
Insert into user_actions Values(648, 1423 ,'sign-in', '2022-07-26 12:00:00');
Insert into user_actions Values(445, 5235 ,'comment', '2022-07-29 12:00:00');
Insert into user_actions Values(742, 6458 ,'sign-in', '2022-07-03 12:00:00');
Insert into user_actions Values(742, 1374 ,'comment', '2022-07-19 12:00:00');


select * from user_actions;



select
    users_id,
    extract(month from event_date) as mon,
    count(distinct event_type)
from
    user_actions
group by
    users_id, extract(month from event_date);

