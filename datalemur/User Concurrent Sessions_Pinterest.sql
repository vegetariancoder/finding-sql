drop database datalemur;
create database datalemur;
use datalemur;

Create table If Not Exists sessions (session_id int, start_time datetime, end_time datetime);
insert into sessions (session_id, start_time, end_time) values (746382,'2022-01-02 12:00:00','2022-02-01 16:48:00');
insert into sessions (session_id, start_time, end_time) values (143145,'2022-01-02 14:25:00','2022-02-01 15:05:00');
insert into sessions (session_id, start_time, end_time) values (134514,'2022-01-02 15:23:00','2022-02-01 18:15:00');
insert into sessions (session_id, start_time, end_time) values (242354,'2022-01-02 21:34:00','2022-03-01 00:11:00');
insert into sessions (session_id, start_time, end_time) values (143256,'2022-01-06 06:55:00','2022-01-06 09:05:00');

SELECT
  sessions_1.session_id,
  COUNT(sessions_2.session_id) AS concurrent_sessions
FROM sessions AS sessions_1
JOIN sessions AS sessions_2
  ON sessions_1.session_id != sessions_2.session_id
  AND sessions_2.start_time BETWEEN sessions_1.start_time AND sessions_1.end_time
GROUP BY sessions_1.session_id;
