use case_studies;



select * from sales;
select * from product_details;
select * from product_hierarchy;
select * from product_prices;


# What was the total quantity sold for all products?

select
    sum(qty) as total_qty
from
    sales;


# What was the total quantity sold for EACH product?

select
    product_name,
    sum(qty) as total_qty
from
    sales
inner join
    product_details
on
    sales.prod_id=product_details.product_id
group by
    product_name;

#  What is the total generated revenue for all products before discounts?

select
    sum(price*sales.qty) as total_rev
from
    sales;

#  What is the total generated revenue for EACH product before discounts?

select
    product_name,
    sum(qty*sales.price) as total_rev
from
    sales
inner join
    product_details
on
    sales.prod_id=product_details.product_id
group by
    product_name;

# What was the total discount amount for all products?

with answer as (
select
    qty,
    price,
    discount/100 as discount
from
    sales)
select
    round(sum(qty*price*discount),2) dis_amnt
from
    answer;

# What is the total discount for EACH product?

with answer as (
select
    product_details.product_name,
    sales.qty,
    sales.price,
    sales.discount/100 as discount
from
    sales
inner join
    product_details
on
    sales.prod_id=product_details.product_id)
select
    product_name,
    round(sum(qty*price*discount),2) dis_amnt
from
    answer
group by
    product_name;

# How many unique transactions were there?

select
    count(distinct txn_id) as cnt
from
    sales;

# What is the average unique products purchased in each transaction? I believe this is another oddly worded question. I interpret this question to ask "What is the average NUMBER OF unique items purchased per transaction?"

with answer as (
select
    txn_id,
    count(prod_id) as cnt
from
    sales
group by
    txn_id)
select
    round(avg(cnt),0) as avg_product_number
from
    answer;

# What is the average discount value per transaction?

with answer as (
select
    txn_id,
    round(sum(qty*price*discount),2) as avg_discount_amt
from
(
select
    txn_id,
    sales.qty,
    sales.price,
    sales.discount/100 as discount
from
    sales)calc_table
group by
    txn_id)
select
    avg(avg_discount_amt)
from
    answer;

# What is the percentage split of all transactions for members vs non-members?

select
    round(members/(select count(distinct txn_id) from sales)*100,2) as members,
    round(non_members/(select count(distinct txn_id) from sales)*100,2) as non_members
from
    (
select
    1 as id,
    count(distinct txn_id) as members
from
    sales
where
    member='t') as mem_table
inner join
(select
    1 as id,
    count(distinct txn_id) as non_members
from
    sales
where
    member='f') non_mem_table
on
    mem_table.id=non_mem_table.id;

# What is the average revenue for member transactions and non-member transactions?


select
    avg_member,
    avg_non_members
from
    (
select
    1 as id,
    avg(sum_members) as avg_member
from
    (
select
    sum(qty*sales.price) as sum_members
from
    sales
where
    member='t'
group by
    txn_id) member_tb) mem_tb
inner join
(select
    1 as id,
    avg(sum_non_members) as avg_non_members
from
    (
select
    sum(qty*sales.price) as sum_non_members
from
    sales
where
    member='f'
group by
    txn_id) non_member_tb) non_mem_tb
on
    mem_tb.id=non_mem_tb.id;

# What are the top 3 products by total revenue before discount?
with answer as (
select
    product_details.product_name,
    sum(sales.qty*sales.price) as sales,
    dense_rank() over (order by sum(sales.qty*sales.price) desc) as drnk
from
    sales
inner join
    product_details
on
    sales.prod_id=product_details.product_id
group by
    product_details.product_name)
select
    product_name,
    sales
from
    answer
where
    drnk<=3;


# What is the total quantity, revenue and discount for each segment?
select
    segment_name,
    sum(qty) as total_qty,
    sum(sales.price*sales.qty) as total_revenue,
    round(sum(sales.price*sales.qty*(sales.discount/100)),2) as total_discount
from
    sales
inner join
    product_details
on
    sales.prod_id = product_details.product_id
group by
    segment_name
order by
    total_qty desc ;

# What is the top selling product for each segment?

select
    segment_name,
    product_name,
    sum(sales.price*sales.qty) as total_revenue,
    dense_rank() over (partition by segment_name order by sum(sales.price*sales.qty) desc ) as drnk
from
    sales
inner join
    product_details
on
    sales.prod_id = product_details.product_id
group by
    segment_name, product_name;


# What is the top selling product for each segment?


with answer as (
select
    segment_name,
    product_name,
    sum(qty) as total_qty,
    dense_rank() over (partition by segment_name order by sum(qty) desc ) as drnk
from
    sales
inner join
    product_details
on
    sales.prod_id=product_details.product_id
group by
    segment_name, product_name)
select
    segment_name,
    product_name,
    total_qty
from
    answer
where
    drnk=1;

#  What is the total quantity, revenue and discount for each category?

select
    category_name,
    sum(qty) as total_qty,
    sum(sales.price*qty) as total_revenue,
    sum(sales.price*qty*(discount/100)) as total_discount
from
    sales
inner join
    product_details
on
    sales.prod_id=product_details.product_id
group by
    category_name;

#  What is the top selling product for each category?

with answer as (
select
    category_name,
    product_name,
    sum(qty) as total_qty,
    dense_rank() over (partition by category_name order by sum(qty) desc ) as drnk
from
    sales
inner join
    product_details
on
    sales.prod_id=product_details.product_id
group by
    category_name, product_name)
select
    category_name,
    product_name,
    total_qty
from
    answer
where
    drnk=1;


# What is the percentage split of revenue by product for each segment?
with answer as (
select
    segment_name,
    product_name,
    sum(sales.price*sales.qty*(1-sales.discount/100)) as total_rev
from
    sales
inner join
    product_details
on
    sales.prod_id=product_details.product_id
group by
    segment_name, product_name)
select
    segment_name,
    product_name,
    total_rev,
    round(total_rev / (sum(total_rev) over (partition by segment_name)) * 100, 2) as percentage_split
from
    answer
order by
    segment_name;


# What is the percentage split of revenue by segment for each category?

with answer as (
select
    category_name,
    segment_name,
    sum(sales.price*sales.qty*(1-sales.discount/100)) as total_rev
from
    sales
inner join
    product_details
on
    sales.prod_id=product_details.product_id
group by
    category_name, segment_name)
select
    *,
    round(total_rev/(sum(total_rev) over (partition by category_name))*100,2) as perc
from
    answer;

# What is the percentage split of total revenue by category?


with answer as (
select
    category_name,
    sum(sales.price*sales.qty*(1-sales.discount/100)) as total_rev
from
    sales
inner join
    product_details
on
    sales.prod_id=product_details.product_id
group by
    category_name)
select
    category_name,
    total_rev,
    round(total_rev/(select sum(total_rev) from answer) * 100,2) as perc
from
    answer;


