use leetcode;
CREATE TABLE IF NOT EXISTS Products (
    product_id INT,
    store1 int,
    store2 int,
    store3 int);

insert into Products (product_id, store1,store2,store3) values (0,95,100,105);
insert into Products (product_id, store1,store2,store3) values (1,70,null,80);



with 1795_leetcode as (
select
    product_id,
    'store1' as store,
    store1 as price
from
    Products
union all
select
    product_id,
    'store2' as store,
    store2 as price
from
    Products
union all
select
    product_id,
    'store3' as store,
    store3 as price
from
    Products
order by
    product_id)
select
    product_id,
    store,
    price
from
    1795_leetcode
where
    price is not null;