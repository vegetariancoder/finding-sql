drop database online;
create database online;
use online;

create table payments_data (
trx_date date,
merchant varchar(100),
amount int,
payment_mode varchar(100));

insert into payments_data
values ('2022-04-02','merchant_1',150,'CASH'),
       ('2022-04-02','merchant_1',500,'ONLINE'),
       ('2022-04-03','merchant_2',450,'ONLINE'),
       ('2022-04-03','merchant_1',100,'CASH'),
       ('2022-04-03','merchant_3',600,'CASH'),
       ('2022-04-05','merchant_5',200,'ONLINE'),
       ('2022-04-05','merchant_2',100,'ONLINE');


select
    merchant,
    ifnull(sum(case
        when payment_mode = 'CASH' then amount
    end),0) as cash_amount,
    ifnull(sum(case
        when payment_mode='ONLINE' then amount
    end),0) as online_amount
from
    payments_data
group by
    merchant;