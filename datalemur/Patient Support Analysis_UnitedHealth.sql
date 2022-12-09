drop database datalemur;
create database datalemur;
use datalemur;

Create table If Not Exists callers (policy_holder_id int, case_id varchar(100), call_category varchar(100), call_received timestamp,call_duration_secs int, original_order int);

insert into callers(policy_holder_id,case_id,call_category,call_received,call_duration_secs,original_order) values (50837000,'dc63-acae-4f39-bb04','claims','2022-03-09 2:51',205,130);
insert into callers(policy_holder_id,case_id,call_category,call_received,call_duration_secs,original_order) values (50837000,'41be-bebe-4bd0-a1ba','IT_support','2022-03-12 5:37',254,129);
insert into callers(policy_holder_id,case_id,call_category,call_received,call_duration_secs,original_order) values (50837000,'bab1-3ec5-4867-90ae','benefits','2022-05-13 18:19',228,339);
insert into callers(policy_holder_id,case_id,call_category,call_received,call_duration_secs,original_order) values (50936674,'12c8-b35c-48a3-b38d','claims','2022-05-31 7:27',240,31);
insert into callers(policy_holder_id,case_id,call_category,call_received,call_duration_secs,original_order) values (50886837,'d0b4-8ea7-4b8c-aa8b','IT_support','2022-03-11 3:38',276,16);
insert into callers(policy_holder_id,case_id,call_category,call_received,call_duration_secs,original_order) values (50886837,'a741-c279-41c0-90ba','','2022-03-19 10:52',131,325);


select * from callers;

with answer as (
select
    *,
    timestampdiff(day ,call_received,next_call) as diff
from
    (
select
    *,
    lead(call_received) over (partition by policy_holder_id order by call_received) as next_call
from
    callers) calc_table)
select
    count(distinct policy_holder_id) as patient_count
from
    answer
where
    diff <=7;


