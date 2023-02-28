drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Products (product_id int,new_price int, change_date date);
insert into Products (product_id,new_price,change_date) value (1,20,'2019-08-14');
insert into Products (product_id,new_price,change_date) value (2,50,'2019-08-14');
insert into Products (product_id,new_price,change_date) value (1,30,'2019-08-15');
insert into Products (product_id,new_price,change_date) value (1,35,'2019-08-16');
insert into Products (product_id,new_price,change_date) value (2,65,'2019-08-17');
insert into Products (product_id,new_price,change_date) value (3,20,'2019-08-18');


with answer as (
select
    product_id,
    new_price
from
    (
select
    product_id,
    new_price,
    change_date,
    dense_rank() over (partition by product_id order by change_date desc ) as drnk
from
    Products
where
    change_date <= '2019-08-16'
order by
    product_id)calc_table
where
    drnk=1)
select
    distinct Products.product_id,
    ifnull(answer.new_price,10) as price
from
    Products
left join
    answer
on
    Products.product_id=answer.product_id;
