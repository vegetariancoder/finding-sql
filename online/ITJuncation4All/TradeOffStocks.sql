drop database online;
create database online;
use online;

Create Table Trade_tbl(
TRADE_ID varchar(20),
Trade_Timestamp time,
Trade_Stock varchar(20),
Quantity int,
Price Float
);

Insert into Trade_tbl Values('TRADE1','10:01:05','ITJunction4All',100,20);
Insert into Trade_tbl Values('TRADE2','10:01:06','ITJunction4All',20,15);
Insert into Trade_tbl Values('TRADE3','10:01:08','ITJunction4All',150,30);
Insert into Trade_tbl Values('TRADE4','10:01:09','ITJunction4All',300,32);
Insert into Trade_tbl Values('TRADE5','10:10:00','ITJunction4All',-100,19);
Insert into Trade_tbl Values('TRADE6','10:10:01','ITJunction4All',-300,19);


select * from Trade_tbl;

with answer as (
select
    tb1.TRADE_ID as first_trade,
    tb2.TRADE_ID as second_trade,
    (tb1.Price-tb2.Price)/tb1.Price*100 as price_diff,
   second(timediff(tb1.Trade_Timestamp,tb2.Trade_Timestamp)) as seconds
from
    Trade_tbl tb1
cross join
    Trade_tbl tb2
where
    tb1.TRADE_ID!= tb2.TRADE_ID
order by
    tb1.TRADE_ID)
select
    first_trade,
    second_trade,
    round(abs(price_diff),2) as price_diff
from
    answer
where
    seconds < 10;
