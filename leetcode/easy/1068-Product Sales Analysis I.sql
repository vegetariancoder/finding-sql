drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Sales (sale_id int, product_id int, year int, qunatity int, price int);
insert into Sales (sale_id,product_id,year,qunatity,price) value (1,100,2008,10,5000);
insert into Sales (sale_id,product_id,year,qunatity,price) value (2,100,2009,12,5000);
insert into Sales (sale_id,product_id,year,qunatity,price) value (7,200,2011,15,9000);


Create table If Not Exists Product (product_id int, product_name varchar(100));
insert into Product (product_id,product_name) value (100,'Nokia');
insert into Product (product_id,product_name) value (200,'Apple');
insert into Product (product_id,product_name) value (300,'Samsung');


select
    product_name,
    year,
    price
from
    Sales
left join
    Product
using
    (product_id);
