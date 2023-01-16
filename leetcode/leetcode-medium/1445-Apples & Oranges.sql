use leetcode;
create table If Not Exists Sales (sale_date date, fruit varchar(100), sold_num int);
insert into Sales (sale_date,fruit,sold_num) values ('2020-05-01','apples',10),
                                                    ('2020-05-01','oranges',8),
                                                    ('2020-05-02','apples',15),
                                                    ('2020-05-02','oranges',15),
                                                    ('2020-05-03','apples',20),
                                                    ('2020-05-03','oranges',0),
                                                    ('2020-05-04','apples',15),
                                                    ('2020-05-04','oranges',16);


select * from Sales;


select
    sale_date,
    sum(case
        when fruit='apples' then sold_num
    end) -
    sum(case
        when fruit='oranges' then sold_num
    end) as diff
from
    Sales
group by
    sale_date;
