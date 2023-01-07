use case_studies;
select * from members;
select * from sales;
select * from menu;


# What is the total amount each customer spent at the restaurant?

select
    sales.customer_id,
    sum(menu.price) as total_spent
from
    sales
inner join
    menu
on
    sales.product_id=menu.product_id
group by
    sales.customer_id;

# How many days has each customer visited the restaurant?


select
    customer_id,
    count(distinct order_date) as no_of_visits
from
    sales
group by
    customer_id;

# What was the first item from the menu purchased by each customer?


with answer as (
select
    customer_id,
    product_name,
    order_date
from

(select
    distinct product_id,
    customer_id,
    order_date
from
    sales
where
    (customer_id,order_date) in (
select
    customer_id,
    min(order_date) as min_date
from
    sales
group by
    customer_id)) purchase
inner join
(select
     product_id,
     product_name
 from
     menu) as product
on
    purchase.product_id=product.product_id)
select
    customer_id,
    order_date,
    group_concat(product_name) as products_purchase
from
    answer
group by
    customer_id,order_date;


# What is the most purchased item on the menu and how many times was it purchased by all customers?
# What is the most purchased item on the menu


select
    customer_id,
    count(product_id) as cnt
from
    sales
where
    product_id in (
select
    product_id
from
    (
select
    product_id,
    dense_rank() over (order by cnt desc) as rnk
from
    (
select
    product_id,
    count(*) as cnt
from
    sales
group by
    product_id) calc_table) calc_table_2
where
    rnk=1)
group by
    customer_id;


# Which item was the most popular for each customer?

with answer as (
select
    customer_id,
    product_id,
    dense_rank() over (partition by customer_id order by cnt desc ) as drnk
from(
select
    customer_id,
    product_id,
    count(*) as cnt
from
    sales
group by
    customer_id, product_id)calc_table)
select
    customer_id,
    group_concat(product_name)
from
    answer
inner join
    menu
on
    answer.product_id=menu.product_id
where
    drnk=1
group by
    customer_id;

# Which item was purchased first by the customer after they became a member?

with answer as (
select
    sales.customer_id,
    sales.order_date,
    sales.product_id,
    members.join_date
from
    sales
inner join
    members
on
    sales.customer_id=members.customer_id)
select
    *,
    datediff(order_date,join_date) as diff
from
    answer;


select
    customer_id,
    product_id,
    order_date
from
    sales
where
    (customer_id,order_date) in (
with answer as (
select
    sales.customer_id,
    sales.order_date,
    sales.product_id,
    members.join_date
from
    sales
inner join
    members
on
    sales.customer_id=members.customer_id)
select
    customer_id,
    min(order_date) as min_date
from
    answer
where
    datediff(order_date,join_date)>=0
group by
    customer_id);


# Which item was purchased just before the customer became a member?

select
    customer_id,
    product_id,
    order_date
from
    sales
where
    (customer_id,order_date) in (
with answer as (
select
    sales.customer_id,
    sales.order_date,
    sales.product_id,
    members.join_date
from
    sales
inner join
    members
on
    sales.customer_id=members.customer_id)
select
    customer_id,
    max(order_date) as min_date
from
    answer
where
    datediff(order_date,join_date) < 0
group by
    customer_id);


# What is the total items and amount spent for each member before they became a member?


with answer as (
select
    *,
    datediff(order_date,join_date) as diff
from
    (
select
    sales.customer_id,
    sales.order_date,
    sales.product_id,
    members.join_date,
    menu.price
from
    sales
inner join
    members
on
    sales.customer_id=members.customer_id
inner join
    menu
on
    sales.product_id=menu.product_id)calc_table)
select
    customer_id,
    count(product_id) as total_prodcuts,
    sum(price) as total_price
from
    answer
where
    diff < 0
group by
    customer_id;

# If each $1 spent equates to 10 points and sushi has a 2x points multiplier — how many points would each customer have?

with answer as (
select
    *,
    price*points as totalpoints
from(
select
    *,
    case
        when product_name='sushi' then 20 else 10
    end as points
from
    menu)calc_table)
select
    customer_id,
    sum(totalpoints) as total_points
from
    answer
inner join
    sales
on
    answer.product_id=sales.product_id
group by
    customer_id;












