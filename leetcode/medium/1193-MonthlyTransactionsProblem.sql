use leetcode;
Create table If Not Exists Transactions (id int, country varchar(100), state varchar(100), amount int, trans_date date);
insert into Transactions (id,country,state,amount,trans_date) value (121,'US','approved',1000,'2018-12-18');
insert into Transactions (id,country,state,amount,trans_date) value (122,'US','declined',2000,'2018-12-19');
insert into Transactions (id,country,state,amount,trans_date) value (123,'US','approved',2000,'2019-01-01');
insert into Transactions (id,country,state,amount,trans_date) value (124,'DE','approved',2000,'2019-01-07');



select
    DATE_FORMAT(trans_date, "%Y-%m") as month,
    country,
    count(id) as trans_count,
    sum(case
        when state = 'approved' then 1 else 0
    end) as approved_count,
    sum(amount) as trans_total_amount,
    sum(case
        when state = 'approved' then amount else 0
    end) as approved_total_amount
from
    Transactions
group by
    month,country;



# second solution



select
    DATE_FORMAT(trans_date, "%Y-%m") as month,
    country,
    count(id) as trans_count,
    sum(if(state='approved',1,0)) as approved_count,
    sum(amount) as trans_total_amount,
    sum(if(state='approved',amount,0)) as approved_total_amount
from
    Transactions
group by
    month,country;

