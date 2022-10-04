drop database datalemur;
create database datalemur;
use datalemur;


Create table If Not Exists adobe_transactions (customer_id int, product varchar(100), revenue int);
insert into adobe_transactions (customer_id, product, revenue) values (123,'Photoshop',50);
insert into adobe_transactions (customer_id, product, revenue) values (123,'Premier Pro',100);
insert into adobe_transactions (customer_id, product, revenue) values (123,'After Effects',50);
insert into adobe_transactions (customer_id, product, revenue) values (234,'Illustrator',200);
insert into adobe_transactions (customer_id, product, revenue) values (234,'Premier Pro',100);

select * from adobe_transactions;

select
    customer_id,
    sum(revenue) as revenue
from
    adobe_transactions
where
    customer_id in (
select
    customer_id
from
    adobe_transactions
where
    product ='Photoshop') and product != 'Photoshop'
group by
    customer_id;