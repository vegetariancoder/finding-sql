select * from pizza_names;
select * from pizza_recipes;
select * from pizza_toppings;
select * from runner_orders;
select * from runners;
select * from customer_orders;



--How many pizzas were ordered?

select
    count(pizza_id) as cnt
from
    customer_orders;

--  How many unique customer orders were made?

select
    count(distinct order_id) as distinct_orders
from
    customer_orders;

-- How many successful orders were delivered by each runner?

select
    runner_id,
    count(*)
from
    runner_orders
where
    cancellation is  null
group by
    runner_id;

-- How many of each type of pizza was delivered?

select
    pizza_name,
    count(*) as cnt
from
    customer_orders
inner join
    pizza_names
on
    customer_orders.pizza_id = pizza_names.pizza_id
group by
    pizza_name;

-- How many Vegetarian and Meatlovers were ordered by each customer?


select
    customer_id,
    pizza_id,
    count(*) as cnt
from
    customer_orders
group by
    customer_id, pizza_id
order by
    customer_id,pizza_id;

-- What was the maximum number of pizzas delivered in a single order?



with answer as (
select
    customer_orders.order_id,
    count(pizza_id) as cnt,
    dense_rank() over (order by count(pizza_id) desc ) as drnk
from
    customer_orders
inner join
    runner_orders
on
    customer_orders.order_id=runner_orders.order_id
where
    cancellation is null
group by
    customer_orders.order_id)
select
    order_id,
    cnt
from
    answer
where
    drnk=1;

-- For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

with answer as (
select
    customer_id,
    case
        when exclusions is not null or extras is not null then 1 else 0
    end as at_least_1_changes_in_order,
    case
        when exclusions is null and extras is null then 1 else 0
    end as no_changes_in_order
from
    customer_orders
inner join
    runner_orders
on
    customer_orders.order_id=runner_orders.order_id
where
    cancellation is null)
select
    customer_id,
    sum(at_least_1_changes_in_order) as at_least_1_changes_in_order,
    sum(no_changes_in_order) as no_changes_in_order
from
    answer
group by
    customer_id;

-- How many pizzas were delivered that had both exclusions and extras?


select
    count(customer_orders.order_id) as cnt
from
    customer_orders
inner join
    runner_orders
on
    customer_orders.order_id=runner_orders.order_id
where
    cancellation is null
and
    exclusions is not null and extras is not null;


-- What was the total volume of pizzas ordered for each hour of the day?

select
    order_time,
    extract(hour from order_time) as hours,
    count(order_id) as cnt
from
    customer_orders
group by
    order_time,hours;





