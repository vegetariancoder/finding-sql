drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Warehouse (name varchar(20),product_id int, units int);
Create table If Not Exists Products (product_id int, product_name varchar(100), Width int, leng int, Height int);

insert into Warehouse (name, product_id,units) values ('LCHouse1',1,1);
insert into Warehouse (name, product_id,units) values ('LCHouse1',2,10);
insert into Warehouse (name, product_id,units) values ('LCHouse1',3,5);
insert into Warehouse (name, product_id,units) values ('LCHouse2',1,2);
insert into Warehouse (name, product_id,units) values ('LCHouse2',2,2);
insert into Warehouse (name, product_id,units) values ('LCHouse3',4,1);


insert into Products (product_id, product_name,Width,leng,Height) values (1,'LC-TV',5,50,40);
insert into Products (product_id, product_name,Width,leng,Height) values (2,'LC-KeyChain',5,5,5);
insert into Products (product_id, product_name,Width,leng,Height) values (3,'LC-Phone',2,10,10);
insert into Products (product_id, product_name,Width,leng,Height) values (4,'LC-T-Shirt',4,10,20);



select
    name,
    sum(Width*leng*Height*units) as volume
from
    Warehouse
left join
    Products
on
    Warehouse.product_id = Products.product_id
group by
    name;


