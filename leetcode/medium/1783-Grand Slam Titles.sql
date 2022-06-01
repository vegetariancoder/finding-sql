drop database leetcode;
create database leetcode;
use leetcode;
Create table If Not Exists Players (player_id int, player_name varchar(100));
insert into Players (player_id,player_name) value (1,'Nadal');
insert into Players (player_id,player_name) value (2,'Federer');
insert into Players (player_id,player_name) value (3,'Novak');

select * from Players;
Create table If Not Exists Championships (year int, Wimbledon int, Fr_open int, US_open int, Au_open int);
insert into Championships (year,Wimbledon,Fr_open,US_open,Au_open) value (2018,1,1,1,1);
insert into Championships (year,Wimbledon,Fr_open,US_open,Au_open) value (2019,1,1,2,2);
insert into Championships (year,Wimbledon,Fr_open,US_open,Au_open) value (2020,2,1,2,2);

select
    year,
    count(Wimbledon) as count_wimbledon,
    count(Fr_open) as count_Fr_open,
    count(US_open) as count_US_open,
    count(Au_open) as count_Au_open
from
    Championships
group by
    year;



with 1783_leetcode as (
select
    main_table1.id,
    sum_table1+sum_table2 as grand_slams_count
from
    (
select
    id,
    sum(count_table1) sum_table1
from
(select
    Wimbledon as id,
    count(Wimbledon) as count_table1
from
    Championships
group by
    Wimbledon
union
select
    Au_open as id,
    count(Au_open) as count_table1
from
    Championships
group by
    Au_open) table1
group by
    1) main_table1
inner join
(select
    id,
    sum(count_table2) as sum_table2
from
(select
    Fr_open as id,
    count(Fr_open) as count_table2
from
    Championships
group by
    Fr_open
union
select
    US_open as id,
    count(US_open) as count_table2
from
    Championships
group by
    US_open) table2
group by
    1) main_table2
on
    main_table1.id = main_table2.id)
select
    id as player_id,
    player_name,
    grand_slams_count
from
    1783_leetcode
inner join
    Players
on
    1783_leetcode.id = Players.player_id
order by
    grand_slams_count;




