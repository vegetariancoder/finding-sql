drop database datalemur;
create database datalemur;
use datalemur;


Create table If Not Exists purchases (user_id int, product_id varchar(100), quantity int, purchase_date date);
insert into purchases (user_id, product_id,quantity,purchase_date) values (536,3223,6,'2022-01-11');
insert into purchases (user_id, product_id,quantity,purchase_date) values (827,3585,35,'2022-02-20');
insert into purchases (user_id, product_id,quantity,purchase_date) values (536,3223,5,'2022-03-02');
insert into purchases (user_id, product_id,quantity,purchase_date) values (536,1435,10,'2022-03-02');
insert into purchases (user_id, product_id,quantity,purchase_date) values (827,2452,45,'2022-04-09');

select  * from purchases;

with answer as (
select
    user_id,
    product_id,
    purchase_date,
    lead(product_id) over (partition by user_id order by product_id) as next_product,
    lead(purchase_date) over (partition by user_id order by product_id) as next_date
from
    purchases)
select
    user_id
from
    answer
where
    product_id=next_product and date_add(purchase_date,interval 2 day ) != next_date;


select
    distinct p1.user_id
from
    purchases p1 join purchases p2
on
   p1.product_id=p2.product_id and date(p1.purchase_date) <> date(p2.purchase_date);




 SELECT
    user_id,
    RANK() OVER (
      PARTITION BY user_id, product_id
      ORDER BY DATE(purchase_date) ASC) AS purchase_no
  FROM purchases;