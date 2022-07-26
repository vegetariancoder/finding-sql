
drop database leetcode
create database leetcode
use leetcode;
Create table If Not Exists Activity (machine_id int, process_id int, activity_type varchar(100), timestamp_value float);

insert into Activity (machine_id, process_id, activity_type, timestamp_value) values (0,0,'start',0.712);
insert into Activity (machine_id, process_id, activity_type, timestamp_value) values (0,0,'end',1.520);
insert into Activity (machine_id, process_id, activity_type, timestamp_value) values (0,1,'start',3.140);
insert into Activity (machine_id, process_id, activity_type, timestamp_value) values (0,1,'end',4.120);
insert into Activity (machine_id, process_id, activity_type, timestamp_value) values (1,0,'start',0.550);
insert into Activity (machine_id, process_id, activity_type, timestamp_value) values (1,0,'end',1.550);
insert into Activity (machine_id, process_id, activity_type, timestamp_value) values (1,1,'start',0.430);
insert into Activity (machine_id, process_id, activity_type, timestamp_value) values (1,1,'end',1.420);
insert into Activity (machine_id, process_id, activity_type, timestamp_value) values (2,0,'start',4.100);
insert into Activity (machine_id, process_id, activity_type, timestamp_value) values (2,0,'end',4.512);
insert into Activity (machine_id, process_id, activity_type, timestamp_value) values (2,1,'start',2.500);
insert into Activity (machine_id, process_id, activity_type, timestamp_value) values (2,1,'end',5.000);


with 1661_leetcode as (
select
    machine_id,
    activity_type,
    sum(timestamp_value) as sum_value
from
    Activity
group by
    1,2)
select
    machine_id,
    round((sum(case
        when activity_type='end' then sum_value
    end)-sum(case
        when activity_type='start' then sum_value
    end))/2,3) as processing_time
from
    1661_leetcode
group by
    machine_id;
