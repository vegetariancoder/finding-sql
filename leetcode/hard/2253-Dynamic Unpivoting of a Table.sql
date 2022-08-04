drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Products (product_id int, LC_Store int , Nozama int, Shop int, Souq int);
insert into Products (product_id,LC_Store,Nozama,Shop,Souq) value (1,100,0,110,0);
insert into Products (product_id,LC_Store,Nozama,Shop,Souq) value (2,0,200,0,190);
insert into Products (product_id,LC_Store,Nozama,Shop,Souq) value (3,0,0,1000,1900);

with 2253_leetcode as (
select
    product_id,
    'LC_Store' as store,
    LC_Store as price
from
    Products
union all
select
    product_id,
    'Nozama' as store,
    Nozama as price
from
    Products
union all
select
    product_id,
    'Shop' as store,
    Shop as price
from
    Products
union all
select
    product_id,
    'Souq' as store,
    Souq as price
from
    Products)
select
    *
from
    2253_leetcode
where
    price !=0
order by
    product_id;
