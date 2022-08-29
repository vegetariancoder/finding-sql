drop database datalemur;
create database datalemur;
use datalemur;


Create table If Not Exists emails (email_id int, user_id int, signup_date date);
insert into emails (email_id, user_id,signup_date) values (125,7771,'2021-06-14');
insert into emails (email_id, user_id,signup_date) values (236,7771,'2021-07-01');
insert into emails (email_id, user_id,signup_date) values (433,7771,'2021-07-09');


Create table If Not Exists texts (text_id int, email_id int, signup_action varchar(100));
insert into texts (text_id, email_id,signup_action) values (6878,125,'Confirmed');
insert into texts (text_id, email_id,signup_action) values (6920,236,'Not Confirmed');
insert into texts (text_id, email_id,signup_action) values (6994,236,'Confirmed');


select
    round(count(emails.email_id)/(select count(*) from emails),2) as confirm_rate
from
    emails
left join
    texts on emails.email_id = texts.email_id
where
    texts.signup_action != 'Not Confirmed';
