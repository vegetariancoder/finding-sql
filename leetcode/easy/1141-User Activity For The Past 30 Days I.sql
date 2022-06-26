drop database leetcode;
create database leetcode;
use leetcode;

CREATE TABLE IF NOT EXISTS Activity (
    user_id INT,
    session_id int,
    activity_date date,
    activity_type varchar (100));

insert into Activity (user_id, session_id, activity_date,activity_type) values (1,1,'2019-07-20','open_session');
insert into Activity (user_id, session_id, activity_date,activity_type) values (1,1,'2019-07-20','scroll_down');
insert into Activity (user_id, session_id, activity_date,activity_type) values (1,1,'2019-07-20','end_session');
insert into Activity (user_id, session_id, activity_date,activity_type) values (2,4,'2019-07-20','open_session');
insert into Activity (user_id, session_id, activity_date,activity_type) values (2,4,'2019-07-21','send_message');
insert into Activity (user_id, session_id, activity_date,activity_type) values (2,4,'2019-07-21','end_session');
insert into Activity (user_id, session_id, activity_date,activity_type) values (3,2,'2019-07-21','open_session');
insert into Activity (user_id, session_id, activity_date,activity_type) values (3,2,'2019-07-21','send_message');
insert into Activity (user_id, session_id, activity_date,activity_type) values (3,2,'2019-07-21','end_session');
insert into Activity (user_id, session_id, activity_date,activity_type) values (4,3,'2019-06-25','open_session');
insert into Activity (user_id, session_id, activity_date,activity_type) values (4,3,'2019-06-25','end_session');\


select
    activity_date,
    count( distinct user_id) as active_users
from
    Activity
where
    activity_date between date_sub('2019-07-27',interval 30 day) and '2019-07-27'
group by
    activity_date;

