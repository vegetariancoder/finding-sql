use leetcode;
Create table If Not Exists OrdersDetails (order_id int, product_id int, quantity int);
insert into OrdersDetails (order_id,product_id,quantity) value (1,1,12);
insert into OrdersDetails (order_id,product_id,quantity) value (1,2,10);
insert into OrdersDetails (order_id,product_id,quantity) value (1,3,15);
insert into OrdersDetails (order_id,product_id,quantity) value (2,1,8);
insert into OrdersDetails (order_id,product_id,quantity) value (2,4,4);
insert into OrdersDetails (order_id,product_id,quantity) value (2,5,6);
insert into OrdersDetails (order_id,product_id,quantity) value (3,3,5);
insert into OrdersDetails (order_id,product_id,quantity) value (3,4,18);
insert into OrdersDetails (order_id,product_id,quantity) value (4,5,2);
insert into OrdersDetails (order_id,product_id,quantity) value (4,6,8);
insert into OrdersDetails (order_id,product_id,quantity) value (5,7,9);
insert into OrdersDetails (order_id,product_id,quantity) value (5,8,9);
insert into OrdersDetails (order_id,product_id,quantity) value (3,9,20);
insert into OrdersDetails (order_id,product_id,quantity) value (2,9,4);

select * from OrdersDetails;

with main_table as (
select
    order_id,
    avg(quantity) as avg_qty,
    max(quantity) as max_qty
from
    OrdersDetails
group by
    1)
select
    order_id
from
    main_table
where
    max_qty > (select max(avg_qty) from main_table);





