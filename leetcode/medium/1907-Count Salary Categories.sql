use leetcode;
Create table If Not Exists Accounts (account_id int, income int);
insert into Accounts (account_id,income) value (3,108939);
insert into Accounts (account_id,income) value (2,12747);
insert into Accounts (account_id,income) value (8,87709);
insert into Accounts (account_id,income) value (6,91796);


select
    salary_known,
    count(salary_type)
from
    (select
    'Low Salary' as salary_known
union all
select
    'Average Salary' as salary_known
union all
select
    'High Salary' as salary_known) sample_table
left join
(select
    case
        when income < 20000 then 'Low Salary'
        when income >= 20000 and income < 50000 then 'Average Salary'
        when income >=50000 then 'High Salary'
    end as salary_type
from
    Accounts) calc_table
on
    sample_table.salary_known = calc_table.salary_type
group by
    salary_known;