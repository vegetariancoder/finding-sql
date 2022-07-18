use leetcode;

drop table Purchases;
create table Purchases
(
    purchase_id int null,
    user_id        int null,
    purchase_date     date null
);

insert into Purchases (purchase_id,user_id,purchase_date) values (4,2,'2022-03-13'),
                                                                 (1,5,'2022-02-11'),
                                                                 (1,5,'2022-02-14'),
                                                                 (3,7,'2022-06-19'),
                                                                 (6,2,'2022-03-20'),
                                                                 (5,7,'2022-06-19'),
                                                                 (2,2,'2022-06-08');


with 2228_leetcode as (
select
    user_id,
    purchase_date,
    lead(purchase_date) over (partition by user_id order by purchase_date) as next_purchase,
    datediff(lead(purchase_date) over (partition by user_id order by purchase_date),purchase_date) as diff
from
    Purchases
order by
    user_id)
select
    user_id
from
    2228_leetcode
where
    diff <= 7;




