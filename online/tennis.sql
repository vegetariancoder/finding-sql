drop database online;
create database online;
use online;


create table player(
    player_id int,
    name varchar(100)
);

insert into player (player_id, name)
values (1,'Nadal');
insert into player (player_id, name)
values (2,'Federrer');
insert into player (player_id, name)
values (3,'Novak');


create table champion(
    year int,
    wimbeldon int,
    french int,
    us int,
    au int
);

insert into champion (year, wimbeldon, french, us, au)
values (2018,1,1,1,1);
insert into champion (year, wimbeldon, french, us, au)
values (2019,1,1,2,2);
insert into champion (year, wimbeldon, french, us, au)
values (2020,2,1,2,2);

select * from champion;

select * from player;

with answer as (
select
    case
        when wimbeldon = 1 then (select name from player where player_id = 1)
        when wimbeldon = 2 then (select name from player where player_id = 2)
        when wimbeldon = 3 then (select name from player where player_id = 3)
    end as player
from
    champion
union all
select
    case
        when french = 1 then (select name from player where player_id = 1)
        when french = 2 then (select name from player where player_id = 2)
        when french = 3 then (select name from player where player_id = 3)
    end as player
from
    champion
union all
select
    case
        when us = 1 then (select name from player where player_id = 1)
        when us = 2 then (select name from player where player_id = 2)
        when us = 3 then (select name from player where player_id = 3)
    end as player
from
    champion
union all
select
    case
        when au = 1 then (select name from player where player_id = 1)
        when au = 2 then (select name from player where player_id = 2)
        when au = 3 then (select name from player where player_id = 3)
    end as player
from
    champion)
select
    player_id,
    player,
    count(*) as grand_slam_count
from
    answer
left join
    player
on
    answer.player = player.name
group by
    player_id,player;
