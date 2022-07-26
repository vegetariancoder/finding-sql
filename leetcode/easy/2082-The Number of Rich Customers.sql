drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Store (bill_id int, customer_id int, amount int);
insert into Store (bill_id,customer_id,amount) value (6,1,549);
insert into Store (bill_id,customer_id,amount) value (8,1,834);
insert into Store (bill_id,customer_id,amount) value (4,2,394);
insert into Store (bill_id,customer_id,amount) value (11,3,657);
insert into Store (bill_id,customer_id,amount) value (13,3,257);

select
    count(distinct customer_id) as rich_count
from
    Store
where
    amount > 500;