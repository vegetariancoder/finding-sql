drop database leetcode;
create database leetcode;
use leetcode;

CREATE TABLE IF NOT EXISTS Signups (
    user_id INT,
    time_stamp DATE);


CREATE TABLE IF NOT EXISTS Confirmations (
    user_id INT,
    time_stamp DATE,
    action varchar(100));

insert into Signups (user_id,time_stamp) values (3,'2020-03-21');
insert into Signups (user_id,time_stamp) values (7,'2020-01-04');
insert into Signups (user_id,time_stamp) values (2,'2020-07-29');
insert into Signups (user_id,time_stamp) values (6,'2020-12-09');


insert into Confirmations (user_id,time_stamp,action) values (3,'2021-01-06','timeout');
insert into Confirmations (user_id,time_stamp,action) values (3,'2021-07-14','timeout');
insert into Confirmations (user_id,time_stamp,action) values (7,'2021-06-12','confirmed');
insert into Confirmations (user_id,time_stamp,action) values (7,'2021-06-13','confirmed');
insert into Confirmations (user_id,time_stamp,action) values (7,'2021-06-14','confirmed');
insert into Confirmations (user_id,time_stamp,action) values (2,'2021-01-22','confirmed');
insert into Confirmations (user_id,time_stamp,action) values (2,'2021-02-28','timeout');


with 1934_leetcode as (
select
    user_id,
    sum(case

        when action='timeout' then 0
        when action='confirmed' then 1
    end)/(count(action)) as confirmation_rate
from
    Confirmations
group by
    user_id)
select
    Signups.user_id,
    round(ifnull(confirmation_rate,0.00),2) as confirmation_rate
from
    Signups
left join
    1934_leetcode
on
    Signups.user_id = 1934_leetcode.user_id;

