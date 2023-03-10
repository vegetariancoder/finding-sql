drop database leetcode;
create database leetcode;
use leetcode;

Create table If Not Exists Delivery (delivery_id int, customer_id varchar(100), order_date date, customer_pref_delivery_date date);
insert into Delivery (delivery_id,customer_id,order_date,customer_pref_delivery_date) value (1,1,'2019-08-01','2019-08-02');
insert into Delivery (delivery_id,customer_id,order_date,customer_pref_delivery_date) value (2,2,'2019-08-02','2019-08-02');
insert into Delivery (delivery_id,customer_id,order_date,customer_pref_delivery_date) value (3,1,'2019-08-11','2019-08-12');
insert into Delivery (delivery_id,customer_id,order_date,customer_pref_delivery_date)value (4,3,'2019-08-24','2019-08-24');
insert into Delivery (delivery_id,customer_id,order_date,customer_pref_delivery_date) value (5,3,'2019-08-21','2019-08-22');
insert into Delivery (delivery_id,customer_id,order_date,customer_pref_delivery_date) value (6,2,'2019-08-11','2019-08-13');
insert into Delivery (delivery_id,customer_id,order_date,customer_pref_delivery_date) value (7,4,'2019-08-09','2019-08-09');


select * from Delivery;


with answer as (
select
    *,
    if(order_date=customer_pref_delivery_date,'Yes','No') as checks
from
    (
select
    *
from
    Delivery
where
    (customer_id,order_date) in (
select
    customer_id,
    min(order_date) min_date
from
    Delivery
group by
    customer_id))calc_table)
select
    round(count(customer_id)/(select count(customer_id) from answer)*100,2) as immediate_percentage
from
    answer
where
    checks='Yes';