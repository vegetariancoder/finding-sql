drop database leetcode;

create database leetcode;
use leetcode;

CREATE TABLE Users (
user_id int,
join_date date,
favorite_brand varchar(100)
);

INSERT into Users values (1,'2018-01-01','Lenovo'),
 (2,'2018-02-09','Samsung'),
 (3,'2018-01-19','LG'),
 (4,'2018-05-21','HP');

CREATE TABLE Orders (
order_id int,
order_date date,
item_id int,
buyer_id int,
seller_id int
);

INSERT into Orders values (1,'2019-08-01',4,1,2),
  (2,'2018-08-02',2,1,3),
  (3,'2019-08-03',3,2,3),
  (4,'2018-08-04',1,4,2),
  (5,'2018-08-04',1,3,4),
  (6,'2019-08-05',2,2,4);

CREATE TABLE Items (
item_id int,
item_brand varchar (100)
);

INSERT into Items values (1,'Samsung'),
                         (2,'Lenovo'),
                         (3,'LG'),
                         (4,'HP');


with maintable as (
select
    buyer_id,
    count(buyer_id) as count_values
from
    Orders
where
    year(order_date) = 2019
group by
    buyer_id)
select
    user_id as buyer_id,
    join_date,
    ifnull(count_values,0) as orders_in_2019
from
    Users
left join
    maintable
on
    Users.user_id = maintable.buyer_id;


