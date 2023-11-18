drop database leetcode;
create database leetcode;
use leetcode;

CREATE TABLE Seller (
    seller_id INT,
    join_date DATE,
    favorite_brand VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT,
    order_date DATE,
    item_id INT,
    seller_id INT
);

CREATE TABLE Items (
    item_id INT,
    item_brand VARCHAR(50)
);

INSERT INTO Seller (seller_id, join_date, favorite_brand)
VALUES
    (1, '2019-01-01', 'Lenovo'),
    (2, '2019-02-09', 'Samsung'),
    (3, '2019-01-19', 'LG');

INSERT INTO Orders (order_id, order_date, item_id, seller_id)
VALUES
    (1, '2019-08-01', 4, 2),
    (2, '2019-08-02', 2, 3),
    (3, '2019-08-03', 3, 3),
    (4, '2019-08-04', 1, 2),
    (5, '2019-08-04', 4, 2);

INSERT INTO Items (item_id, item_brand)
VALUES
    (1, 'Samsung'),
    (2, 'Lenovo'),
    (3, 'LG'),
    (4, 'HP');


select * from Orders;

with answer as (
select
    Orders.seller_id,
    Items.item_brand,
    count(distinct Items.item_brand) as cnt,
    dense_rank() over (order by count(distinct Items.item_brand)) as drnk
from
    Orders
inner join
    Seller
on
    Orders.seller_id = Seller.seller_id
inner join
    Items
on
    Orders.item_id = Items.item_id
where
    favorite_brand<>Items.item_brand
group by
    1,2)
select
    seller_id,
    cnt as num_items
from
    answer;

