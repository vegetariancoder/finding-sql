use leetcode;
drop table Activity;
create table If Not Exists Activity (user_id int, session_id varchar(100), activity_date varchar(100),activity_type varchar (100));
insert into Activity (user_id,session_id,activity_date,activity_type) values (1,1,'2019-07-20','open_session'),
  (1,1,'2019-07-20','scroll_down'),
  (1,1,'2019-07-20','end_session'),
  (2,4,'2019-07-20','open_session'),
  (2,4,'2019-07-21','send_message'),
  (2,4,'2019-07-21','end_session'),
  (2,4,'2019-07-21','end_session'),
  (3,2,'2019-07-21','open_session'),
  (3,2,'2019-07-21','send_message'),
  (3,2,'2019-07-21','end_session'),
  (3,5,'2019-07-21','open_session'),
  (3,5,'2019-07-21','scroll_down'),
  (3,5,'2019-07-21','end_session'),
  (4,3,'2019-06-25','open_session'),
  (4,3,'2019-06-25','end_session');

select * from Activity;

with leetcode1142 as (select *
                      from Activity
                      where activity_type not in ('open_session', 'end_session'))
select
        round(count(user_id)/count(distinct user_id),2) as average_sessions_per_user

from
    leetcode1142;


