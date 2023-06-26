use credit_card;

select * from creditcard;

with first_question as (
select
    *,
    substring_index(City, ', ', 1) as cityname,
    substring_index(City, ', ', -1) as country
from
    creditcard)
select
    cityname,
    sum(Amount) as sum_amt,
    sum(Amount)/(select sum(Amount) from first_question) * 100 as percent
from
    first_question
group by
    cityname
order by
    sum_amt desc
limit 5;


with second_question as (
select
    *,
    substring_index(substring_index(Date, '-', 2),'-',-1) as month_value
from
    creditcard)
, highest_spend_month as (
select
    month_value,
    sum(Amount) as total_amt
from
    second_question
group by
    month_value
order by
    total_amt desc
limit 1)
select
    month_value,
    CardType,
    sum(Amount) as total_amount
from
    second_question
where
    month_value = (select month_value from highest_spend_month)
group by
    month_value,CardType;




with third_question as (
select
    *,
    substring_index(City, ', ', 1) as cityname,
    substring_index(City, ', ', -1) as country,
    sum(Amount) over (partition by CardType order by Amount) as sm
from
    creditcard),
answer as (
select
    *,
    dense_rank() over (partition by CardType order by sm desc ) as drnk
from
    third_question
where
    sm < 1000000)
select
    *
from
    answer
where
    drnk=1;



with fourth_question as (
select
    *,
    substring_index(City, ', ', 1) as cityname,
    substring_index(City, ', ', -1) as country,
    dense_rank() over (order by Amount) as drnk,
    (select sum(Amount) from creditcard) as total
from
    creditcard
where
    CardType='Gold')
select
    *,
    Amount/total * 10000 as percent
from
    fourth_question
where
    drnk=1;



with fifth_question as (
select
    *,
    substring_index(City, ', ', 1) as cityname,
    substring_index(City, ', ', -1) as country
from
    creditcard),
expense as (
select
    cityname,
    max(Amount) as highest,
    min(Amount) as lowest
from
    fifth_question
group by
    cityname),
highest_expense as (
select
    cityname,
    ExpType as highest_expense_type
from
    fifth_question
where
    (cityname,Amount) in (select cityname, highest from expense)),
lowest_expense as (
select
    cityname,
    ExpType as lowest_expense_type
from
    fifth_question
where
    (cityname,Amount) in (select cityname, lowest from expense))
select
    highest_expense.cityname,
    highest_expense_type,
    lowest_expense_type
from
    highest_expense
inner join
    lowest_expense
on
    highest_expense.cityname = lowest_expense.cityname;



select
    Gender,
    ExpType,
    sum(Amount)/(select sum(Amount) from creditcard) * 100 as percent
from
    creditcard
where
    Gender='F'
group by
    Gender, ExpType;

with seventh_question as (
select
    *,
    substring_index(substring_index(Date, '-', 2),'-',-1) as month_value,
    substring_index(substring_index(Date, '-', 3),'-',-1) as year_value
from
    creditcard)
select
    month_value,
    ExpType,
    sum(Amount) as amnt
from
    seventh_question
where
    year_value=14
group by
    month_value, ExpType
order by
    amnt;









