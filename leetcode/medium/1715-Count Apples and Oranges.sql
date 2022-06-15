use leetcode;


create table Boxes
(
box_id int null,
chest_id int null,
apple_count int null,
orange_count int
);

insert into Boxes (box_id,chest_id,apple_count,orange_count) values (2,null,6,15),
(18,14,4,15),
(19,3,8,4),
(12,2,19,20),
(20,6,12,9),
(8,6,9,9),
(3,14,16,7);

create table Chests
(
chest_id int null,
apple_count int null,
orange_count int null
);

insert into Chests (chest_id,apple_count,orange_count) values (6,5,6),
                                                                     (14,20,10),
                                                                     (2,8,8),
                                                                     (3,19,4),
                                                                     (16,19,19);






select
    sum(B.apple_count)+sum(C.apple_count) as apple_count,
    sum(B.orange_count)+sum(C.orange_count) as orange_count
from
    Boxes B
left join leetcode.Chests C on B.chest_id = C.chest_id;

