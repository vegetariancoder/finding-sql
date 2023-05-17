drop database leetcode;
create database leetcode;
use leetcode;

-- Create table statement
CREATE TABLE call_records (
  caller_id INT,
  recipient_id INT,
  call_time TIMESTAMP
);

-- Insert into statement
INSERT INTO call_records (caller_id, recipient_id, call_time)
VALUES
  (8, 4, '2021-08-24 17:46:07'),
  (4, 8, '2021-08-24 19:57:13'),
  (5, 1, '2021-08-11 05:28:44'),
  (8, 3, '2021-08-17 04:04:15'),
  (11, 3, '2021-08-17 13:07:00'),
  (8, 11, '2021-08-17 22:22:22');

select * from call_records;

with first_last_call as (
select
    *,
    dense_rank() over (partition by date(call_time) order by call_time) as first_drnk,
    dense_rank() over (partition by date(call_time) order by call_time desc ) as last_drnk,
    count(date(call_time)) over (partition by date(call_time)) as cnt
from
    call_records
order by
    date(call_time)
),
first_call as (
select
    caller_id,
    recipient_id,
    call_time,
    row_number() over (order by (select null)) as rn
from
    first_last_call
where
    first_drnk = 1 and cnt > 1),
last_call as (
select
    caller_id,
    recipient_id,
    call_time,
    row_number() over (order by (select null)) as rn
from
    first_last_call
where
    last_drnk = 1 and cnt > 1),
all_users as (
select
    first_call.caller_id as first_call_caller_id,
    first_call.recipient_id as first_call_recipient_id,
    last_call.caller_id as last_call_caller_id,
    last_call.recipient_id as last_call_recipient_id,
    case
        when first_call.caller_id = last_call.recipient_id and last_call.caller_id = first_call.recipient_id then 'Yes'
    else 'No' end as flagging
from
    first_call
inner join
    last_call
on
    first_call.rn=last_call.rn)
select
    distinct first_call_caller_id as user_id
from
    all_users
where
    flagging='Yes'
union
select
    distinct first_call_recipient_id
from
    all_users
where
    flagging='Yes'
union
select
    caller_id
from
    first_last_call
where
    cnt=1
union
select
    recipient_id
from
    first_last_call
where
    cnt=1
order by
    user_id;