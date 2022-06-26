drop database leetcode;

create database leetcode;

use leetcode;


create table If Not Exists Sales (seller_id int,product_id int ,buyer_id int);

insert into Sales (seller_id, product_id, buyer_id) values (1,1,1);
insert into Sales (seller_id, product_id, buyer_id) values (1,2,2);
insert into Sales (seller_id, product_id, buyer_id) values (2,1,3);
insert into Sales (seller_id, product_id, buyer_id) values (3,3,3);



select
    buyer_id
from
    Sales
where
    buyer_id not in (
select
    buyer_id
from
    Sales
where
    product_id = 3)
and
    product_id = 1;
