use leetcode;

CREATE TABLE Orders (
order_id int,
product_id int,
quantity int,
purchase_date date
);

INSERT into Orders values (1,1,7,'2020-03-16'),
                          (2,1,4,'2020-12-02'),
                          (3,1,7,'2020-05-10'),
                          (4,1,6,'2021-12-23'),
                          (5,1,5,'2021-05-21'),
                          (6,1,6,'2021-10-11'),
                          (7,2,8,'2021-10-06'),
                          (8,2,6,'2022-10-11');


select * from Orders;

select
    product_id
from
    (select
    product_id,
    extract(year from purchase_date) as year_value,
    count(order_id) as cnt
from
    Orders
group by
    product_id, extract(year from purchase_date)) as year_2020
where
    year_value=2020 and cnt=3
union
select
    product_id
from
    (select
    product_id,
    extract(year from purchase_date) as year_value,
    count(order_id) as cnt
from
    Orders
group by
    product_id, extract(year from purchase_date)) as year_2021
where
    year_value=2021 and cnt=3;


