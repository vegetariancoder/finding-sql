drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Sales (sale_id int, product_id int, year_value int,
    quantity int, price int);

insert into Sales (sale_id, product_id, year_value,quantity,price ) values (1,100,2008,10,5000);
insert into Sales (sale_id, product_id, year_value,quantity,price ) values (2,100,2009,12,5000);
insert into Sales (sale_id, product_id, year_value,quantity,price ) values (7,200,2011,15,9000);


select
    product_id,
    sum(quantity) as total_quantity
from
    Sales
group by
    product_id;