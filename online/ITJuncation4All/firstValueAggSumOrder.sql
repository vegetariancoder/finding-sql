drop database online;
create database online;
use online;

Create Table Sales1
(
Id int,
Product Varchar(20),
Sales int
);

Insert into Sales1 values(1001,'Keyboard',20);
Insert into Sales1 values(1002,'Keyboard',25);
Insert into Sales1 values(1003,'Laptop',30);
Insert into Sales1 values(1004,'Laptop',35);
Insert into Sales1 values(1005,'Laptop',40);
Insert into Sales1 values(1006,'Monitor',45);
Insert into Sales1 values(1007,'WebCam',50);
Insert into Sales1 values(1008,'WebCam',55);


select * from Sales1;

with answer as (
select
    *,
    first_value(Sales) over (partition by Product order by Sales) as fv
from
    Sales1)
select
    Id,
    Product,
    fv as sales_1
from
    answer;


with answer as (
select
    *,
    sum(Sales) over (partition by Product order by Sales) as sm
from
    Sales1)
select
    Id,
    Product,
    sm as sales_2
from
    answer;