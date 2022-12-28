drop database online;
create database online;
use online;

Create Table Customer(
Customer_id  int,
Cus_name  varchar(30),
Age  int,
Gender  varchar(10),
App  varchar(30) );

Insert into Customer Values(1,'Amelia',23,'Female','gpay');
Insert into Customer Values(2,'William',16,'Male','phonepay');
Insert into Customer Values(3,'James',18,'Male','paytm');
Insert into Customer Values(4,'David',24,'Male','paytm');
Insert into Customer Values(5,'Ava',21,'Female','gpay');
Insert into Customer Values(6,'Sophia',31,'Female','paytm');
Insert into Customer Values(7,'Oliver',23,'Male','gpay');
Insert into Customer Values(8,'Harry',29,'Male',NULL);
Insert into Customer Values(9,'Issac',16,'Male','gpay');
Insert into Customer Values(10,'Jack',22,'Male','phonepay');

Create Table Transaction_Tbls (
Loc_name varchar(30),
Loc_id int,
Cus_id int,
Amount_paid int,
Trans_id int);

Insert into Transaction_Tbls Values ('Florida',100,1,78899,1000);
Insert into Transaction_Tbls Values ('Florida',100,2,55678,1001);
Insert into Transaction_Tbls Values ('Florida',100,3,27788,1002);
Insert into Transaction_Tbls Values ('Florida',100,4,65886,1003);
Insert into Transaction_Tbls Values ('Alaska',101,5,57757,1004);
Insert into Transaction_Tbls Values ('Alaska',101,6,34676,1005);
Insert into Transaction_Tbls Values ('Alaska',101,7,66837,1006);
Insert into Transaction_Tbls Values ('Alaska',101,8,77633,1007);
Insert into Transaction_Tbls Values ('Texas',102,9,98766,1008);
Insert into Transaction_Tbls Values ('Texas',102,10,45335,1009);



select * from Customer;
select * from Transaction_Tbls;

with answer as (
select
   Loc_name,
   Loc_id,
   Cus_id,
   Amount_paid,
   Trans_id,
   ifnull(App,'Offline') as App,
   dense_rank() over (partition by Loc_name order by Amount_paid desc ) as drnk
from
    Transaction_Tbls
inner join
    Customer
on
    Transaction_Tbls.Cus_id=Customer.Customer_id)
select
    App,
    count(Trans_id) as Cnt
from
    answer
where
    drnk=1
group by
    App
order by
    App;