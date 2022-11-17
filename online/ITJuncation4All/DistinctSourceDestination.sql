drop database online;
create database online;
use online;
Create Table Travel_Table(
Start_Location Varchar(30),
End_Location Varchar(30),
Distance int);

Insert into Travel_Table Values('Delhi','Pune',1400);
Insert into Travel_Table Values('Pune','Delhi',1400);
Insert into Travel_Table Values('Bangalore','Chennai',350);
Insert into Travel_Table Values('Mumbai','Ahmedabad',500);
Insert into Travel_Table Values('Chennai','Bangalore',350);
Insert into Travel_Table Values('Patna','Ranchi',300);

select * from Travel_Table;


select
    distinct
    case
        when Start_Location>End_Location then End_Location else Start_Location
    end as Source,
    case
        when Start_Location> End_Location then Start_Location else End_Location
    end as Destination,
    Distance
from
    Travel_Table