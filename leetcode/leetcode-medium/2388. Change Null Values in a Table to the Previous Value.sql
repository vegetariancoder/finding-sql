drop database leetcode;
create database leetcode;
use leetcode;


CREATE TABLE IF NOT EXISTS CoffeeShop (
    id INT,
    drink varchar(100));

insert into CoffeeShop (id,drink) values (9,'Mezcal Margarita');
insert into CoffeeShop (id,drink) values (6,null);
insert into CoffeeShop (id,drink) values (7,null);
insert into CoffeeShop (id,drink) values (3,'Americano');
insert into CoffeeShop (id,drink) values (1,'Daiquiri');
insert into CoffeeShop (id,drink) values (2,null);

select * from CoffeeShop;


with answer as (
select
    id,
    drink,
    count(drink) over (order by id desc ) as testing
from
    CoffeeShop)
select
    id,
    first_value(drink) over (partition by testing) as drink
from
    answer;
