use leetcode;
Create table If Not Exists Traffic (user_id int, activity varchar(100), activity_date date);
insert into Traffic (user_id,activity,activity_date) value (1,'login','2019-05-01');
insert into Traffic (user_id,activity,activity_date) value (1,'homepage','2019-05-01');
insert into Traffic (user_id,activity,activity_date) value (1,'logout','2019-05-01');
insert into Traffic (user_id,activity,activity_date) value (2,'login','2019-06-21');
insert into Traffic (user_id,activity,activity_date) value (2,'logout','2019-06-21');
insert into Traffic (user_id,activity,activity_date) value (3,'login','2019-01-01');
insert into Traffic (user_id,activity,activity_date) value (3,'jobs','2019-01-01');
insert into Traffic (user_id,activity,activity_date) value (3,'logout','2019-01-01');
insert into Traffic (user_id,activity,activity_date) value (4,'login','2019-06-21');
insert into Traffic (user_id,activity,activity_date) value (4,'groups','2019-06-21');
insert into Traffic (user_id,activity,activity_date) value (4,'logout','2019-06-21');
insert into Traffic (user_id,activity,activity_date) value (5,'login','2019-03-01');
insert into Traffic (user_id,activity,activity_date) value (5,'logout','2019-03-01');
insert into Traffic (user_id,activity,activity_date) value (5,'login','2019-06-21');
insert into Traffic (user_id,activity,activity_date) value (5,'logout','2019-06-21');




with 1107_leetcode as (
select
    user_id,
    activity,
    activity_date,
    '2019-06-30' as last_date,
    date_sub('2019-06-30',interval 90 day ) as start_date,
    if(activity_date between date_sub('2019-06-30',interval 90 day ) and '2019-06-30','Yes','No') as bool_values

from
    (
select
    user_id,
    activity,
    min(activity_date) as activity_date
from
    Traffic
where
    activity='login'
group by
    user_id, activity) min_dt_table)
select
    activity_date as login_date,
    count(user_id) as user_count
from
    1107_leetcode
where
    bool_values = 'Yes'
group by
    login_date;



SELECT DATEDIFF("2019-06-23", "2012-05-12");








