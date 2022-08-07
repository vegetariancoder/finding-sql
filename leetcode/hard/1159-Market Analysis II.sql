drop database leetcode;
create database leetcode;
use leetcode;

CREATE TABLE IF NOT EXISTS Users (
    user_id INT,
    join_date date,
    favorite_brand varchar(100));


CREATE TABLE IF NOT EXISTS Orders (
    order_id INT,
    order_date date,
    item_id int,
    buyer_id int,
    seller_id int);

CREATE TABLE IF NOT EXISTS Items (
    item_id INT,
    item_brand varchar(100));


insert into Users (user_id,join_date,favorite_brand) values (1,'2019-01-01','Lenovo');
insert into Users (user_id,join_date,favorite_brand) values (2,'2019-02-09','Samsung');
insert into Users (user_id,join_date,favorite_brand) values (3,'2019-01-19','LG');
insert into Users (user_id,join_date,favorite_brand) values (4,'2019-05-21','HP');


insert into Orders (order_id,order_date,item_id,buyer_id,seller_id) values (1,'2019-08-01',4,1,2);
insert into Orders (order_id,order_date,item_id,buyer_id,seller_id) values (2,'2019-08-02',2,1,3);
insert into Orders (order_id,order_date,item_id,buyer_id,seller_id) values (3,'2019-08-03',3,2,3);
insert into Orders (order_id,order_date,item_id,buyer_id,seller_id) values (4,'2019-08-04',1,4,2);
insert into Orders (order_id,order_date,item_id,buyer_id,seller_id) values (5,'2019-08-04',1,3,4);
insert into Orders (order_id,order_date,item_id,buyer_id,seller_id) values (6,'2019-08-05',2,2,4);


insert into Items (item_id,item_brand) values (1,'Samsung');
insert into Items (item_id,item_brand) values (2,'Lenovo');
insert into Items (item_id,item_brand) values (3,'LG');
insert into Items (item_id,item_brand) values (4,'HP');

with 1159_leetcode as (
select
    seller_id,
    selling_date,
    favorite_brand,
    item_brand
from
    (
select
    table_1.seller_id as seller_id,
    selling_date,
    favorite_brand,
    item_id
from
    (
select
    seller_id,
    selling_date,
    favorite_brand
from
    (
select
    seller_id,
    max(order_date) as selling_date
from
    Orders
group by
    seller_id) max_table
left join
    Users
on
    max_table.seller_id = Users.user_id) table_1
left join
    Orders
on
    table_1.seller_id = Orders.seller_id and table_1.selling_date = Orders.order_date) table_2
left join
        Items
on
    table_2.item_id = Items.item_id)
select
    user_id,
    case
        when 1159_leetcode.favorite_brand = item_brand then 'Yes'
    else 'No' end as 2nd_item_fav_brand
from
    1159_leetcode
right join
    Users
on
   1159_leetcode.seller_id =  Users.user_id;