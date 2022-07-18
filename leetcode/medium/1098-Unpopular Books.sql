drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Books (book_id int, name varchar (100), available_from date);
insert into Books (book_id,name,available_from) value (1,'Kalila And Demna', '2010-01-01');
insert into Books (book_id,name,available_from) value (2,'28 Letters', '2012-05-12');
insert into Books (book_id,name,available_from) value (3,'The Hobbit', '2019-06-10');
insert into Books (book_id,name,available_from) value (4,'13 Reasons Why', '2019-06-01');
insert into Books (book_id,name,available_from) value (5,'The Hunger Games', '2008-09-21');



Create table If Not Exists Orders (order_id int, book_id int, quantity int, dispatch_date date );
insert into Orders (order_id,book_id,quantity,dispatch_date) value (1,1,2,'2018-07-26');
insert into Orders (order_id,book_id,quantity,dispatch_date) value (2,1,1,'2018-11-05');
insert into Orders (order_id,book_id,quantity,dispatch_date) value (3,3,8,'2019-06-11');
insert into Orders (order_id,book_id,quantity,dispatch_date) value (4,4,6,'2019-06-05');
insert into Orders (order_id,book_id,quantity,dispatch_date) value (5,4,5,'2019-06-20');
insert into Orders (order_id,book_id,quantity,dispatch_date) value (6,5,9,'2009-02-02');
insert into Orders (order_id,book_id,quantity,dispatch_date) value (7,5,8,'2010-04-13');

with 1098_leetcode as (
with maintable as (
with rightBooks as (
select
    *,
    datediff('2019-06-23',available_from) as date_diff,
    if(datediff('2019-06-23',available_from)<30,'Yes','No') as new_book
from
    Books)
select
    rightBooks.book_id,
    name,
    quantity,
    year(dispatch_date) as year_dispatch,
    year(date_sub('2019-06-23',interval 365 day )) as last_year
from
    rightBooks
left join
    Orders
on
    rightBooks.book_id = Orders.book_id
where
    new_book !='Yes')
select
    book_id,
    name,
    ifnull(year_dispatch,0) as year_dispatch,
    ifnull(sum(quantity),0) as sum_qty
from
    maintable
group by
    book_id, name,year_dispatch)
select
    distinct book_id,
    name
from
    1098_leetcode;



with 1098_leetcode as (
select
    book_id as b_id,
    sum(quantity) as _nsold
from
    Orders
where
    dispatch_date between date_sub('2019-06-23',interval 365 day ) and '2019-06-23'
group by
    book_id)
select
    book_id,
    name
from
    Books
left join
    1098_leetcode lt
on
    Books.book_id = lt.b_id
where
    (lt._nsold<10 or lt._nsold is null) and datediff('2019-06-23',available_from)>30;


