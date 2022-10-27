drop database leetcode;
create database leetcode;
use leetcode;
create table company_users
(
company_id int,
user_id int,
language varchar(20)
);

insert into company_users values (1,1,'English')
,(1,1,'German')
,(1,2,'English')
,(1,3,'German')
,(1,3,'English')
,(1,4,'English')
,(2,5,'English')
,(2,5,'German')
,(2,5,'Spanish')
,(2,6,'German')
,(2,6,'Spanish')
,(2,7,'English');

select * from company_users;

with answer as (
select
    company_id
from
    company_users
where
    language in ('English','German')
group by
    company_id, user_id
having
    count(*)>=2)
select
    company_id
from
    answer
group by
    company_id
having
    count(*) >=2;



with answer as (
select
    eng_table.company_id,
    eng_table.user_id
from
(
select
    company_id,
    user_id,
    language
from
    company_users
where
    language='English') eng_table
inner join
(select
    company_id,
    user_id,
    language
from
    company_users
where
    language='German') german_table
on
    eng_table.user_id=german_table.user_id and eng_table.company_id=german_table.company_id)
select
    company_id
from
    answer
group by
    company_id
having
    count(user_id) >=2;
