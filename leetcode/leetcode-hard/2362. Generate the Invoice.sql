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

with cte1 as (
select
    invoice_id,
    sum(quantity*price) as price,
    dense_rank() over (order by sum(quantity*price) desc ) as drnk
from
    (
select
    invoice_id,
    quantity,
    price
from
    Purchases
inner join
    Products
on
    Purchases.product_id = Products.product_id) calc
group by
    invoice_id)
, cte2 as (
select
    min(invoice_id) as invoice
from
    cte1
where
    drnk=1)
select
    Purchases.product_id,
    quantity,
    price * quantity as price
from
    Purchases
inner join
    Products
on
    Purchases.product_id = Products.product_id
where
    invoice_id=(select invoice from cte2)
order by
    price desc ;


