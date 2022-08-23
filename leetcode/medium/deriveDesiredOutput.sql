drop database leetcode;
create database leetcode;
use leetcode;
CREATE TABLE source
    (
        id      int,
        name    varchar(1)
    );

CREATE TABLE target
    (
        id      int,
        name    varchar(1)
    );

INSERT INTO source VALUES (1, 'A');
INSERT INTO source VALUES (2, 'B');
INSERT INTO source VALUES (3, 'C');
INSERT INTO source VALUES (4, 'D');

INSERT INTO target VALUES (1, 'A');
INSERT INTO target VALUES (2, 'B');
INSERT INTO target VALUES (4, 'X');
INSERT INTO target VALUES (5, 'F');

select * from source;
select * from target;

select
    source.id,
    'New in source' as comment
from
    source
left join target on source.id = target.id
where
    target.id is null
union
select
    target.id,
    'New in target' as comment
from
    source
right join target  on target.id = source.id
where
    source.id is null
union
select
    source.id,
    'Mismatch' as comment
from
    source
inner join
    target on source.name != target.name and source.id = target.id;
