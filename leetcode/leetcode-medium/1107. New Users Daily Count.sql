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


select * from Traffic;



select
    min_date,
    count(*) as user_count
from
    (
select
    min(activity_date) as min_date
from
    Traffic
where
    activity='login'
group by
    user_id) calc_date
where
    min_date>date_sub('2019-06-30', interval 90 day) and min_date < '2019-06-30'
group by
    min_date;



select
    date_sub('2019-06-30', interval 90 day);