truncate Tasks;
Create table If Not Exists Tasks (task_id int, assignee_id int,submit_date date);
insert into Tasks (task_id,assignee_id,submit_date) value (1,1,'2022-06-13');
insert into Tasks (task_id,assignee_id,submit_date) value (2,6,'2022-06-14');
insert into Tasks (task_id,assignee_id,submit_date) value (3,6,'2022-06-18');
insert into Tasks (task_id,assignee_id,submit_date) value (4,3,'2022-06-18');
insert into Tasks (task_id,assignee_id,submit_date) value (5,5,'2022-06-19');
insert into Tasks (task_id,assignee_id,submit_date) value (6,7,'2022-06-19');
#
# (with 2298_leetcode as (
# select
#     *,
#     dayname(submit_date) as day_value
# from
#     Tasks)
# select
#     count(task_id) as weekend_cnt
# from
#     2298_leetcode
# where
#     day_value in ('Saturday','Sunday')
# union
# (with 2298_leetcode as (
# select
#     *,
#     dayname(submit_date) as day_value
# from
#     Tasks)
# select
#     count(task_id) as working_cnt
# from
#     2298_leetcode
# where
#     day_value not in ('Saturday','Sunday'));


select
    weekend_cnt,
    weekday_cnt
from
    (
select
    count(task_id) as weekend_cnt
from
    (
select
    *,
    dayname(submit_date) as day_value
from
    Tasks) wknd_table
where
    day_value in ('Saturday','Sunday')) wknd_tbl,
(select
    count(task_id) as weekday_cnt
from
    (
select
    *,
    dayname(submit_date) as day_value
from
    Tasks) wknd_table
where
    day_value not in ('Saturday','Sunday')) wkdy_tbl;
