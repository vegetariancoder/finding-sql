use leetcode;

CREATE TABLE Data (
first_col int,
second_col varchar(100)
);

INSERT into Data values (4,2),
                        (2,3),
                        (3,1),
                        (1,4);


select * from Data;

with answer as (
select
    first_col,
    dense_rank() over (order by first_col) as ordered_first_col,
    second_col,
    dense_rank() over (order by second_col desc ) as ordered_second_col
from
    Data)
select
    ordered_second_col as first_col,
    second_col
from
    answer;