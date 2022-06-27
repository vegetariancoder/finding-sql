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



select
    member_id,
    name,
    case
        when (sum(present_or_not)*100)/count(member_id)>=80 then 'Diamond'
        when (sum(present_or_not)*100)/count(member_id)>=50 and (sum(present_or_not)*100)/count(member_id) < 80 then 'Gold'
        when (sum(present_or_not)*100)/count(member_id)<50 then 'Silver'
        when (sum(present_or_not)*100)/count(member_id) is null then 'Bronze'
    end as category
from
    (

select
    M.member_id,
    name,
    charged_amount,
    IF(charged_amount is not null, 1,null) as present_or_not
from
    Visits VS
left join
    PurchasesMade PM on VS.visit_id = PM.visit_id
right join
    leetcode.Members M on VS.member_id = M.member_id) maintable
group by
    member_id, name
order by
    member_id;

