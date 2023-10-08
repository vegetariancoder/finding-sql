drop database online;
create database online;
use online;

create table iphone
(
	user			int,
	phone			varchar(100)
);
insert into iphone values (1,'iphone-15');
insert into iphone values (1,'iphone-11');
insert into iphone values (1,'iphone-12');
insert into iphone values (1,'iphone-13');
insert into iphone values (1,'iphone-14');
insert into iphone values (2,'iphone-15');
insert into iphone values (2,'iphone-12');

create table products
(
	phone			varchar(100)
);

insert into products values ('iphone-11');
insert into products values ('iphone-12');
insert into products values ('iphone-13');
insert into products values ('iphone-14');
insert into products values ('iphone-15');

select * from iphone;

select
    user
from
    iphone
where
    phone in ('iphone-15') and user not in (select user from iphone where phone in ('iphone-11'));

select
    user
from
    iphone
where
    phone in ('iphone-11');

with cte as (
select
    *,
    sum(case when phone = 'iphone-15' then 1 else 0 end ) over (partition by user) as flag_cnt,
    count(phone) over (partition by user) as total
from
    iphone)
select
    user
from
    cte
where
    flag_cnt = total;

select * from iphone;
select * from products;

with answer as (
select
    user,
    count(distinct phone) as dis_phones,
    (select count(distinct phone) from products) as total_phones
from
    iphone
group by
    user)
select
    user
from
    answer
where
    dis_phones = total_phones;