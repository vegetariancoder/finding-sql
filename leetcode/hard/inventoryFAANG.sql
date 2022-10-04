drop database leetcode;
create database leetcode;
use leetcode;
create table warehouse
(
ID varchar(10),
OnHandQuantity int,
OnHandQuantityDelta int,
event_type varchar(10),
event_datetime timestamp
);

insert into warehouse values
('SH0013', 278, 99 , 'OutBound', '2020-05-25 0:25'),
('SH0012', 377, 31 , 'InBound', '2020-05-24 22:00'),
('SH0011', 346, 1 , 'OutBound', '2020-05-24 15:01'),
('SH0010', 346, 1 , 'OutBound', '2020-05-23 5:00'),
('SH009', 348, 102, 'InBound', '2020-04-25 18:00'),
('SH008', 246, 43 , 'InBound', '2020-04-25 2:00'),
('SH007', 203, 2 , 'OutBound', '2020-02-25 9:00'),
('SH006', 205, 129, 'OutBound', '2020-02-18 7:00'),
('SH005', 334, 1 , 'OutBound', '2020-02-18 8:00'),
('SH004', 335, 27 , 'OutBound', '2020-01-29 5:00'),
('SH003', 362, 120, 'InBound', '2019-12-31 2:00'),
('SH002', 242, 8 , 'OutBound', '2019-05-22 0:50'),
('SH001', 250, 250, 'InBound', '2019-05-20 0:45');

select * from warehouse;

select date_sub('2020-05-25',interval 365 day);

select
    90_days_data as '0-90 days old',
    180_days_data '91-180 days old',
    270_days_data as '181-270 days old',
    365_days_data as '271-365 days old'
from
    (
select
    '1' as number,
    sum(case
        when event_type='Inbound' then OnHandQuantityDelta
    end) as 365_days_data
from
    warehouse
where
    event_datetime between date_sub('2020-05-25',interval 365 day) and date_sub('2020-05-25',interval 270 day )) 365_days_table
inner join
(select
    '1' as number,
    sum(case
        when event_type='Inbound' then OnHandQuantityDelta
    end) as 270_days_data
from
    warehouse
where
    event_datetime between date_sub('2020-05-25',interval 270 day) and date_sub('2020-05-25',interval 180 day)) 270_days_table
on
    365_days_table.number=270_days_table.number
inner join
(
select
    '1' as number,
    sum(case
        when event_type='Inbound' then OnHandQuantityDelta
    end) as 180_days_data
from
    warehouse
where
    event_datetime between date_sub('2020-05-25',interval 180 day) and date_sub('2020-05-25',interval 90 day )) 180_days_table
on
    270_days_table.number = 180_days_table.number
inner join
(
select
    '1' as number,
    sum(case
        when event_type='Inbound' then OnHandQuantityDelta
    end) as 90_days_data
from
    warehouse
where
    event_datetime between date_sub('2020-05-25',interval 90 day ) and '2020-05-25') 90_days_table
on
    180_days_table.number = 90_days_table.number;