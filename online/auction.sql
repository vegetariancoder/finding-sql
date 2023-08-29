use online;


create table auction (
    item_id int,
    item_amount int,
    auction_date date
);

insert into auction value (1,15000,'2023-01-01');
insert into auction value (1,25000,'2023-01-02');
insert into auction value (1,4000,'2023-01-05');
insert into auction value (2,23500,'2023-02-15');
insert into auction value (2,2150,'2023-02-08');
insert into auction value (3,15500,'2023-02-16');
insert into auction value (3,2500,'2023-02-28');
insert into auction value (4,35000,'2023-06-05');


create table buyer (
    buyer_id int,
    buyer_pool int
);

insert into buyer value (123,45000);
insert into buyer value (456,21000);
insert into buyer value (789,35000);
insert into buyer value (258,7800);
insert into buyer value (147,12000);


with cte as (
select
    item_id,
    sum(item_amount) as sm
from
    auction
where
    day(auction_date) <= 15
group by
    item_id
having
    count(*) > 1)
select
    cte.item_id,
    count(buyer_id) as eligible_buyer_count
from
    cte
left join
    buyer
on
    cte.sm <= buyer.buyer_pool
group by
    cte.item_id;