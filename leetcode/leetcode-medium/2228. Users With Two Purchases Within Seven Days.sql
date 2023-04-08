use leetcode;


create table Purchases
(
    purchase_id int null,
    user_id        int null,
    purchase_date     date null
);

insert into Purchases (purchase_id,user_id,purchase_date) values (4,2,'2022-03-13'),
                                                                 (1,5,'2022-02-11'),
                                                                 (3,7,'2022-06-19'),
                                                                 (6,2,'2022-03-20'),
                                                                 (5,7,'2022-06-19'),
                                                                 (2,2,'2022-06-08');


select * from Purchases;

with answer as (
select
    *,
    lead(purchase_date) over (partition by user_id order by purchase_date) as next_purchase,
    if(datediff(lead(purchase_date) over (partition by user_id order by purchase_date),purchase_date)<=7,'Yes','No') as checking
from
    Purchases)
select
    user_id
from
    answer
where
    checking='Yes';


