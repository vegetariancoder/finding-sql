drop database online;
create database online;
use online;
Create Table Transaction_Table
(
AccountNumber int,
TransactionTime DateTime,
TransactionID int,
Balance int
);


Insert into Transaction_Table Values (550,'2020-05-12 05:29:44.120' ,1001,2000);
Insert into Transaction_Table Values (550,'2020-05-15 10:29:25.630' ,1002,8000);
Insert into Transaction_Table Values (460,'2020-03-15 11:29:23.620' ,1003,9000);
Insert into Transaction_Table Values (460,'2020-04-30 11:29:57.320' ,1004,7000);
Insert into Transaction_Table Values (460,'2020-04-30 12:32:44.233' ,1005,5000);
Insert into Transaction_Table Values (640,'2020-02-18 06:29:34.420' ,1006,5000);
Insert into Transaction_Table Values (640,'2020-02-18 06:29:37.120' ,1007,9000);

select * from Transaction_Table;

select
    *
from
    Transaction_Table
where
    (AccountNumber,TransactionTime) in (
select
    AccountNumber,
    max(TransactionTime) as max_time
from
    Transaction_Table
group by
    AccountNumber)
order by
    TransactionID;

with answer as (
select
    *,
    dense_rank() over (partition by AccountNumber order by TransactionTime desc ) as drnk
from
    Transaction_Table)
select
    AccountNumber,
    TransactionTime,
    TransactionID,
    Balance
from
    answer
where
    drnk=1
order by
    TransactionID;