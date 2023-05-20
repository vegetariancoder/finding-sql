use leetcode;

drop table titleA;
drop table titleB;

create table titleA (letter varchar(100));
create table titleB (letter varchar(100));

insert into titleA (letter) values ('A');
insert into titleA (letter) values ('B');
insert into titleA (letter) values ('C');
insert into titleA (letter) values ('D');
insert into titleA (letter) values ('E');
insert into titleA (letter) values ('G');
insert into titleA (letter) values ('A');
insert into titleA (letter) values ('F');

insert into titleB (letter) values ('A');
insert into titleB (letter) values ('A');
insert into titleB (letter) values ('C');
insert into titleB (letter) values ('D');
insert into titleB (letter) values ('E');
insert into titleB (letter) values ('B');
insert into titleB (letter) values ('B');
insert into titleB (letter) values ('K');

select * from titleA;

select
    *
from
    titleA
inner join
    titleB on titleA.letter = titleB.letter;


select
    *
from
    titleA
right join
    titleB on titleA.letter = titleB.letter;

select
    *
from
    titleA
left join
    titleB on titleA.letter = titleB.letter;


select
    titleA.letter, titleB.letter
from titleA
left outer join titleB
  on titleA.letter = titleB.letter
union all      -- Using `union all` instead of `union`
select
    titleA.letter, titleB.letter
from titleB
left outer join titleA
  on titleA.letter = titleB.letter
where
    titleA.letter IS NULL