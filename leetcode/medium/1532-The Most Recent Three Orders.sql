use leetcode;
Create table If Not Exists Customers (customer_id int,name varchar(100));
insert into Customers (customer_id,name) value (1,'Winston');
insert into Customers (customer_id,name) value (2,'Jonathan');
insert into Customers (customer_id,name) value (3,'Annabelle');
insert into Customers (customer_id,name) value (4,'Marwan');
insert into Customers (customer_id,name) value (5,'Khaled');


Create table If Not Exists Orders (order_id int,order_date date, customer_id int,cost int);
insert into Orders (order_id,order_date,customer_id,cost) value (1,'2020-07-31',1,30);
insert into Orders (order_id,order_date,customer_id,cost) value (2,'2020-07-30',2,40);
insert into Orders (order_id,order_date,customer_id,cost) value (3,'2020-07-31',3,70);
insert into Orders (order_id,order_date,customer_id,cost) value (4,'2020-07-29',4,100);
insert into Orders (order_id,order_date,customer_id,cost) value (5,'2020-06-10',1,1010);
insert into Orders (order_id,order_date,customer_id,cost) value (6,'2020-08-01',2,102);
insert into Orders (order_id,order_date,customer_id,cost) value (7,'2020-08-01',3,111);
insert into Orders (order_id,order_date,customer_id,cost) value (8,'2020-08-03',1,99);
insert into Orders (order_id,order_date,customer_id,cost) value (9,'2020-08-07',2,32);
insert into Orders (order_id,order_date,customer_id,cost) value (10,'2020-07-15',1,2);



with 1532_leetcode as (
select
    Orders.customer_id,
    order_id,
    order_date,
    name,
    dense_rank() over (partition by Orders.customer_id order by order_date desc) as drnks
from
    Orders
left join
    Customers C on Orders.customer_id = C.customer_id)
select
    name as customer_name,
    customer_id,
    order_id,
    order_date
from
    1532_leetcode
where
    drnks <=3
order by
    name;




