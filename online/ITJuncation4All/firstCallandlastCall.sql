drop database online;
create database online;
use online;

Create Table Phone_Log(
Source_Phone_Nbr int,
Destination_Phone_Nbr int,
Call_Start_DateTime datetime) ;

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
    *,
    if(Destination_Phone_Nbr=last_val,'Yes','No') as Is_Match
from
    (
select
    *,
    last_value(Destination_Phone_Nbr) over (partition by Source_Phone_Nbr order by Call_Start_DateTime rows between current row and unbounded following) as last_val,
    row_number() over (partition by Source_Phone_Nbr order by Call_Start_DateTime) as rn
from
    Phone_Log) calc_table
where
    rn=1)
select
    Source_Phone_Nbr,
    Is_Match
from
    answer;
