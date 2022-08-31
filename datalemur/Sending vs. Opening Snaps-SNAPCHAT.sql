drop database datalemur;
create database datalemur;
use datalemur;


Create table If Not Exists activities (activity_id int, user_id int, activity_type varchar(100), time_spent float);
insert into activities (activity_id, user_id,activity_type,time_spent) values (7274,123,'open',4.50);
insert into activities (activity_id, user_id,activity_type,time_spent) values (2425,123,'send',3.50);
insert into activities (activity_id, user_id,activity_type,time_spent) values (1413,456,'send',5.67);
insert into activities (activity_id, user_id,activity_type,time_spent) values (1414,789,'chat',11.00);
insert into activities (activity_id, user_id,activity_type,time_spent) values (2536,456,'open',3.00);

Create table If Not Exists age_breakdown (user_id int, age_bucket varchar(100));
insert into age_breakdown (user_id, age_bucket) values (123,'31-35');
insert into age_breakdown (user_id, age_bucket) values (456,'26-30');
insert into age_breakdown (user_id, age_bucket) values (789,'21-25');

with answer as (
select
    age_bucket,
    sum(case
        when activity_type = 'send' then time_spent
    end) as send_activity,
    sum(case
        when activity_type = 'open' then time_spent
    end) as open_activity
from
    activities
inner join
    age_breakdown ab on activities.user_id = ab.user_id
group by
    age_bucket)
select
    age_bucket,
    round(send_activity/(send_activity+open_activity) * 100,2) as send_perc,
    round(open_activity/(send_activity+open_activity) * 100,2) as open_perc
from
    answer
where
    send_activity is not null and open_activity is not null
order by
    age_bucket;