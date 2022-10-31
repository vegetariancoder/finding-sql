drop database online;
create database online;
use online;

create table tasks (
date_value date,
state varchar(10)
);

insert into tasks  values ('2019-01-01','success'),('2019-01-02','success'),('2019-01-03','success'),('2019-01-04','fail')
,('2019-01-05','fail'),('2019-01-06','success');

select *
from tasks;

with answer as (
select
    date_value,
    state,
    row_number() over (partition by state order by date_value) as rno,
    date_sub(date_value,interval row_number() over (partition by state order by date_value) day ) dt
from
    tasks
order by
    date_value)
select
    min(date_value) as start_date,
    max(date_value) as end_date,
    state
from
    answer
group by
    dt,state;


