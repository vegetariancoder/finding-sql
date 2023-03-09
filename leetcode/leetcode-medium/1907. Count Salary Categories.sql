use leetcode;
Create table If Not Exists Accounts (account_id int, income int);
insert into Accounts (account_id,income) value (3,108939);
insert into Accounts (account_id,income) value (2,12747);
insert into Accounts (account_id,income) value (8,87709);
insert into Accounts (account_id,income) value (6,91796);

with category_table as (
select
    'Low Salary' as category
union
select
    'Average Salary' as category
union
select
    'High Salary' as category)
, calculated_table as (select
    bucket,
    count(*) as accounts_count
from
    (
select
    account_id,
    income,
    case
        when income < 20000 then 'Low Salary'
        when income between 20000 and 50000 then 'Average Salary'
        when income > 50000 then 'High Salary'
    end as bucket
from
    Accounts) calc_table
group by
    bucket)
select
    category,
    ifnull(accounts_count,0) as accounts_count
from
    category_table
left join
    calculated_table
on
    category_table.category = calculated_table.bucket;