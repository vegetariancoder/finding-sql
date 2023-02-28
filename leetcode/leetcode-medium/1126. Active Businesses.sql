use leetcode;

create table if not exists Events(business_id int,
event_type varchar(100),
occurences int);

insert into Events(business_id, event_type, occurences) VALUES (1,'reviews',7 );
insert into Events(business_id, event_type, occurences) VALUES (3,'reviews',3 );
insert into Events(business_id, event_type, occurences) VALUES (1,'ads',11 );
insert into Events(business_id, event_type, occurences) VALUES (2,'ads',7 );
insert into Events(business_id, event_type, occurences) VALUES (3,'ads',6 );
insert into Events(business_id, event_type, occurences) VALUES (1,'page reviews',3 );
insert into Events(business_id, event_type, occurences) VALUES (2,'page reviews',12 );

select * from Events;

with answer as (
select
    business_id,
    Events.event_type,
    occurences,
    avg_values,
    if(occurences>avg_values,'Yes','No') as checking
from
    Events
left join
(select
    event_type,
    avg(occurences) as avg_values
from
    Events
group by
    event_type) avg_calc
on
    Events.event_type=avg_calc.event_type)
select
    business_id
from
    answer
where
    checking='Yes'
group by
    business_id
having
    count(*) > 1;