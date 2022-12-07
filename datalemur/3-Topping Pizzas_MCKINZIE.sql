drop database datalemur;
create database datalemur;
use datalemur;

create table pizza_toppings
(
    topping_name varchar(20),
    ingredient_cost  float
);

insert into pizza_toppings values ('Pepperoni',0.50);
insert into pizza_toppings values ('Sausage',0.70);
insert into pizza_toppings values ('Chicken',0.55);
insert into pizza_toppings values ('Extra Cheese',0.40);

select * from pizza_toppings;

select
    CONCAT(p1.topping_name,',',p2.topping_name,',',p3.topping_name) as pizza,
    round((p1.ingredient_cost+p2.ingredient_cost+p3.ingredient_cost),2) as total_cost

from
    pizza_toppings as p1
inner join
    pizza_toppings as p2
on
    p1.topping_name<p2.topping_name
inner join
    pizza_toppings as p3
on
    p2.topping_name < p3.topping_name
order by
    total_cost desc;