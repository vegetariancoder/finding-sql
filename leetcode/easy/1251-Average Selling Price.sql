drop table Prices;
Create table If Not Exists Prices (product_id int, price int,start_date date,end_date date);
insert into Prices (product_id, price,start_date,end_date) values (1,5,'2019-02-17','2019-02-28');
insert into Prices (product_id, price,start_date,end_date) values (1,20,'2019-03-01','2019-03-22');
insert into Prices (product_id, price,start_date,end_date) values (2,15,'2019-02-01',' 2019-02-20');
insert into Prices (product_id, price,start_date,end_date) values (2,30,'2019-02-21','2019-03-31');

drop table UnitsSold;
Create table If Not Exists UnitsSold (product_id int, units int, purchase_date date);
insert into UnitsSold (product_id, units,purchase_date) values (1,100,'2019-02-25');
insert into UnitsSold (product_id, units,purchase_date) values (1,15,'2019-03-01');
insert into UnitsSold (product_id, units,purchase_date) values (2,200,'2019-02-10');
insert into UnitsSold (product_id, units,purchase_date) values (2,30,'2019-03-22');


select
    Prices.product_id,
    sum(units*price)/(sum(units)) as average_price
from
    Prices
inner join
   UnitsSold on Prices.product_id = UnitsSold.product_id
where
    purchase_date between start_date and end_date
group by
    Prices.product_id;