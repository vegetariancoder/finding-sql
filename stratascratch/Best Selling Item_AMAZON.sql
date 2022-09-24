drop database strata;
create database strata;
use strata;
create table online_retail
(
invoiceno varchar(100),
stockcode varchar(100),
description varchar(100),
quantity int,
invoicedate datetime,
unitprice float,
customerid float,
country varchar(100)
);

select * from online_retail;

with answer as (
select
    *,
    rank() over (partition by month order by sold_price desc) as rno
from
    (
select
    stockcode,
    month(invoicedate) as month,
    round(sum(quantity*online_retail.unitprice),2) as sold_price
from
    online_retail
group by
    stockcode,month
order by
    month) calc_table)
select
    description,
    sold_price,
    month
from
    answer
right join
    online_retail
on
    answer.stockcode=online_retail.stockcode
where
    rno=1
order by
    month;