drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Elements (symbol varchar(100),type_value varchar(100), electrons int);
insert into Elements (symbol,type_value,electrons) value ('He','Noble',0);
insert into Elements (symbol,type_value,electrons) value ('Na','Metal',1);
insert into Elements (symbol,type_value,electrons) value ('Ca','Metal',2);
insert into Elements (symbol,type_value,electrons) value ('La','Metal',3);
insert into Elements (symbol,type_value,electrons) value ('Cl','Nonmetal',1);
insert into Elements (symbol,type_value,electrons) value ('O','Nonmetal',2);
insert into Elements (symbol,type_value,electrons) value ('N' ,'Nonmetal',3);

select * from Elements;

select
    metal,
    nonmetal
from
    (
select
    symbol as metal
from
    Elements
where
    type_value='Metal')metal_table
cross join
(select
    symbol as nonmetal
from
    Elements
where
    type_value='Nonmetal')nonmetal_table;

