create database online;
use online;

create table files
(
id              int primary key,
date_modified   date,
file_name       varchar(50)
);
insert into files values (1	,'2021-06-03', 'thresholds.svg');
insert into files values (2	,'2021-06-01', 'redrag.py');
insert into files values (3	,'2021-06-03', 'counter.pdf');
insert into files values (4	,'2021-06-06', 'reinfusion.py');
insert into files values (5	,'2021-06-06', 'tonoplast.docx');
insert into files values (6	,'2021-06-01', 'uranian.pptx');
insert into files values (7	,'2021-06-03', 'discuss.pdf');
insert into files values (8	,'2021-06-06', 'nontheologically.pdf');
insert into files values (9	,'2021-06-01', 'skiagrams.py');
insert into files values (10,'2021-06-04', 'flavors.py');
insert into files values (11,'2021-06-05', 'nonv.pptx');
insert into files values (12,'2021-06-01', 'under.pptx');
insert into files values (13,'2021-06-02', 'demit.csv');
insert into files values (14,'2021-06-02', 'trailings.pptx');
insert into files values (15,'2021-06-04', 'asst.py');
insert into files values (16,'2021-06-03', 'pseudo.pdf');
insert into files values (17,'2021-06-03', 'unguarded.jpeg');
insert into files values (18,'2021-06-06', 'suzy.docx');
insert into files values (19,'2021-06-06', 'anitsplentic.py');
insert into files values (20,'2021-06-03', 'tallies.py');


select * from files;

with answer as (
select
    date_modified,
    sep,
    count_values
from
     (
select
    date_modified,
    sep,
    count_values,
    rank() over (partition by date_modified order by count_values desc) as rnk
from
     (
select
    date_modified,
    substring_index(file_name,'.',-1) as sep,
    count(*) as count_values
from
    files
group by
    date_modified, substring_index(file_name,'.',-1)
order by
    date_modified) calc_table) most_cal_table
where
    rnk=1)
select
    date_modified,
    group_concat(sep) as extension,
    count_values
from
    answer
group by
    date_modified, count_values;

