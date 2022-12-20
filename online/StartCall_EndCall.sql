drop database online;
create database online;
use online;

create table call_start_logs
(
phone_number varchar(10),
start_time datetime
);
insert into call_start_logs values
('PN1','2022-01-01 10:20:00'),('PN1','2022-01-01 16:25:00'),('PN2','2022-01-01 12:30:00')
,('PN3','2022-01-02 10:00:00'),('PN3','2022-01-02 12:30:00'),('PN3','2022-01-03 09:20:00')
create table call_end_logs
(
phone_number varchar(10),
end_time datetime
);
insert into call_end_logs values
('PN1','2022-01-01 10:45:00'),('PN1','2022-01-01 17:05:00'),('PN2','2022-01-01 12:55:00')
,('PN3','2022-01-02 10:20:00'),('PN3','2022-01-02 12:50:00'),('PN3','2022-01-03 09:40:00')
;


select * from call_start_logs;
select * from call_end_logs;


select
    start_table.phone_number,
    start_time,
    end_time,
    timestampdiff(minute,start_time,end_time) as duration
from
    (
select
    *,
    rank() over (partition by phone_number order by start_time) as rnk_start
from
    call_start_logs) start_table
inner join
(select
    *,
    rank() over (partition by phone_number order by end_time) as rnk_end
from
    call_end_logs) end_table
on
    start_table.phone_number=end_table.phone_number and start_table.rnk_start=end_table.rnk_end;