use leetcode;

Create table If Not Exists Products (product_id int, store varchar(100), price int);
insert into Products (product_id, store, price) values (1,'Shop',110),
                                                       (1,'LC_Store',100),
                                                       (2,'Nozama',20),
                                                       (2,'Souq',190),
                                                       (3,'Shop',1000),
                                                       (3,'Souq',1900);

select * from Products;

create table Prod as (
select
    product_id,
    sum(case
        when store='LC_Store' then price
    end) as LC_Store,
    sum(case
        when store='Nozama' then price
    end) as Nozama,
    sum(case
        when store='Shop' then price
    end) as Shop,
    sum(case
        when store='Souq' then price
    end) as Souq
from
    Products
group by
    product_id);

