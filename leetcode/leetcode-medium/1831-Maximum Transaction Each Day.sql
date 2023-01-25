use leetcode;
Create table If Not Exists Transactions (transaction_id int, day datetime, amount int);
insert into Transactions (transaction_id,day,amount) value (8,'2021-4-3 15:57:28',57);
insert into Transactions (transaction_id,day,amount) value (9,'2021-4-28 08:47:25',21);
insert into Transactions (transaction_id,day,amount) value (1,'2021-4-29 13:28:30',58);
insert into Transactions (transaction_id,day,amount) value (5,'2021-4-28 16:39:59',40);
insert into Transactions (transaction_id,day,amount) value (6,'2021-4-29 23:39:28',58);


select * from Transactions;

with answer as (
select
    *,
    dense_rank() over (partition by date(day) order by amount desc) as drnk
from
    Transactions)
select
    transaction_id
from
    answer
where
    drnk=1
order by
    transaction_id;