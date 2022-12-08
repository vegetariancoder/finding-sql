drop database online;
create database online;
use online;

CREATE TABLE Transaction_Tbl(
 CustID int ,
 TranID int ,
 TranAmt float ,
 TranDate date 
);

INSERT Transaction_Tbl (CustID, TranID, TranAmt, TranDate) VALUES (1001, 20001, 10000, '2020-04-25');
INSERT Transaction_Tbl (CustID, TranID, TranAmt, TranDate) VALUES (1001, 20002, 15000, '2020-04-25');
INSERT Transaction_Tbl (CustID, TranID, TranAmt, TranDate) VALUES (1001, 20003, 80000, '2020-04-25');
INSERT Transaction_Tbl (CustID, TranID, TranAmt, TranDate) VALUES (1001, 20004, 20000, '2020-04-25');
INSERT Transaction_Tbl (CustID, TranID, TranAmt, TranDate) VALUES (1002, 30001, 7000, '2020-04-25');
INSERT Transaction_Tbl (CustID, TranID, TranAmt, TranDate) VALUES (1002, 30002, 15000, '2020-04-25');
INSERT Transaction_Tbl (CustID, TranID, TranAmt, TranDate) VALUES (1002, 30003, 22000, '2020-04-25');

select * from Transaction_Tbl;


with answer as (
select
    CustID,
    TranID,
    TranAmt,
    max(TranAmt) over (partition by CustID range between unbounded preceding and unbounded following) as MaxTranAmt,
    TranDate
from
    Transaction_Tbl)
select
    CustID,
    TranID,
    TranAmt,
    MaxTranAmt,
    round(TranAmt/MaxTranAmt,3) as Ratio,
    TranDate
from
    answer;

with answer as (
select
    *,
    first_value(TranAmt) over (partition by CustID order by TranAmt desc ) as fv
from
    Transaction_Tbl)
select
    CustID,
    TranID,
    TranAmt,
    fv as MaxTranAmt,
    round(TranAmt/fv,2) as Ratio,
    TranDate
from
    answer;



