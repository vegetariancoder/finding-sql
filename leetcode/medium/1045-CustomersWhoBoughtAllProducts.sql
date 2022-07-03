use leetcode;
create table If Not Exists Customer (customer_id int, product_key int);
insert into Customer (customer_id, product_key) values (1,5);
insert into Customer (customer_id, product_key) values (2,6);
insert into Customer (customer_id, product_key) values (3,5);
insert into Customer (customer_id, product_key) values (3,6);
insert into Customer (customer_id, product_key) values (1,6);


create table If Not Exists Product (product_key int);
insert into Product (product_key) values (5);
insert into Product (product_key) values (6);


select
    distinct customer_id
from
    Customer
where
    customer_id in (
select
    customer_id
from
    Customer
group by
    customer_id
having
    count(product_key) >=2)
and
    product_key in (select product_key from Product);