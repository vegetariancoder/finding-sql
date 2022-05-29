use leetcode;

CREATE TABLE Product (
product_id int,
name varchar(100)
);

INSERT into Product values (0,'ham'),
                           (1,'bacon');

CREATE TABLE Invoice (
invoice_id int,
product_id int,
rest int,
padi int,
cancelled int,
refund int
);

INSERT into Invoice values (23,0,2,0,5,0),
                           (12,0,0,4,0,3),
                           (1,1,1,1,0,1),
                           (2,1,1,0,1,1),
                           (3,1,0,1,1,1),
                           (4,1,1,1,1,0);

select * from Product;
select * from Invoice;

select
    name,
    sum(rest) as rest,
    sum(padi) as paid,
    sum(cancelled) as cancelled,
    sum(refund) as refunded
from
    Product
inner join
    Invoice I on Product.product_id = I.product_id
group by
    name
order by
    name;


