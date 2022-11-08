drop database online;
create database online;
use online;

CREATE TABLE Order_Tbl(
 ORDER_DAY date,
 ORDER_ID varchar(10) ,
 PRODUCT_ID varchar(10) ,
 QUANTITY int ,
 PRICE int
);

INSERT INTO Order_Tbl  VALUES ('2015-05-01','ODR1', 'PROD1', 5, 5);
INSERT INTO Order_Tbl  VALUES ('2015-05-01','ODR2', 'PROD2', 2, 10);
INSERT INTO Order_Tbl  VALUES ('2015-05-01','ODR3', 'PROD3', 10, 25);
INSERT INTO Order_Tbl  VALUES ('2015-05-01','ODR4', 'PROD1', 20, 5);
INSERT INTO Order_Tbl  VALUES ('2015-05-02','ODR5', 'PROD3', 5, 25);
INSERT INTO Order_Tbl  VALUES ('2015-05-02','ODR6', 'PROD4', 6, 20);
INSERT INTO Order_Tbl  VALUES ('2015-05-02','ODR7', 'PROD1', 2, 5);
INSERT INTO Order_Tbl  VALUES ('2015-05-02','ODR8', 'PROD5', 1, 50);
INSERT INTO Order_Tbl  VALUES ('2015-05-02','ODR9', 'PROD6', 2, 50);
INSERT INTO Order_Tbl  VALUES ('2015-05-02','ODR10','PROD2', 4, 10);






select
    PRODUCT_ID,
    count(*) as count_values
from
    Order_Tbl
where
    PRODUCT_ID in (select PRODUCT_ID from Order_Tbl where ORDER_DAY='2015-05-01')
group by
    PRODUCT_ID;



select
    PRODUCT_ID,
    count(count_values) as count_values
from
     (
select
    PRODUCT_ID,
    count(*) as count_values
from
    Order_Tbl
where
    ORDER_DAY='2015-05-01'
group by
    PRODUCT_ID
union all
select
    PRODUCT_ID,
    count(*) as count_values
from
    Order_Tbl
where
    ORDER_DAY='2015-05-02' and PRODUCT_ID in (select PRODUCT_ID from Order_Tbl where ORDER_DAY = '2015-05-01')
group by
    PRODUCT_ID) mt
group by
    PRODUCT_ID;


select
    PRODUCT_ID,
    count(PRODUCT_ID) as count_values
from
    Order_Tbl
group by
    PRODUCT_ID
having
    count(distinct ORDER_DAY)>1;


select * from Order_Tbl;

select
    PRODUCT_ID
from
    Order_Tbl
where
    PRODUCT_ID not in (select PRODUCT_ID from Order_Tbl where ORDER_DAY='2015-05-01');


select
    right_table.PRODUCT_ID
from
    (
select
    PRODUCT_ID
from
    Order_Tbl
where
    ORDER_DAY='2015-05-01')left_table
right join
(select
    PRODUCT_ID
from
    Order_Tbl
where
    ORDER_DAY='2015-05-02')right_table
on
    left_table.PRODUCT_ID = right_table.PRODUCT_ID
where
    left_table.PRODUCT_ID is null;

