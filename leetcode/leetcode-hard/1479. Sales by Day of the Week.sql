drop database leetcode;
create database leetcode;
use leetcode;
CREATE TABLE IF NOT EXISTS Orders (order_id int, customer_id  int, order_date date, item_id int, quantity int);
insert into Orders (order_id, customer_id, order_date,item_id,quantity ) values (1,1,'2020-06-01',1,10);
insert into Orders (order_id, customer_id, order_date,item_id,quantity ) values (2,1,'2020-06-08',2,10);
insert into Orders (order_id, customer_id, order_date,item_id,quantity ) values (3,2,'2020-06-02',1,5);
insert into Orders (order_id, customer_id, order_date,item_id,quantity ) values (4,3,'2020-06-03',3,5);
insert into Orders (order_id, customer_id, order_date,item_id,quantity ) values (5,4,'2020-06-04',4,1);
insert into Orders (order_id, customer_id, order_date,item_id,quantity ) values (6,4,'2020-06-05',5,5);
insert into Orders (order_id, customer_id, order_date,item_id,quantity ) values (7,5,'2020-06-05',1,10);
insert into Orders (order_id, customer_id, order_date,item_id,quantity ) values (8,5,'2020-06-14',4,5);
insert into Orders (order_id, customer_id, order_date,item_id,quantity ) values (9,5,'2020-06-21',3,5);



CREATE TABLE IF NOT EXISTS Items (item_id int, item_name  varchar(100), item_category varchar(100));
insert into Items (item_id, item_name, item_category) values (1,'LC Alg. Book','Book');
insert into Items (item_id, item_name, item_category) values (2,'LC DB. Book','Book');
insert into Items (item_id, item_name, item_category) values (3,'LC Smart Phone','Phone');
insert into Items (item_id, item_name, item_category) values (4,'LC Phone 2020','Phone');
insert into Items (item_id, item_name, item_category) values (5,'LC SmartGlass','Glasses');
insert into Items (item_id, item_name, item_category) values (6,'LC T-Shirt XL','T-Shirt');



with answer as (
select
    quantity,
    dayname(order_date) as day_name,
    item_category
from
    Orders
right join
    Items
on
    Orders.item_id = Items.item_id)
select
    item_category,
    sum(case
        when day_name = 'Monday' then quantity
    end) as Monday,
    sum(case
        when day_name = 'Tuesday' then quantity
    end) as Tuesday,
    sum(case
        when day_name = 'Wednesday' then quantity
    end) as Wednesday,
    sum(case
        when day_name = 'Thursday' then quantity
    end) as Thursday,
    sum(case
        when day_name = 'Friday' then quantity
    end) as Friday,
    sum(case
        when day_name = 'Saturday' then quantity
    end) as Saturday,
    sum(case
        when day_name = 'Sunday' then quantity
    end) as Sunday
from
    answer
group by
    item_category;

