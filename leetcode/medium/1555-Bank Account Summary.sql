USE leetcode;
CREATE TABLE UsersName (
  user_id int,
  user_name varchar (100),
  credit int
);

INSERT INTO UsersName
  (user_id, user_name,credit)
VALUES
  (1, 'Moustafa',100),
  (2, 'Jonathan',200),
  (3, 'Winston',10000),
  (4, 'Luis',800);

drop table TransactionsName;
CREATE TABLE TransactionsName (
  trans_id int,
  paid_by int,
  paid_to int,
  amount int,
  transacted_on date
);

INSERT INTO TransactionsName
  (trans_id, paid_by,paid_to,amount,transacted_on)
VALUES
  (1,1,3,400,'2020-08-01'),
  (2,3,2,500,'2020-08-02'),
  (3,2,1,200,'2020-08-03');

select * from UsersName;
select * from TransactionsName;


with 1555_leetcode as (
select
    user_id,
    user_name,
    credit+ifnull(sum(case
        when user_id = paid_by then -amount else amount
    end),0) as final_amount
from
    UsersName
left join
    TransactionsName
on
    UsersName.user_id = TransactionsName.paid_by or UsersName.user_id = TransactionsName.paid_to
group by
    user_id, user_name, credit)
select
    user_id,
    user_name,
    final_amount as credit,
    if(final_amount<0,'Yes','No') as credit_limit_breached
from
    1555_leetcode;



