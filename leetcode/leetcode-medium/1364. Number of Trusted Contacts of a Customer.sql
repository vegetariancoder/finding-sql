drop database leetcode;
create database leetcode;
use leetcode;
SET GLOBAL time_zone = '+3:00';


CREATE TABLE IF NOT EXISTS Customers (
    customer_id int,
    customer_name varchar(100),
    email varchar(100));

insert into Customers (customer_id,customer_name,email) values (1,'Alice','alice@leetcode.com');
insert into Customers (customer_id,customer_name,email) values (2,'Bob','bob@leetcode.com');
insert into Customers (customer_id,customer_name,email) values (13,'John','john@leetcode.com');
insert into Customers (customer_id,customer_name,email) values (6,'Alex','alex@leetcode.com');

CREATE TABLE IF NOT EXISTS Contacts (
    user_id int,
    contact_name varchar(100),
    contact_email varchar(100));

insert into Contacts (user_id,contact_name,contact_email) values (1,'Bob','bob@leetcode.com');
insert into Contacts (user_id,contact_name,contact_email) values (1,'John','john@leetcode.com');
insert into Contacts (user_id,contact_name,contact_email) values (1,'Jal','jal@leetcode.com');
insert into Contacts (user_id,contact_name,contact_email) values (2,'Omar','omar@leetcode.com');
insert into Contacts (user_id,contact_name,contact_email) values (2,'Meir','meir@leetcode.com');
insert into Contacts (user_id,contact_name,contact_email) values (6,'Alice','alice@leetcode.com');


CREATE TABLE IF NOT EXISTS Invoices (
    invoice_id int,
    price int,
    user_id int);

insert into Invoices (invoice_id,price,user_id) values (77,100,1);
insert into Invoices (invoice_id,price,user_id) values (88,200,1);
insert into Invoices (invoice_id,price,user_id) values (99,300,2);
insert into Invoices (invoice_id,price,user_id) values (66,400,2);
insert into Invoices (invoice_id,price,user_id) values (55,500,13);
insert into Invoices (invoice_id,price,user_id) values (44,60 ,6);




select
    t1.invoice_id,
    t1.price,
    t1.user_id,
    t1.customer_name,
    trusted_contacts_cnt,
    contacts_cnt
from
    (
select
    invoice_id,
    price,
    mt.user_id,
    customer_name,
    ifnull(trusted_contacts_cnt,0) as trusted_contacts_cnt
from
    (
select
    invoice_id,
    price,
    user_id,
    customer_name
from
    Invoices
inner join
    Customers
on
    Invoices.user_id = Customers.customer_id
order by
    invoice_id) mt
left join
(select
    user_id,
    count(contact_name) as trusted_contacts_cnt
from
    (
select
    user_id,
    contact_name,
    case
        when contact_name in (select customer_name from Customers) then 'Yes' else 'No'
    end as flagging
from
    Contacts) calc_table
where
    flagging = 'Yes'
group by
    user_id) ttb
on
    mt.user_id=ttb.user_id)t1
inner join
(select
    invoice_id,
    price,
    mt.user_id,
    customer_name,
    ifnull(contacts_cnt,0) as contacts_cnt
from
    (
select
    invoice_id,
    price,
    user_id,
    customer_name
from
    Invoices
inner join
    Customers
on
    Invoices.user_id = Customers.customer_id
order by
    invoice_id)mt
left join
(select
    user_id,
    count(*) as contacts_cnt
from
    Contacts
group by
    user_id) ctt
on
    mt.user_id=ctt.user_id)t2
on
    t1.invoice_id=t2.invoice_id
order by
    invoice_id;