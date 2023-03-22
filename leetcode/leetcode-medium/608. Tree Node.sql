use leetcode;


Create table If Not Exists Tree (id int, p_id int);
Truncate table Tree;
insert into Tree (id, p_id) values ('1', null);
insert into Tree (id, p_id) values ('2', '1');
insert into Tree (id, p_id) values ('3', '1');
insert into Tree (id, p_id) values ('4', '2');
insert into Tree (id, p_id) values ('5', '2');

select * from Tree;


select
    id,
    case
        when p_id is null then 'Root'
        when p_id in (select id from Tree) and id in (select p_id from Tree) then 'Inner'
    else 'Leaf' end as type
from
    Tree;