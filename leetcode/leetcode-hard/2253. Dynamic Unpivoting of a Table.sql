drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Products (product_id int, LC_Store int , Nozama int, Shop int, Souq int);
insert into Products (product_id,LC_Store,Nozama,Shop,Souq) value (1,100,0,110,0);
insert into Products (product_id,LC_Store,Nozama,Shop,Souq) value (2,0,200,0,190);
insert into Products (product_id,LC_Store,Nozama,Shop,Souq) value (3,0,0,1000,1900);



with answer as (
select
    product_id,
    case
        when LC_Store then 'LC_Store'
    end as store,
    case
        when LC_Store then LC_Store
    end as price
from
    Products
union all
select
    product_id,
    case
        when Nozama then 'Nozama'
    end as store,
    case
        when Nozama then Nozama
    end as price
from
    Products
union all
select
    product_id,
    case
        when Shop then 'Shop'
    end as store,
    case
        when Shop then Shop
    end as price
from
    Products
union all
select
    product_id,
    case
        when Souq then 'Souq'
    end as store,
    case
        when Souq then Souq
    end as price
from
    Products)
select
    product_id,
    store,
    price
from
    answer
where
    store is not null or price is not null
order by
    product_id;