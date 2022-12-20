drop database datalemur;
create database datalemur;
use datalemur;

Create table If Not Exists products (product_id int, category varchar(100), name varchar(100));
insert into products (product_id, category, name) values (1,'Shoes','Sperry Boat Shoe');
insert into products (product_id, category, name) values (2,null,'Adidas Stan Smith');
insert into products (product_id, category, name) values (3,null,'Vans Authentic');
insert into products (product_id, category, name) values (4,'Jeans','Levi 511');
insert into products (product_id, category, name) values (5,null,'Wrangler Straight Fit');
insert into products (product_id, category, name) values (6,'Shirts','Lacoste Classic Polo');
insert into products (product_id, category, name) values (7,null,'Nautica Linen Shirt');


select * from products;

with cte1 as (
select
    *,
    row_number() over (order by (select null)) as r_no
from
    products),
cte2 as (
select
    *,
    lead(r_no,1,99) over (order by r_no) as next_rno
from
    cte1
where
    category is not null)
select
    cte1.product_id,
    cte2.category,
    cte1.name
from
    cte1
inner join
    cte2
on
    cte1.r_no >=cte2.r_no and cte1.r_no <= cte2.next_rno-1;



with answer as (
select
    product_id,
    category,
    name,
    count(category) over (order by product_id) as cat_grp
from
    products)
select
    product_id,
    first_value(category) over (partition by cat_grp) as category,
    name
from
    answer;
