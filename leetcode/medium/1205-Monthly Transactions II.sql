drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Transactions (id int, country varchar (100), state varchar (100), amount int, trans_date date);
insert into Transactions (id,country,state,amount,trans_date) value (101,'US','approved',1000,'2019-05-18');
insert into Transactions (id,country,state,amount,trans_date) value (102,'US','declined',2000,'2019-05-19');
insert into Transactions (id,country,state,amount,trans_date) value (103,'US','approved',3000,'2019-06-10');
insert into Transactions (id,country,state,amount,trans_date) value (104,'US','declined',4000,'2019-06-13');
insert into Transactions (id,country,state,amount,trans_date) value (105,'US','approved',5000,'2019-06-15');

Create table If Not Exists Chargebacks (trans_id int, trans_date date);
insert into Chargebacks (trans_id,trans_date) value (102,'2019-05-29');
insert into Chargebacks (trans_id,trans_date) value (101,'2019-06-30');
insert into Chargebacks (trans_id,trans_date) value (105,'2019-09-18');


select
    table2.month_values,
    table2.country,
    ifnull(table1.approved_count,0) as approved_count,
    ifnull(table1.approved_amount,0) as approved_amount,
    table2.chargeback_count,
    table2.chargeback_amount
from
    (
select
    date_format(trans_date,'%Y-%m') as month_values,
    country,
    count(state) as approved_count,
    sum(amount) as approved_amount
from
    Transactions
where
    state='approved'
group by
    month_values,country) table1
right join
(select
    trans_id,
    date_format(Chargebacks.trans_date,'%Y-%m') as month_values,
    amount as chargeback_amount,
    country,
    count(distinct trans_id) as chargeback_count
from
    Chargebacks
left join
    Transactions T on Chargebacks.trans_id = T.id
group by
    trans_id, month_values, amount,country) table2
on
    table1.month_values = table2.month_values;