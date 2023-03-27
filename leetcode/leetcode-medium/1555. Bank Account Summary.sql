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



with answer as (
select
    paid_by as user_id,
    remain+paid_to_amount as credit,
    if(remain+paid_to_amount<0,'Yes','No') as credit_limit_breached
from
    (
select
    trans_id,
    paid_by,
    amount,
    transacted_on,
    credit,
    remain,
    paid_to,
    paid_to_amount
from
    (
select
    trans_id,
    paid_by,
    amount,
    transacted_on,
    credit,
    credit-TransactionsName.amount as remain
from
    TransactionsName
inner join
    UsersName
on
    TransactionsName.paid_by = UsersName.user_id) calc_table
inner join
(select
    paid_to,
    amount as paid_to_amount
from
    TransactionsName) paid_to
on
    calc_table.paid_by=paid_to.paid_to) mt)
select
    UsersName.user_id,
    user_name,
    ifnull(answer.credit,UsersName.credit) as credit,
    case
        when answer.credit is null and UsersName.credit>0 then 'No'
        when UsersName.credit < 0 then 'Yes'
    else answer.credit_limit_breached
    end as credit_limit_breached

from
    answer
right join
    UsersName
on
    answer.user_id = UsersName.user_id;




-- formatted
WITH answer
     AS (SELECT paid_by                                      AS user_id,
                remain + paid_to_amount                      AS credit,
                IF(remain + paid_to_amount < 0, 'Yes', 'No') AS
                credit_limit_breached
         FROM   (SELECT trans_id,
                        paid_by,
                        amount,
                        transacted_on,
                        credit,
                        remain,
                        paid_to,
                        paid_to_amount
                 FROM   (SELECT trans_id,
                                paid_by,
                                amount,
                                transacted_on,
                                credit,
                                credit - transactionsname.amount AS remain
                         FROM   transactionsname
                                inner join usersname
                                        ON transactionsname.paid_by =
                                           usersname.user_id)
                        calc_table
                        inner join (SELECT paid_to,
                                           amount AS paid_to_amount
                                    FROM   transactionsname) paid_to
                                ON calc_table.paid_by = paid_to.paid_to) mt)
SELECT usersname.user_id,
       user_name,
       Ifnull(answer.credit, usersname.credit) AS credit,
       CASE
         WHEN answer.credit IS NULL
              AND usersname.credit > 0 THEN 'No'
         WHEN usersname.credit < 0 THEN 'Yes'
         ELSE answer.credit_limit_breached
       END                                     AS credit_limit_breached
FROM   answer
       right join usersname
               ON answer.user_id = usersname.user_id;

