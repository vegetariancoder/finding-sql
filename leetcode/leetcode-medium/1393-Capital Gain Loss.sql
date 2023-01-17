drop database leetcode;
create database leetcode;
use leetcode;
SET GLOBAL time_zone = '+3:00';

Create table If Not Exists Stocks (stock_name varchar(100), operation varchar(100) , operation_day int, price int);

insert into Stocks (stock_name,operation,operation_day,price) value ('Leetcode','Buy',1,1000);
insert into Stocks (stock_name,operation,operation_day,price) value ('Corona Masks','Buy',2,10);
insert into Stocks (stock_name,operation,operation_day,price) value ('Leetcode','Sell',5,9000);
insert into Stocks (stock_name,operation,operation_day,price) value ('Handbags','Buy',17,30000);
insert into Stocks (stock_name,operation,operation_day,price) value ('Corona Masks','Sell',3,1010);
insert into Stocks (stock_name,operation,operation_day,price) value ('Corona Masks','Buy',4,1000);
insert into Stocks (stock_name,operation,operation_day,price) value ('Corona Masks','Sell',5,500);
insert into Stocks (stock_name,operation,operation_day,price) value ('Corona Masks','Buy',6,1000);
insert into Stocks (stock_name,operation,operation_day,price) value ('Handbags','Sell',29,7000);
insert into Stocks (stock_name,operation,operation_day,price) value ('Corona Masks','Sell',10,10000);

select * from Stocks;

with answer as (
select
    stock_name,
    sum(case
        when operation='Buy' then price
    end) as buy_price,
    sum(case
        when operation='Sell' then price
    end) as sell_price
from
    Stocks
group by
    stock_name
order by
    stock_name)
select
    stock_name,
    sell_price-buy_price as capital_gain_loss
from
    answer
order by
    capital_gain_loss desc ;



select
    stock_name,
    sum(case
        when operation='Sell' then price else -price
    end) as capital_gain_loss
from
    Stocks
group by
    stock_name;
