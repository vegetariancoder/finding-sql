drop database leetcode;
create database leetcode;
use leetcode;

CREATE TABLE Members (
member_id int,
name varchar(100)
);

INSERT into Members values (9,'Alice'),
(11,'Bob'),
(3,'Winston'),
(8,'Hercy'),
(1,'Narihan');

CREATE TABLE Visits (
visit_id int,
member_id int,
visit_date date
);

INSERT into Visits values (22,11,'2021-10-28'),
(16,11,'2021-01-12'),
(18,9,'2021-12-10'),
(19,3,'2021-10-19'),
(12,11,'2021-03-01'),
(17,8,'2021-05-07'),
(21,9,'2021-05-12');



CREATE TABLE PurchasesMade (
visit_id int,
charged_amount int
);

INSERT into PurchasesMade values (12,2000),
(18,9000),
(17,7000);




with visit_count as (
select
    member_id,
    sum(case
        when visit_id in (select visit_id from PurchasesMade) then 1 else 0
    end) as visit_cnt
from
    Visits
group by
    member_id)
, total_count as (
select
    member_id,
    count(*) as total_cnt
from
    Visits
group by
    member_id)
, main_table as (
select
    Members.member_id,
    name,
    ifnull(visit_cnt,0) as visit_cnt,
    ifnull(total_cnt,0) as total_cnt,
    round(ifnull(visit_cnt,0)/ifnull(total_cnt,0)*100,0) as trusted
from
    total_count inner join visit_count on total_count.member_id=visit_count.member_id
right join
    Members on total_count.member_id = Members.member_id)
select
    member_id,
    name,
    case
        when trusted>=80 then 'Diamond'
        when trusted >= 50 and trusted <80 then 'Gold'
        when trusted < 50 then 'Silver'
    else 'Bronze' end as category
from
    main_table
order by
    member_id;