drop database leetcode;
create database leetcode;
use leetcode;
create table phonelog(
    Callerid int,
    Recipientid int,
    Datecalled datetime
);

insert into phonelog(Callerid, Recipientid, Datecalled)
values(1, 2, '2019-01-01 09:00:00.000'),
       (1, 3, '2019-01-01 17:00:00.000'),
       (1, 4, '2019-01-01 23:00:00.000'),
       (2, 5, '2019-07-05 09:00:00.000'),
       (2, 3, '2019-07-05 17:00:00.000'),
       (2, 3, '2019-07-05 17:20:00.000'),
       (2, 5, '2019-07-05 23:00:00.000'),
       (2, 3, '2019-08-01 09:00:00.000'),
       (2, 3, '2019-08-01 17:00:00.000'),
       (2, 5, '2019-08-01 19:30:00.000'),
       (2, 4, '2019-08-02 09:00:00.000'),
       (2, 5, '2019-08-02 10:00:00.000'),
       (2, 5, '2019-08-02 10:45:00.000'),
       (2, 4, '2019-08-02 11:00:00.000');

select * from phonelog;


select
    table1.Callerid,
    table1.date_value as called_date,
    min_Recipeint as Recipientid
from
    (
    select
        min_datedTable.Callerid,
        date_value,
        Recipientid as min_Recipeint
    from
        (
    select
        Callerid,
        date(Datecalled) as date_value,
        min(Datecalled) as min_date
    from
        phonelog
    group by
        Callerid,date_value) min_datedTable
    inner join
        phonelog
    on
        min_date=Datecalled) table1
inner join
            (select
        min_datedTable.Callerid,
        date_value,
        Recipientid as max_Recipient
    from
        (
    select
        Callerid,
        date(Datecalled) as date_value,
        max(Datecalled) as max_date
    from
        phonelog
    group by
        Callerid,date_value) min_datedTable
    inner join
        phonelog
    on
        max_date=Datecalled) table2
on
    table1.Callerid=table2.Callerid and table1.date_value=table2.date_value and table1.min_Recipeint=table2.max_Recipient;

