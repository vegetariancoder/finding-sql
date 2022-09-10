drop database datalemur;
create database datalemur;
use datalemur;

Create table If Not Exists server_utilization (server_id int, status_time date, session_status varchar(100));
insert into server_utilization (server_id, status_time, session_status) values (1,'2022-08-02','start');
insert into server_utilization (server_id, status_time, session_status) values (1,'2022-08-04','stop');
insert into server_utilization (server_id, status_time, session_status) values (2,'2022-08-17','start');
insert into server_utilization (server_id, status_time, session_status) values (2,'2022-08-24','stop');

with summary as (
select
    server_id,
    status_time as start_time,
    lead(status_time) over (partition by server_id order by status_time) as stop_time
from
    server_utilization)
select
    datediff(stop_time,start_time) * (select datediff(stop_time,start_time) from summary where server_id=2 and stop_time is not null) as result
from
    summary
where
    server_id=1 and stop_time is not null;
