drop database datalemur;
create database datalemur;
use datalemur;


Create table If Not Exists emails (email_id int, user_id int, signup_date date);
insert into emails (email_id, user_id,signup_date) values (125,7771,'2021-06-14');
insert into emails (email_id, user_id,signup_date) values (433,1052,'2021-07-09');


Create table If Not Exists texts (text_id int, email_id int, signup_action varchar(100), action_date date);
insert into texts (text_id,email_id, signup_action,action_date) values (6878,125,'Confirmed','2021-06-14');
insert into texts (text_id,email_id, signup_action,action_date) values (6997,433,'Not Confirmed','2021-07-09');
insert into texts (text_id,email_id, signup_action,action_date) values (7000,433,'Confirmed','2021-07-10');

with answer as (
select
    text_id,
    texts.email_id,
    signup_action,
    action_date,
    user_id,
    row_number() over (partition by user_id order by action_date) as day_number
from
    texts
inner join
    emails e on texts.email_id = e.email_id)
select
    user_id
from
    answer
where
    day_number=2 and signup_action='Confirmed';
