drop database online;
create database online;
use online;

Create Table Phone_Log(
Source_Phone_Nbr int,
Destination_Phone_Nbr int,
Call_Start_DateTime Datetime) ;

Insert into Phone_Log Values (2345,6789,'2012-07-01 10:00');
Insert into Phone_Log Values (2345,1234,'2012-07-01 11:00');
Insert into Phone_Log Values (2345,4567,'2012-07-01 12:00');
Insert into Phone_Log Values (2345,4567,'2012-07-01 13:00');
Insert into Phone_Log Values (2345,6789,'2012-07-01 15:00');
Insert into Phone_Log Values (3311,7890,'2012-07-01 10:00');
Insert into Phone_Log Values (3311,6543,'2012-07-01 12:00');
Insert into Phone_Log Values (3311,1234,'2012-07-01 13:00');

select * from Phone_Log;

with answer as (
select
    Source_Phone_Nbr,
    Destination_Phone_Nbr,
    Call_Start_DateTime as first_called,
    lead(Destination_Phone_Nbr) over (partition by Source_Phone_Nbr order by Call_Start_DateTime) as last_called,
    if(Destination_Phone_Nbr=lead(Destination_Phone_Nbr) over (partition by Source_Phone_Nbr order by Call_Start_DateTime),'Y','N') as Is_Match
from
     (
select
    Source_Phone_Nbr,
    Destination_Phone_Nbr,
    Call_Start_DateTime
from
     Phone_Log
where
    (Source_Phone_Nbr,Call_Start_DateTime) in (
select
    Source_Phone_Nbr,
    min(Call_Start_DateTime) as min_time
from
    Phone_Log
group by
    Source_Phone_Nbr)
union all
select
    Source_Phone_Nbr,
    Destination_Phone_Nbr,
    Call_Start_DateTime
from
     Phone_Log
where
    (Source_Phone_Nbr,Call_Start_DateTime) in (
select
    Source_Phone_Nbr,
    max(Call_Start_DateTime) as max_time
from
    Phone_Log
group by
    Source_Phone_Nbr))calc_table
order by
    Source_Phone_Nbr)
select
    distinct Source_Phone_Nbr,
    Is_Match
from
    answer
where
    last_called is not null;



select * from Phone_Log;

select
    Source_Phone_Nbr,
    if(sum(case
        when first_call_rank=1 then Destination_Phone_Nbr
    end)=sum(case
        when last_call_rank=1 then Destination_Phone_Nbr
    end),'Y','N') as flagging
from
     (
select
    Source_Phone_Nbr,
    Destination_Phone_Nbr,
    Call_Start_DateTime,
    dense_rank() over (partition by Source_Phone_Nbr order by Call_Start_DateTime) as first_call_rank,
    dense_rank() over (partition by Source_Phone_Nbr order by Call_Start_DateTime desc) as last_call_rank
from
    Phone_Log) as calc_table
group by
    1;