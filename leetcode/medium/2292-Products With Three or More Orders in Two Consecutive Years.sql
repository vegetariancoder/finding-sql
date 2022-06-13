use leetcode;

CREATE TABLE Orders (
order_id int,
product_id int,
quantity int,
purchase_date date
);

drop table Orders;
INSERT into Orders values (1,1,7,'2020-03-16'),
                          (2,1,4,'2020-12-02'),
                          (3,1,7,'2020-05-10'),
                          (4,1,6,'2021-12-23'),
                          (5,1,5,'2021-05-21'),
                          (6,1,6,'2021-10-11'),
                          (7,2,8,'2021-10-06'),
                          (8,2,6,'2022-10-11');

select * from Orders;

with 2292_leetcode as (
select
    *,
    year(purchase_date) as year_value,
    lag(year(purchase_date),1) over (partition by product_id order by year(purchase_date)) as year_1
from
    Orders)
select
    product_id
from
    2292_leetcode
where
    year_1 = year_value-1;


with maintable as (
select
    *,
    year(purchase_date) as year_value,
    year(date_add(purchase_date, INTERVAL -1 YEAR)) as prev_year
from
    Orders)
select
    *
from
    maintable
where
    year_value = prev_year+1;


