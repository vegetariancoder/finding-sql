drop database leetcode;
create database leetcode;
use leetcode;
create table call_details  (
call_type varchar(10),
call_number varchar(12),
call_duration int
);

insert into call_details
values ('OUT','181868',13),('OUT','2159010',8)
,('OUT','2159010',178),('SMS','4153810',1),('OUT','2159010',152),('OUT','9140152',18),('SMS','4162672',1)
,('SMS','9168204',1),('OUT','9168204',576),('INC','2159010',5),('INC','2159010',4),('SMS','2159010',1)
,('SMS','4535614',1),('OUT','181868',20),('INC','181868',54),('INC','218748',20),('INC','2159010',9)
,('INC','197432',66),('SMS','2159010',1),('SMS','4535614',1);

select * from call_details;

select
    outcall.call_number
from
    (
select
    call_number,
    sum(call_duration) as out_call_time
from
    call_details
where
    call_number
in (
select
    call_number
from
    (
select
    distinct call_number
from
    call_details
where
    call_type = 'OUT') out_calls
where
    call_number in (
select
    distinct call_number
from
    call_details
where
    call_type = 'INC'))
and
    call_type ='OUT'
group by
    call_number) outcall
inner join
(select
    call_number,
    sum(call_duration) as in_call_time
from
    call_details
where
    call_number
in (
select
    call_number
from
    (
select
    distinct call_number
from
    call_details
where
    call_type = 'OUT') out_calls
where
    call_number in (
select
    distinct call_number
from
    call_details
where
    call_type = 'INC'))
and
    call_type ='INC'
group by
    call_number) incall
on
    outcall.call_number=incall.call_number
where
   out_call_time>in_call_time;
