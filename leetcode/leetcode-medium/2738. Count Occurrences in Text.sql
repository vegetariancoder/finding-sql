use leetcode;

CREATE TABLE Files (
  file_name VARCHAR(100),
  content TEXT
);

INSERT INTO Files (file_name, content) VALUES
('draft1.txt', 'The stock exchange predicts a bull market which would make many investors happy.'),
('draft2.txt', 'The stock exchange predicts a bull market which would make many investors happy, but analysts warn of possibility of too much optimism and that in fact we are awaiting a bear market.'),
('draft3.txt', 'The stock exchange predicts a bull market which would make many investors happy, but analysts warn of possibility of too much optimism and that in fact we are awaiting a bear market. As always predicting the future market is an uncertain game and all investors should follow their instincts and best practices.');


select * from Files;

with answer as (
select
    'bear' as word,
    count(file_name) as cnt
from
    Files
where
    content like '%bear%'
union all
select
    'bull' as word,
    count(file_name) as cnt
from
    Files
where
    content like '%bull%')
select * from answer order by cnt desc ;