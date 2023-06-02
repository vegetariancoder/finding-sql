create database leetcode;
use leetcode;

-- Create the Transactions table
CREATE TABLE Transactions (
  transaction_id INT,
  customer_id INT,
  transaction_date DATE,
  amount DECIMAL(10, 2)
);

-- Insert the data into the Transactions table
INSERT INTO Transactions (transaction_id, customer_id, transaction_date, amount)
VALUES
  (1, 101, '2023-05-01', 100),
  (2, 101, '2023-05-02', 150),
  (3, 101, '2023-05-03', 200),
  (4, 102, '2023-05-01', 50),
  (5, 102, '2023-05-03', 100),
  (6, 102, '2023-05-04', 200),
  (7, 105, '2023-05-01', 100),
  (8, 105, '2023-05-02', 150),
  (9, 105, '2023-05-03', 200),
  (10, 105, '2023-05-04', 300),
  (11, 105, '2023-05-12', 250),
  (12, 105, '2023-05-13', 260),
  (13, 105, '2023-05-14', 270);

select * from Transactions;

with checking as (
select
    customer_id,
    transaction_date,
    day(transaction_date)-rno as keyvalue
from
    (
select
    *,
    row_number() over (partition by customer_id order by transaction_date) as rno
from
    Transactions) calc),
main_answer as (
select
    *,
    count(keyvalue) over (partition by customer_id,keyvalue) as clearcut
from
    checking)
select
    customer_id,
    min(transaction_date) as consecutive_start,
    max(transaction_date) as consecutive_end
from
    main_answer
where
    clearcut>=3
group by
    customer_id,keyvalue;


