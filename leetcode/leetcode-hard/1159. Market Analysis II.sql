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


select
    calc_table.*,
    favorite_brand
from
    (
select
    *,
    dense_rank() over (partition by seller_id order by order_date) as drnk
from
    Orders) calc_table
inner join
    Users
on
    calc_table.seller_id = Users.user_id
where
    drnk=2;




with fav_brand as (
select
    *,
    dense_rank() over (partition by seller_id order by order_date) as drnk
from
    Orders)
, sold_items as (
select
    fav_brand.*,
    favorite_brand
from
    fav_brand
inner join
    Users
on
    fav_brand.seller_id = Users.user_id
where
    fav_brand.drnk=2)
, main_answer as (
select
    sold_items.*,
    item_brand,
    if(favorite_brand=item_brand,'Yes','No') as 2nd_item_fav_brand
from
    sold_items
inner join
    Items
on
    sold_items.item_id=Items.item_id)
select
    user_id,
    ifnull(2nd_item_fav_brand,'No') as 2nd_item_fav_brand
from
    main_answer
right join
    Users
on
    main_answer.seller_id = Users.user_id;


