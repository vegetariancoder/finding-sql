drop database online;
create database online;
use online;

Create Table Transactions_Walmart (
transaction_id int,
product_id int,
users_id int,
transaction_date varchar(100)
);

Insert into Transactions_Walmart values ('231574', 111, 234, '03/01/2022 12:00:00');
Insert into Transactions_Walmart values ('231574', 444, 234, '03/01/2022 12:00:00');
Insert into Transactions_Walmart values ('231574', 222, 234, '03/01/2022 12:00:00');
Insert into Transactions_Walmart values ('137124', 444, 125, '03/05/2022 12:00:00');
Insert into Transactions_Walmart values ('256234', 222, 311, '03/07/2022 12:00:00');
Insert into Transactions_Walmart values ('523152', 222, 746, '03/06/2022 12:00:00');
Insert into Transactions_Walmart values ('141415', 333, 235, '03/02/2022 12:00:00');
Insert into Transactions_Walmart values ('523152', 444, 746, '03/06/2022 12:00:00');
Insert into Transactions_Walmart values ('137124', 111, 125, '03/05/2022 12:00:00');
Insert into Transactions_Walmart values ('256234', 333, 311, '03/07/2022 12:00:00');

Create Table Products_Walmart(
product_id int,
product_name varchar(50)
);

Insert into Products_Walmart values (111,'apple');
Insert into Products_Walmart values (222,'soya milk');
Insert into Products_Walmart values (333,'instant oatmeal');
Insert into Products_Walmart values (444,'banana');
Insert into Products_Walmart values (555,'chia seed');

select * from Transactions_Walmart;
select * from Products_Walmart;

with answer as (
select
    transaction_id,
    Transactions_Walmart.product_id,
    product_name
from
    Transactions_Walmart
inner join
    Products_Walmart on Transactions_Walmart.product_id = Products_Walmart.product_id),
    mainanswer as (
select
    a1.product_name as product_1,
    a2.product_name as product_2,
    count(*) as combo_count
from
    answer a1
inner join
    answer a2
on
    a1.transaction_id=a2.transaction_id and a1.product_name < a2.product_name
group by
    a1.product_name, a2.product_name)
select
    product_1,
    product_2,
    combo_count
from
    mainanswer
order by
    combo_count desc
limit 3;