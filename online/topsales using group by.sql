use online;
select * from Orders;

with answer as (
select
    Category,
    `Product Name`,
    sum(Sales) as sum_sales,
    rank() over (partition by Category order by sum(Sales) desc) as rnk
from
    Orders
group by
    Category, `Product Name`)
select
    Category,
    `Product Name`,
    round(sum_sales,2) as sum_sales
from
    answer
where
    rnk <=5;