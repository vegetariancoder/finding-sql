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


with 1126_leetcode as (
select
    business_id,
    count(business_id) as count_values
from
    (
select
    *,
    round(avg(occurences) over (partition by event_type),0) as run_avg
from
    Events) cal_tbl
where
    occurences > run_avg
group by
    business_id)
select
    business_id
from
    1126_leetcode
where
    count_values > 1;


# sol -2

select
    business_id
from
    (
select
    *,
    round(avg(occurences) over (partition by event_type),0) as run_avg
from
    Events) cal_tbl
where
    occurences > run_avg
group by
    business_id
having
    count(business_id) > 1;




