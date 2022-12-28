drop database online;
create database online;
use online;

Create Table Item(
ItemName Varchar(30),
TotalQuantity int
);
Insert into Item Values('Apple',2);
Insert into Item Values('Orange',3);



select * from Item;

with recursive answer as (
    select
        ItemName,
        1 as CatID,
        TotalQuantity
    from
        Item
    union
    select
        ItemName,
        CatID+1 as CatID,
        TotalQuantity
    from
        answer
    where
        CatID<TotalQuantity
)
select (row_number() over (order by ItemName)) as id , answer.* from answer order by ItemName;
