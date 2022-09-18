drop database learning;
create database learning;
use learning;
Create table If Not Exists fb_eu_energy (date date, consumption int);

insert into fb_eu_energy (date,consumption) value ('2020-01-01',400);
insert into fb_eu_energy (date,consumption) value ('2020-01-02',350);
insert into fb_eu_energy (date,consumption) value ('2020-01-03',500);
insert into fb_eu_energy (date,consumption) value ('2020-01-04',500);
insert into fb_eu_energy (date,consumption) value ('2020-01-07',600);

Create table If Not Exists fb_asia_energy (date date, consumption int);

insert into fb_asia_energy (date,consumption) value ('2020-01-01',400);
insert into fb_asia_energy (date,consumption) value ('2020-01-02',400);
insert into fb_asia_energy (date,consumption) value ('2020-01-04',675);
insert into fb_asia_energy (date,consumption) value ('2020-01-05',1200);
insert into fb_asia_energy (date,consumption) value ('2020-01-06',750);
insert into fb_asia_energy (date,consumption) value ('2020-01-07',400);


Create table If Not Exists fb_na_energy (date date, consumption int);

insert into fb_na_energy (date,consumption) value ('2020-01-01',250);
insert into fb_na_energy (date,consumption) value ('2020-01-02',375);
insert into fb_na_energy (date,consumption) value ('2020-01-03',600);
insert into fb_na_energy (date,consumption) value ('2020-01-06',500);
insert into fb_na_energy (date,consumption) value ('2020-01-07',250);



select
    date,
    total_energy
from
    (
with answer as (
select * from fb_eu_energy
union all
select * from fb_asia_energy
union all
select * from fb_na_energy)
select
    date,
    sum(consumption) as total_energy,
    rank() over (order by sum(consumption) desc) as rnk
from
    answer
group by
    date) calc
where
    rnk=1
order by date;