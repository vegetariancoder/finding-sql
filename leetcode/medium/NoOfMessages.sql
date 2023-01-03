drop database online;
create database online;
use online;

CREATE TABLE subscriber (
 sms_date date ,
 sender varchar(20) ,
 receiver varchar(20) ,
 sms_no int
);
INSERT INTO subscriber VALUES ('2020-4-1', 'Avinash', 'Vibhor',10);
INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Avinash',20);
INSERT INTO subscriber VALUES ('2020-4-1', 'Avinash', 'Pawan',30);
INSERT INTO subscriber VALUES ('2020-4-1', 'Pawan', 'Avinash',20);
INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Pawan',5);
INSERT INTO subscriber VALUES ('2020-4-1', 'Pawan', 'Vibhor',8);
INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Deepak',50);


select * from subscriber;

with answer as (
select
    *,
    case
        when sender<receiver then sender else receiver
    end as p1,
    case
        when sender>receiver then sender else receiver
    end as p2
from
    subscriber)
select
    sms_date,
    p1 as sender,
    p2 as receiver,
    sum(sms_no) as total_sms
from
    answer
group by
    sms_date, p1, p2
order by
    total_sms desc ;