drop database datalemur;
create database datalemur;
use datalemur;


Create table If Not Exists artists (artist_id int, artist_name varchar(50));
insert into artists (artist_id, artist_name) values (101,'Ed Sheeran');
insert into artists (artist_id, artist_name) values (120,'Drake');

Create table If Not Exists songs (song_id int, artist_id int);
insert into songs (song_id, artist_id) values (45202,101);
insert into songs (song_id, artist_id) values (19960,120);


Create table If Not Exists global_song_rank (day int, song_id int, rankings int);
insert into global_song_rank (day, song_id, rankings) values (1,45202,5);
insert into global_song_rank (day, song_id, rankings) values (3,45202,2);
insert into global_song_rank (day, song_id, rankings) values (1,19960,3);
insert into global_song_rank (day, song_id, rankings) values (9,19960,15);

select
    artist_name,
    dense_rank() over (order by count(song_id) desc ) as artist_rank
from
    (
select
    global_song_rank.song_id,
    rankings,
    artist_name
from
    global_song_rank
inner join
    songs
on
    global_song_rank.song_id = songs.song_id
inner join
    artists
on
    songs.artist_id=artists.artist_id) as joined_info
where
    rankings<10
group by
    artist_name;

