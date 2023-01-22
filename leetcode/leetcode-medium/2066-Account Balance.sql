drop database leetcode;
create database leetcode;
use leetcode;

CREATE TABLE Transactions (
  account_id int,
  dayvalue date,
  type varchar(100),
  amount int
);

INSERT into Transactions values (1,'2021-11-07','Deposit',2000),
                                (1,'2021-11-09','Withdraw',1000),
                                (1,'2021-11-11','Deposit',3000),
                                (2,'2021-11-07','Deposit',7000),
                                (2,'2021-11-12','Withdraw',7000);


select
    *
from
    Transactions;


select
    account_id,
    dayvalue,
    sum(case when type = 'Deposit' then amount else -amount end ) over (partition by account_id order by dayvalue) as balance
from
    Transactions;