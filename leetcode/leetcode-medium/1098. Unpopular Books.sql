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


select
    Books.book_id
from
    Orders
right join
    Books
on
    Orders.book_id=Books.book_id
where
    year(dispatch_date) = year(date_sub('2019-06-23',interval 1 year ))
group by
    book_id
having
    sum(Orders.quantity)>10;


select
    book_id,
    name
from
    Books
where
    available_from not between date_sub('2019-06-23',interval 1 month ) and '2019-06-23'
and
    book_id not in (select
    Books.book_id
from
    Orders
right join
    Books
on
    Orders.book_id=Books.book_id
where
    year(dispatch_date) = year(date_sub('2019-06-23',interval 1 year ))
group by
    book_id
having
    sum(Orders.quantity)>10);