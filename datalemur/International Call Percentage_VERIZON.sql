drop database datalemur;
create database datalemur;
use datalemur;

Create table If Not Exists phone_info (caller_id int, country_id varchar(100), network varchar(100), phone_number varchar(100));
insert into phone_info (caller_id, country_id, network, phone_number) values (1,'US','Verizon','+1-212-897-1964');
insert into phone_info (caller_id, country_id, network, phone_number) values (2,'US','Verizon','+1-703-346-9529');
insert into phone_info (caller_id, country_id, network, phone_number) values (3,'US','Verizon','+1-650-828-4774');
insert into phone_info (caller_id, country_id, network, phone_number) values (4,'US','Verizon','+1-415-224-6663');
insert into phone_info (caller_id, country_id, network, phone_number) values (5,'IN','Vodafone','+91 7503-907302');
insert into phone_info (caller_id, country_id, network, phone_number) values (6,'IN','Vodafone','+91 2287-664895');


Create table If Not Exists phone_calls (caller_id int, receiver_id int, call_time timestamp);
insert into phone_calls (caller_id, receiver_id, call_time) values (1,2,'2022-07-04 10:13:49');
insert into phone_calls (caller_id, receiver_id, call_time) values (1,5,'2022-08-21 23:54:56');
insert into phone_calls (caller_id, receiver_id, call_time) values (5,1,'2022-05-13 17:24:06');
insert into phone_calls (caller_id, receiver_id, call_time) values (5,6,'2022-03-18 12:11:49');

select * from phone_info;
select * from phone_calls;

select
    phone_calls.caller_id,
    country_id as caller_country
from
    phone_calls
inner join
    phone_info
on
    phone_info.caller_id=phone_calls.caller_id;

select
    phone_calls.receiver_id,
    country_id as receiver_country
from
    phone_calls
inner join
    phone_info
on
    phone_info.caller_id=phone_calls.receiver_id;


with answer as (
select
    caller_id,
    caller_country,
    caller_table.receiver_id,
    receiver_country,
    if(caller_country!=receiver_country,'Yes','No') as international_call
from
    (
select
    phone_calls.caller_id,
    country_id as caller_country,
    phone_calls.receiver_id
from
    phone_calls
inner join
    phone_info
on
    phone_info.caller_id=phone_calls.caller_id) caller_table
inner join
(select
    phone_calls.receiver_id,
    country_id as receiver_country
from
    phone_calls
inner join
    phone_info
on
    phone_info.caller_id=phone_calls.receiver_id) receiver_table
on
    caller_table.receiver_id = receiver_table.receiver_id)
select
    round(count(international_call)/(select count(*) from phone_calls)*100,1) as international_calls_pct
from
    answer
where
    international_call='Yes';







with answer as (
select
    caller_id,
    caller_country,
    caller_table.receiver_id,
    receiver_country,
    case
        when caller_country!=receiver_country then 'Yes' else 'No'
    end as international_call
from
    (
select
    phone_calls.caller_id,
    country_id as caller_country,
    phone_calls.receiver_id
from
    phone_calls
inner join
    phone_info
on
    phone_info.caller_id=phone_calls.caller_id) caller_table
inner join
(select
    phone_calls.receiver_id,
    country_id as receiver_country
from
    phone_calls
inner join
    phone_info
on
    phone_info.caller_id=phone_calls.receiver_id) receiver_table
on
    caller_table.receiver_id = receiver_table.receiver_id)
select
    ROUND(COUNT(caller_id)*100.0/(SELECT COUNT(*) FROM phone_calls),1) as international_calls_pct
from
    answer
where
    international_call='Yes';


with answer as (
select
    pc.caller_id,
    pi_1.country_id as caller_country,
    pc.receiver_id,
    pi_2.country_id as receiver_country
from
    phone_calls pc
left join
    phone_info pi_1
on
    pc.caller_id=pi_1.caller_id
left join
    phone_info pi_2
on
    pc.receiver_id=pi_2.caller_id)
select
    ROUND(COUNT(caller_id)*100.0/(SELECT COUNT(*) FROM phone_calls),1) as international_calls_pct
from
    answer
where
    caller_country!=receiver_country

