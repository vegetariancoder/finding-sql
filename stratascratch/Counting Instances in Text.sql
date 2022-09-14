drop database strata;
create database strata;
use strata;
Create table If Not Exists google_file_store (filename varchar(100), contents varchar(10000));

insert into google_file_store (filename,contents) value ('draft1.txt','The stock exchange predicts a bull market which would make many investors happy.');
insert into google_file_store (filename,contents) value ('draft2.txt','The stock exchange predicts a bull market which would make many investors happy, but analysts warn of possibility of too much optimism and that in fact we are awaiting a bear market.');
insert into google_file_store (filename,contents) value ('final.txt','The stock exchange predicts a bull market which would make many investors happy, but analysts warn of possibility of too much optimism and that in fact we are awaiting a bear market. As always predicting the future market is an uncertain game and all investors should follow their instincts and best practices.');

with answer as (
select
    'bear' as word,
    count(*) as nentry
from
    google_file_store
where
    contents regexp '\\bbear\\b'
union
select
    'bull' as word,
    count(*) as nentry
from
    google_file_store
where
    contents regexp '\\bbull\\b')
select
    word,
    nentry
from
    answer
order by
    nentry desc ;
