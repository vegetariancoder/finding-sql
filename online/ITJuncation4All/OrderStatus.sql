drop database online;
create database online;
use online;

create table OrderStatus
(
Quote_Id varchar(5),
Order_Id varchar(5),
Order_Status Varchar(20)
);

Insert into OrderStatus Values ('A','A1','Delivered');
Insert into OrderStatus Values ('A','A2','Delivered');
Insert into OrderStatus Values ('A','A3','Delivered');
Insert into OrderStatus Values ('B','B1','Submitted');
Insert into OrderStatus Values ('B','B2','Delivered');
Insert into OrderStatus Values ('B','B3','Created');
Insert into OrderStatus Values ('C','C1','Submitted');
Insert into OrderStatus Values ('C','C2','Created');
Insert into OrderStatus Values ('C','C3','Submitted');
Insert into OrderStatus Values ('D','D1','Created');


select
    *
from
    OrderStatus;




with answer as (
select
    *,
    case
        when checking='Complete' then 1
        when checking='In Delivery' then 2
        when checking='Awaiting for Submission' then 3
        when checking='Awaiting for Entry' then 4
    end as priority
from
    (
select
    group_table.Quote_Id,
    Order_Status,
    counting,
    total_cnt,
    case
        when Order_Status='Delivered' and counting=total_cnt then 'Complete'
        when Order_Status='Delivered' and counting!=total_cnt then 'In Delivery'
        when Order_Status='Submitted' and counting!=total_cnt then 'Awaiting for Submission'
        else 'Awaiting for Entry'
    end as checking

from
(
select
    Quote_Id,
    Order_Status,
    counting
from
    (
select
    Quote_Id,
    Order_Status,
    count(*) as counting,
    dense_rank() over (partition by Quote_Id order by count(*) desc ) as drnk
from
    OrderStatus
group by
    Quote_Id, Order_Status) calc_table
where
    drnk=1) group_table
left join
(select
    distinct Quote_Id,
    count(Quote_Id) over (partition by Quote_Id) as total_cnt
from
    OrderStatus) total_table
on
    group_table.Quote_Id=total_table.Quote_Id) maintable)
select
    Quote_Id,
    checking as Quote_Status
from
    answer
where
    (Quote_Id,priority) in (
select
    Quote_Id,
    min(priority)
from
    answer
group by
    Quote_Id);
