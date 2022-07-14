use leetcode;

CREATE TABLE Data (
first_col int,
second_col varchar(100)
);

INSERT into Data values (4,2),
                        (2,3),
                        (3,1),
                        (1,4);


with 2159_leetcode as (
select
    first_col,
    dense_rank() over (order by first_col desc ) as first_col_inverted
from
    Data)
select
    first_col_inverted as first_col,
    first_col as second_col
from
    2159_leetcode;









