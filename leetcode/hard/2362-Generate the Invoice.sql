drop database leetcode;
create database leetcode;
use leetcode;

Create table If Not Exists Products (product_id int, price int);

insert into Products (product_id,price) values(1,100);
insert into Products (product_id,price) values(2,200);


Create table If Not Exists Purchases (invoice_id int, product_id int, quantity int);

insert into Purchases (invoice_id,product_id,quantity) values(1,1,2);
insert into Purchases (invoice_id,product_id,quantity) values(3,2,1);
insert into Purchases (invoice_id,product_id,quantity) values(2,2,3);
insert into Purchases (invoice_id,product_id,quantity) values(2,1,4);
insert into Purchases (invoice_id,product_id,quantity) values(4,1,10);



select
    Purchases.product_id,
    quantity,
    quantity*Products.price as price
from
    Purchases
left join
    Products
on
    Purchases.product_id = Products.product_id
where
    Purchases.invoice_id in (
select
    min(invoice_id) as min_id
from
    (
select
    Purchases.invoice_id as invoice_id,
    dense_rank() over (order by sum(quantity*price) desc ) as drnk
from
    Purchases
left join
    Products on Purchases.product_id = Products.product_id
group by
    Purchases.invoice_id) agg_table
where
    drnk=1)