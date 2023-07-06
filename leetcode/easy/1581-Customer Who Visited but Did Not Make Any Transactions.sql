drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Visits(visit_id int, customer_id int);
Create table If Not Exists Transactions(transaction_id int, visit_id int, amount int);
Truncate table Visits;
insert into Visits (visit_id, customer_id) values ('1', '23');
insert into Visits (visit_id, customer_id) values ('2', '9');
insert into Visits (visit_id, customer_id) values ('4', '30');
insert into Visits (visit_id, customer_id) values ('5', '54');
insert into Visits (visit_id, customer_id) values ('6', '96');
insert into Visits (visit_id, customer_id) values ('7', '54');
insert into Visits (visit_id, customer_id) values ('8', '54');
Truncate table Transactions;
insert into Transactions (transaction_id, visit_id, amount) values ('2', '5', '310');
insert into Transactions (transaction_id, visit_id, amount) values ('3', '5', '300');
insert into Transactions (transaction_id, visit_id, amount) values ('9', '5', '200');
insert into Transactions (transaction_id, visit_id, amount) values ('12', '1', '910');
insert into Transactions (transaction_id, visit_id, amount) values ('13', '2', '970');

with 1581_leetcode as (
select
    visit_table.customer_id,
    visit_table.cnt_visit-ifnull(transaction_table.cnt_transaction,0) as count_no_trans
from
    (
select
    customer_id,
    count(visit_id) as cnt_visit
from
    Visits
group by
    customer_id)visit_table
left join
(select
    customer_id,
    count(distinct T.visit_id) cnt_transaction
from
    Transactions T
inner join
    Visits V on T.visit_id = V.visit_id
group by
    customer_id) transaction_table
on
    visit_table.customer_id = transaction_table.customer_id)
select
    customer_id,
    count_no_trans
from
    1581_leetcode
where
    count_no_trans > 0;



with answer as (
select
    visit.customer_id,
    visit_count,
    trans_count
from
    (
select
    customer_id,
    count(visit_id) as visit_count
from
    Visits
group by
    customer_id) visit
left join
(select
    customer_id,
    count(distinct Visits.visit_id) as trans_count
from
    Transactions
inner join
    Visits
on
    Transactions.visit_id = Visits.visit_id
group by
    customer_id) trans
on
    visit.customer_id = trans.customer_id)
, main_answer as (
select
    customer_id,
    visit_count-ifnull(trans_count,0) as count_no_trans
from
    answer)
select
    *
from
    main_answer
where
    count_no_trans !=0
order by
    count_no_trans desc ;
























