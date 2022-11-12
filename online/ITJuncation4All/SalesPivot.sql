drop database online;
create database online;
use online;


Create Table Sales
(
Id int,
Product varchar(100),
SalesYear int,
QuantitySold int
);

Insert into Sales Values (1,'Laptop',1998,2500);
Insert into Sales Values (2,'Laptop',1999,3600);
Insert into Sales Values (3,'Laptop',2000,4200);
Insert into Sales Values (4,'Keyboard',1998,2300);
Insert into Sales Values (5,'Keyboard',1999,4800);
Insert into Sales Values (6,'Keyboard',2000,5000);
Insert into Sales Values (7,'Mouse',1998,6000);
Insert into Sales Values (8,'Mouse',1999,3400);
Insert into Sales Values (9,'Mouse',2000,4600);

select * from Sales;

with answer as (
select
    SalesYear,
    sum(QuantitySold) as sold_sum
from
    Sales
group by
    SalesYear)
select
    'TotalSales' as TotalSales,
    sum(case
        when SalesYear = 1998 then sold_sum
    end) as '1998',
    sum(case
        when SalesYear = 1999 then sold_sum
    end) as '1999',
    sum(case
        when SalesYear = 2000 then sold_sum
    end) as '2000'
from
    answer
group by
    TotalSales;