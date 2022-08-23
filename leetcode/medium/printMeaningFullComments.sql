drop database leetcode;
create database leetcode;
use leetcode;
create table comments_and_translations
(
	id				int,
	comment			varchar(100),
	translation		varchar(100)
);

insert into comments_and_translations values
(1, 'very good', null),
(2, 'good', null),
(3, 'bad', null),
(4, 'ordinary', null),
(5, 'cdcdcdcd', 'very bad'),
(6, 'excellent', null),
(7, 'ababab', 'not satisfied'),
(8, 'satisfied', null),
(9, 'aabbaabb', 'extraordinary'),
(10, 'ccddccbb', 'medium');

select * from comments_and_translations;

select
    case
        when translation is null then comment else translation
    end as output
from
    comments_and_translations;


select
    if(translation is null ,comment,translation) as output
from
    comments_and_translations;