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




select
    d_prod_id as product_id,
    ifnull(new_price,10) as price
from
    (
select
    distinct product_id as d_prod_id
from
    Products) table1
left join
(select
    product_id,
    new_price
from
    (
select
    *,
    dense_rank() over (partition by product_id order by new_price desc ) as drnk
from
    Products
where
    change_date <= '2019-08-16') max_table
where
    drnk=1) table2
on
    table1.d_prod_id=table2.product_id;