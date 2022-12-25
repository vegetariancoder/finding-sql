drop database online;
create database online;
use online;

Create table facebook_web_log
(
Userid int,
Time_stamp datetime,
Actions varchar(30)
);


INSERT INTO facebook_web_log values(0,'2019-04-25 13:30:15','page_load');
INSERT INTO facebook_web_log values(0,'2019-04-25 13:30:18','page_load');
INSERT INTO facebook_web_log values(0,'2019-04-25 13:30:40','scroll_down');
INSERT INTO facebook_web_log values(0,'2019-04-25 13:30:45','scroll_up');
INSERT INTO facebook_web_log values(0,'2019-04-25 13:31:10','scroll_down');
INSERT INTO facebook_web_log values(0,'2019-04-25 13:31:25','scroll_down');
INSERT INTO facebook_web_log values(0,'2019-04-25 13:31:40','page_exit');
INSERT INTO facebook_web_log values(1,'2019-04-25 13:40:00','page_load');
INSERT INTO facebook_web_log values(1,'2019-04-25 13:40:10','scroll_down');
INSERT INTO facebook_web_log values(1,'2019-04-25 13:40:15','scroll_down');
INSERT INTO facebook_web_log values(1,'2019-04-25 13:40:20','scroll_down');
INSERT INTO facebook_web_log values(1,'2019-04-25 13:40:25','scroll_down');
INSERT INTO facebook_web_log values(1,'2019-04-25 13:40:30','scroll_down');
INSERT INTO facebook_web_log values(1,'2019-04-25 13:40:35','page_exit');
INSERT INTO facebook_web_log values(2,'2019-04-25 13:41:21','page_load');
INSERT INTO facebook_web_log values(2,'2019-04-25 13:41:30','scroll_down');
INSERT INTO facebook_web_log values(2,'2019-04-25 13:41:35','scroll_down');
INSERT INTO facebook_web_log values(2,'2019-04-25 13:41:40','scroll_up');
INSERT INTO facebook_web_log values(1,'2019-04-26 11:15:00','page_load');
INSERT INTO facebook_web_log values(1,'2019-04-26 11:15:10','scroll_down');
INSERT INTO facebook_web_log values(1,'2019-04-26 11:15:20','scroll_down');
INSERT INTO facebook_web_log values(1,'2019-04-26 11:15:25','scroll_up');
INSERT INTO facebook_web_log values(1,'2019-04-26 11:15:35','page_exit');
INSERT INTO facebook_web_log values(0,'2019-04-28 14:30:15','page_load');
INSERT INTO facebook_web_log values(0,'2019-04-28 14:30:10','page_load');
INSERT INTO facebook_web_log values(0,'2019-04-28 13:30:40','scroll_down');
INSERT INTO facebook_web_log values(0,'2019-04-28 15:31:40','page_exit');


select * from facebook_web_log;

with answer as (
select
    page_load_tb.Userid,
    page_load_tb.date,
    max_date,
    min_date,
    timestampdiff(second ,max_date,min_date) as diff
from
    (
select
    Userid,
    date(Time_stamp) as date,
    max(Time_stamp) as max_date
from
    facebook_web_log
where
    Actions='page_load'
group by
    Userid, date(Time_stamp)) page_load_tb
inner join
(select
    Userid,
    date(Time_stamp) as date,
    min(Time_stamp) as min_date
from
    facebook_web_log
where
    Actions='page_exit'
group by
    Userid, date(Time_stamp)) page_exit_tb
on
    page_load_tb.Userid=page_exit_tb.Userid
and
    page_load_tb.date = page_exit_tb.date)
select
    Userid,
    round(sum(diff)/count(Userid),0) as avg_session
from
    answer
group by
    Userid;