drop database online;
create database online;
use online;


Create Table Account_Table(
TranDate DateTime,
TranID Varchar(20),
TranType Varchar(10),
Amount int);

INSERT Account_Table (TranDate, TranID, TranType, Amount) VALUES ('2020-05-12T05:29:44.120', 'A10001','Credit', 50000);
INSERT Account_Table (TranDate, TranID, TranType, Amount) VALUES ('2020-05-13T10:30:20.100', 'B10001','Debit', 10000);
INSERT Account_Table (TranDate, TranID, TranType, Amount) VALUES ('2020-05-13T11:27:50.130', 'B10002','Credit', 20000);
INSERT Account_Table (TranDate, TranID, TranType, Amount) VALUES ('2020-05-14T08:35:30.123', 'C10001','Debit', 5000);
INSERT Account_Table (TranDate, TranID, TranType, Amount) VALUES ('2020-05-14T09:43:51.100', 'C10002','Debit', 5000);
INSERT Account_Table (TranDate, TranID, TranType, Amount) VALUES ('2020-05-15T05:51:11.117', 'D10001','Credit', 30000);

select * from Account_Table;

select
    *,
    sum(case when TranType='Credit' then Amount else -Amount end) over (order by TranDate) as Net_balance
from
    Account_Table;



select
    TranDate,
    TranID,
    TranType,
    Amount,
    sum(TempAmount) over (order by TranDate) as NetAmount
from
     (
select
    *,
    case
        when TranType='Credit' then Amount else -Amount
    end as TempAmount
from
    Account_Table) calc_table
group by
    TranDate, TranID, TranType, Amount;

