drop database leetcode;
create database leetcode;
use leetcode;
CREATE TABLE IF NOT EXISTS Sales (sale_id int, product_id int, user_id int, qunatity int);

insert into Sales (sale_id, product_id, user_id,qunatity)
values (1,1,101,10);
insert into Sales (sale_id, product_id, user_id,qunatity)
values (2,3,101,7);
insert into Sales (sale_id, product_id, user_id,qunatity)
values (3,1,102,9);
insert into Sales (sale_id, product_id, user_id,qunatity)
values (4,2,102,6);
insert into Sales (sale_id, product_id, user_id,qunatity)
values (5,3,102,10);
insert into Sales (sale_id, product_id, user_id,qunatity)
values (6,1,102,6);






drop table Product;
CREATE TABLE IF NOT EXISTS Product (product_id int, price int);

insert into Product(product_id,price)
values (1,10);
insert into Product(product_id,price)
values (2,25);
insert into Product(product_id,price)
values (3,15);


select * from Sales;
select * from Product;


with 2324_leetcode as (
select
    user_id,
    Sales.product_id,
    sum((price*Sales.qunatity))as costing,
    dense_rank() over (partition by user_id order by sum((price*Sales.qunatity)) desc ) as drnk
from
    Sales
inner join
    Product P on Sales.product_id = P.product_id
group by
    user_id, Sales.product_id)
select
    user_id,
    product_id
from
    2324_leetcode
where
    drnk=1;
