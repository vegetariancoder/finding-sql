drop database hackerRank;
create database hackerRank;
use hackerRank;

create table hackers (hacker_id int, name varchar(40));
create table submissions (submission_date date, submission_id int, hacker_id int, score int);


insert into hackers values (15758, 'Rose');
insert into hackers values (20703, 'Angela');
insert into hackers values (36396, 'Frank');
insert into hackers values (38289, 'Patrick');
insert into hackers values (44065, 'Lisa');
insert into hackers values (53473, 'Kimberly');
insert into hackers values (62529, 'Bonnie');
insert into hackers values (79722, 'Michael');


insert into submissions values (date_format('2016-03-01', '%y-%m-%d'), 8494,    20703,	 0	);
insert into submissions values (date_format('2016-03-01', '%y-%m-%d'), 22403, 	53473,	 15	);
insert into submissions values (date_format('2016-03-01', '%y-%m-%d'), 23965, 	79722,	 60	);
insert into submissions values (date_format('2016-03-01', '%y-%m-%d'), 30173, 	36396,	 70	);
insert into submissions values (date_format('2016-03-02', '%y-%m-%d'), 34928, 	20703,	 0	);
insert into submissions values (date_format('2016-03-02', '%y-%m-%d'), 38740, 	15758,	 60	);
insert into submissions values (date_format('2016-03-02', '%y-%m-%d'), 42769, 	79722,	 25	);
insert into submissions values (date_format('2016-03-02', '%y-%m-%d'), 44364, 	79722,	 60	);
insert into submissions values (date_format('2016-03-03', '%y-%m-%d'), 45440, 	20703,	 0	);
insert into submissions values (date_format('2016-03-03', '%y-%m-%d'), 49050, 	36396,	 70	);
insert into submissions values (date_format('2016-03-03', '%y-%m-%d'), 50273, 	79722,	 5	);
insert into submissions values (date_format('2016-03-04', '%y-%m-%d'), 50344, 	20703,	 0	);
insert into submissions values (date_format('2016-03-04', '%y-%m-%d'), 51360, 	44065,	 90	);
insert into submissions values (date_format('2016-03-04', '%y-%m-%d'), 54404, 	53473,	 65	);
insert into submissions values (date_format('2016-03-04', '%y-%m-%d'), 61533, 	79722,	 45	);
insert into submissions values (date_format('2016-03-05', '%y-%m-%d'), 72852, 	20703,	 0	);
insert into submissions values (date_format('2016-03-05', '%y-%m-%d'), 74546, 	38289,	 0	);
insert into submissions values (date_format('2016-03-05', '%y-%m-%d'), 76487, 	62529,	 0	);
insert into submissions values (date_format('2016-03-05', '%y-%m-%d'), 82439, 	36396,	 10	);
insert into submissions values (date_format('2016-03-05', '%y-%m-%d'), 90006, 	36396,	 40	);
insert into submissions values (date_format('2016-03-06', '%y-%m-%d'), 90404, 	20703,	 0	);



select * from submissions;

select
    submission_date_1,
    case
        when count(distinct hacker_id_2)=0 then cnt
    else count(distinct hacker_id_2) end as counting
from
    (
with answer as (
select
    submission_date,
    hacker_id
from
    submissions)
select
    a1.submission_date as submission_date_1,
    a1.hacker_id as hacker_id_1,
    a2.hacker_id as hacker_id_2 ,
    ifnull(a2.submission_date,a1.submission_date) as submission_date_2,
    count(a1.submission_date) over (partition by a1.submission_date rows between unbounded preceding and unbounded following) as cnt
from
    answer a1
left join
    answer a2 on
a1.submission_date>a2.submission_date and a1.hacker_id=a2.hacker_id
order by a1.submission_date) calc_table
where
    datediff(submission_date_1,submission_date_2)<=1
group by
    submission_date_1;
