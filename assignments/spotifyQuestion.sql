use leetcode;

CREATE table activity
(
user_id varchar(20),
event_name varchar(20),
event_date date,
country varchar(20)
);
insert into activity values (1,'app-installed','2022-01-01','India')
,(1,'app-purchase','2022-01-02','India')
,(2,'app-installed','2022-01-01','USA')
,(3,'app-installed','2022-01-01','USA')
,(3,'app-purchase','2022-01-03','USA')
,(4,'app-installed','2022-01-03','India')
,(4,'app-purchase','2022-01-03','India')
,(5,'app-installed','2022-01-03','SL')
,(5,'app-purchase','2022-01-03','SL')
,(6,'app-installed','2022-01-04','Pakistan')
,(6,'app-purchase','2022-01-04','Pakistan');

select * from activity;

# first part
select
    event_date,
    count(distinct user_id) as count
from
    activity
group by
    event_date;

# second part
select
    week(event_date)+1 as week,
    count(distinct user_id) as weekly_count
from
    activity
group by
    1;

# third part
select
    user_id,
    event_date
from
    activity
where
    event_name='app-installed';

select
    user_id,
    event_date
from
    activity
where
    event_name='app-purchase';


with answer as (
select
    a1.event_date as event_date,
    count(distinct a1.user_id) as count
from
    activity a1
inner join
    activity a2
on
    a1.event_date=a2.event_date and a1.user_id=a2.user_id and a1.event_name!=a2.event_name
group by
    a1.event_date)
select
    distinct activity.event_date,
    ifnull(count,0) as count
from
    activity
left join
    answer
on
    activity.event_date=answer.event_date;


# fourth part

with main_answer as (
with answer as (
select
    country,
    count(user_id) as  counting
from
    activity
where
    event_name='app-purchase'
group by
    country)
select
    'others' as country,
    sum(case
        when country in ('SL','Pakistan') then counting
    end) as counting
from
    answer
where country not in ('India','USA')
union
select
    country,
    counting
from
    answer
where
    country not in ('SL','Pakistan'))
select
    country,
    round(counting/(select sum(counting) from main_answer) * 100,0) as percent
from
    main_answer;


# fifth part

with answer as (
select
    next_date,
    count(user_id) as count
from
    (
select
    *,
    lead(event_date) over (partition by user_id order by event_date) as next_date,
    lead(event_name) over (partition by user_id order by event_date) as next_event
from
    activity)calc_table
where
    datediff(next_date,event_date)=1
and
    next_event='app-purchase'
and
    event_name='app-installed'
group by
    next_date)
select
    distinct event_date,
    ifnull(count,0) as count
from
    activity
left join
    answer
on
    activity.event_date=answer.next_date;

