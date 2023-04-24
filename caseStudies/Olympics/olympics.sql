create database olympics;


# Problem Statement: Write a SQL query to find the total no of Olympic Games held as per the dataset.


select
    count(distinct Games) as total_olympics_games
from
    athlete_events;

