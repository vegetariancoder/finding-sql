drop database datalemur;
create database datalemur;
use datalemur;


Create table If Not Exists users (user_id int, signup_date date, last_login date);
insert into users (user_id, signup_date,last_login) values (1001,'2022-06-01','2022-07-05');
insert into users (user_id, signup_date,last_login) values (1002,'2022-06-03','2022-06-15');
insert into users (user_id, signup_date,last_login) values (1004,'2022-06-02','2022-06-15');
insert into users (user_id, signup_date,last_login) values (1006,'2022-06-15','2022-06-27');
insert into users (user_id, signup_date,last_login) values (1012,'2022-06-16','2022-07-22');


select
    churned_table.signup_week,
    round((churned_days/total_days)*100,2) as churn_rate
from
    (
with answer as (
select
    *,
    FLOOR((DayOfMonth(signup_date)-1)/7)+1 as signup_week,
    FLOOR((DayOfMonth(last_login)-1)/7)+1 as login_week,
    datediff(last_login,signup_date) as diff,
    case
        when datediff(last_login,signup_date) < 28 then 'Yes' else 'No'
    end as churned
from
    users)
select
    signup_week,
    count(*) as churned_days
from
    answer
where
    churned='Yes'
group by
    signup_week) churned_table
inner join
(
with answer as (
select
    *,
    FLOOR((DayOfMonth(signup_date)-1)/7)+1 as signup_week,
    FLOOR((DayOfMonth(last_login)-1)/7)+1 as login_week,
    datediff(last_login,signup_date) as diff,
    case
        when datediff(last_login,signup_date) < 28 then 'Yes' else 'No'
    end as churned
from
    users)
select
    signup_week,
    count(*) as total_days
from
    answer
group by
    signup_week) total_table
on
    churned_table.signup_week=total_table.signup_week;