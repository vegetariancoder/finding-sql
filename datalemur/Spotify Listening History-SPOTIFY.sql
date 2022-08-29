drop database datalemur;
create database datalemur;
use datalemur;


Create table If Not Exists songs_history (history_id int, user_id int, song_id int, tally int);
insert into songs_history (history_id, user_id,song_id,tally) values (10011,777,1238,11);
insert into songs_history (history_id, user_id,song_id,tally) values (12452,695,4520,1);

Create table If Not Exists songs_weekly (user_id int, song_id int, listen_time date);
insert into songs_weekly (user_id,song_id,listen_time) values (777,1238,'2021-08-01');
insert into songs_weekly (user_id,song_id,listen_time) values (695,4520,'2021-08-04');
insert into songs_weekly (user_id,song_id,listen_time) values (125,9630,'2021-08-04');
insert into songs_weekly (user_id,song_id,listen_time) values (695,9852,'2021-08-07');

with answer as (
select
    songs_weekly.user_id,
    songs_weekly.song_id,
    listen_time,
    row_number() over (partition by songs_weekly.user_id order by listen_time) as count_of_songs,
    ifnull(tally,0) as tally
from
    songs_weekly
left join
    songs_history
on
    songs_weekly.user_id=songs_history.user_id
where
    listen_time <= '2021-08-04')
select
    user_id,
    song_id,
    count_of_songs+tally as tally
from
    answer
order by
    tally desc ;