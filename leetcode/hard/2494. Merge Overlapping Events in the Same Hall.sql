drop database leetcode;
create database leetcode;
use leetcode;

Create table If Not Exists HallEvents (hall_id int, start_day date, end_day date);

insert into HallEvents (hall_id,start_day,end_day) values(1,'2023-01-13','2023-01-14');
insert into HallEvents (hall_id,start_day,end_day) values(1,'2023-01-14','2023-01-17');
insert into HallEvents (hall_id,start_day,end_day) values(1,'2023-01-18','2023-01-25');
insert into HallEvents (hall_id,start_day,end_day) values(2,'2022-12-09','2022-12-23');
insert into HallEvents (hall_id,start_day,end_day) values(2,'2022-12-13','2022-12-17');
insert into HallEvents (hall_id,start_day,end_day) values(3,'2022-12-01','2023-01-03');


select * from HallEvents;

with answer as (
select
    *,
    if(start_day>=prev_start_date and start_day<=prev_end_date,'Yes','No') as checking
from
    (
select
    *,
    lag(start_day) over (partition by hall_id) as prev_start_date,
    lag(end_day) over (partition by hall_id) as prev_end_date
from
    HallEvents)calc_table)
select
    hall_id,
    prev_start_date,
    prev_end_date
from
    answer
where
    checking='Yes';

