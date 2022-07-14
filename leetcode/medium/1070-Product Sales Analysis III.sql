use leetcode;
create table If Not Exists Sales (sales_id int, product_id int, year int, quantity int, price int);
insert into Sales (sales_id,product_id,year,quantity,price) values (1,100,2008,10,5000),
                                                              (2,100,2009,12,5000),
                                                              (7,200,2011,15,9000);


select * from Sales;


with min_year_tb as (
select
    product_id as pid,
    min(year) as min_year
from
    Sales
group by
    product_id)
select
    distinct product_id,
    year as first_year,
    quantity,
    price
from
    Sales
where
    (product_id,year) in (select pid,min_year from min_year_tb)
order by
    product_id;


