drop database online;
create database online;
use online;

create table customer
(
    customer_id         int,
    customer_name    varchar(100)
);

insert into customer values (1,'w');
insert into customer values (2,'j');
insert into customer values (3,'a');
insert into customer values (4,'m');
insert into customer values (5,'k');

create table product
(
    order_id         int,
    order_date    date,
    customer_id int,
    cost int
);

insert into product values (1,'2020-07-31',1,30);
insert into product values (2,'2020-07-30',2,40);
insert into product values (3,'2020-07-31',3,70);
insert into product values (4,'2020-07-29',4,100);
insert into product values (5,'2020-06-10',1,1010);
insert into product values (6,'2020-08-01',2,102);
insert into product values (7,'2020-08-01',3,111);
insert into product values (8,'2020-08-03',1,99);
insert into product values (9,'2020-08-07',2,32);
insert into product values (10,'2020-07-15',1,2);

select * from customer;
select * from product;

with cte as (
select
    product.*,
    customer.customer_name,
    sum(cost) over (partition by customer_name order by cost) as sm
from
    customer
inner join
    product  
on 
    customer.customer_id = product.customer_id
where
    order_date between '2020-07-01' AND '2020-08-30')
select
    customer_name,
    count(order_id) as cnt,
    max(sm) as total_amount
from
    cte
group by
    customer_name
having
    max(sm)>100;