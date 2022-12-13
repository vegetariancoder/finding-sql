drop database datalemur;
create database datalemur;
use datalemur;

Create table If Not Exists customer_contracts (customer_id int, product_id varchar(100), amount varchar(100));
insert into customer_contracts (customer_id, product_id, amount) values (1,1,1000);
insert into customer_contracts (customer_id, product_id, amount) values (1,3,1000);
insert into customer_contracts (customer_id, product_id, amount) values (1,5,1000);
insert into customer_contracts (customer_id, product_id, amount) values (2,2,1000);
insert into customer_contracts (customer_id, product_id, amount) values (2,6,1000);

Create table If Not Exists products (product_id int, product_category varchar(100), product_name varchar(100));
insert into products (product_id, product_category, product_name) values (1,'Analytics','Azure Databricks');
insert into products (product_id, product_category, product_name) values (2,'Analytics','Azure Stream Analytics');
insert into products (product_id, product_category, product_name) values (3,'Containers','Azure Kubernetes');
insert into products (product_id, product_category, product_name) values (4,'Containers','Azure Service Fabric');
insert into products (product_id, product_category, product_name) values (5,'Compute','Azure Machines');
insert into products (product_id, product_category, product_name) values (6,'Compute','Azure Functions');


select * from customer_contracts;
select * from products;

with answer as (
select
    customer_id
from
    customer_contracts
inner join
    products
on
    customer_contracts.product_id=products.product_id
where
    product_category='Analytics'
union all
select
    customer_id
from
    customer_contracts
inner join
    products
on
    customer_contracts.product_id=products.product_id
where
    product_category='Containers'
union all
select
    customer_id
from
    customer_contracts
inner join
    products
on
    customer_contracts.product_id=products.product_id
where
    product_category='Compute')
select
    customer_id
from
    answer
group by
    customer_id
having
    count(*) =3;

with answer as (
select
    customer_id,
    count(distinct product_category) as counting
from
    customer_contracts
left join
    products on customer_contracts.product_id = products.product_id
group by
    customer_id)
select
    customer_id
from
    answer
where
    counting=3;