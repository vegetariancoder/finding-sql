use leetcode;
CREATE TABLE IF NOT EXISTS Scores (id int, score float);
insert into Scores (id, score) values (1,3.50);
insert into Scores (id, score) values (2,3.65);
insert into Scores (id, score) values (3,4.00);
insert into Scores (id, score) values (4,3.85);
insert into Scores (id, score) values (5,4.00);
insert into Scores (id, score) values (6,3.65);



select
    score,
    dense_rank() over (order by score desc ) as drnk
from
    Scores;