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



select * from Order_Tbl;

select
    ORDER_DAY,
    PRODUCT_ID
from
    Order_Tbl
group by
    ORDER_DAY,PRODUCT_ID
having
    count(PRODUCT_ID) > 1;