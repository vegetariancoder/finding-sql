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
    chargeback_month,
    ifnull(country,'US') as country,
    ifnull(approved_count,0) as approved_count,
    ifnull(approved_amount,0) as approved_amount,
    chargeback_count,
    chargeback_amount
from
    (
select
    substring(Chargebacks.trans_date,1,7) as chargeback_month,
    amount as chargeback_amount,
    count(trans_id) as chargeback_count
from
    Chargebacks
inner join
    Transactions
on
    Chargebacks.trans_id=Transactions.id
group by
    chargeback_month,amount) chargeback
left join
(select
    substring(trans_date,1,7) as month,
    country,
    count(id) as approved_count,
    sum(amount) as approved_amount
from
    Transactions
group by
    month,country) trans
on
    chargeback.chargeback_month=trans.month;