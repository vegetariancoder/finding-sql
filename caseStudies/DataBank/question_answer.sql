use case_studies;
select * from customer_nodes;
select * from customer_transactions;
select * from regions;


# What is the number of nodes per region?

select
    region_name,
    count(distinct node_id) as cnt
from
    customer_nodes
inner join
    regions
on
    customer_nodes.region_id=regions.region_id
group by
    region_name;

# How many customers are allocated to each region?


select
    region_name,
    count(distinct customer_id) as cnt
from
    customer_nodes
inner join
    regions
on
    customer_nodes.region_id=regions.region_id
group by
    region_name;

# How many days on average are customers reallocated to a different node?

with answer as (
select
    *,
    lag(node_id) over (partition by customer_id order by start_date ) as prev_node
from
    customer_nodes
WHERE
		EXTRACT(YEAR FROM end_date) != '9999'
ORDER BY
		customer_id,
		start_date)
select
    avg(end_date-start_date) as rounded
from
    answer
where
    node_id != prev_node;

# What is the unique count and total amount for each transaction type?

select
    txn_type,
    count(*),
    sum(txn_amount) as txn_amt
from
    customer_transactions
group by
    txn_type;


# What is the average total historical deposit counts and amounts for all customers?

with answer as (
select
    customer_id,
    count(*) as cnt,
    sum(txn_amount) as amnt
from
    customer_transactions
where
    txn_type='deposit'
group by
    customer_id)
select
    avg(cnt) as avg_historical_cnt,
    avg(amnt) as avg_historical_sum_amnt
from
    answer;



# For each month - how many Data Bank customers make more than 1 deposit and either 1 purchase or 1 withdrawal in a single month?


with answer as (
select
    customer_id,
    extract(month from txn_date) as month_value,
    sum(case
        when txn_type='deposit' then 1 else 0
    end) as sum_deposit,
    sum(case
        when txn_type='purchase' then 1 else 0
    end) as sum_purchase,
    sum(case
        when txn_type='withdrawal' then 1 else 0
    end) as sum_withdrawal
from
    customer_transactions
group by
    customer_id, extract(month from txn_date)
order by
    customer_id)
select
    month_value,
    count(customer_id) as cnt
from
    answer
where
    sum_deposit>1 and (sum_purchase>=1 or sum_withdrawal>=1)
group by
    month_value;



# What is the closing balance for each customer at the end of the month?

with answer as (
select
    *,
    month(txn_date) as month_value,
    sum(case
        when txn_type='deposit' then txn_amount else -txn_amount
    end) over (partition by customer_id order by txn_date) as closing_amt,
    dense_rank() over (partition by customer_id,month(txn_date) order by txn_date desc ) as drnk
from
    customer_transactions
order by
    customer_id,txn_date)
select
    customer_id,
    month_value,
    closing_amt
from
    answer
where
    drnk=1;





