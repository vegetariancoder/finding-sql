Create table If Not Exists TVProgram (program_date datetime, content_id int,channel varchar(100));
insert into TVProgram (program_date,content_id,channel) value ('2020-06-10 08:00',1,'LC-Channel');
insert into TVProgram (program_date,content_id,channel) value ('2020-05-11 12:00',2,'LC-Channel');
insert into TVProgram (program_date,content_id,channel) value ('2020-05-11 12:00',3,'LC-Channel');
insert into TVProgram (program_date,content_id,channel) value ('2020-05-13 14:00',4,'Disney Ch');
insert into TVProgram (program_date,content_id,channel) value ('2020-06-18 14:00',4,'Disney Ch');
insert into TVProgram (program_date,content_id,channel) value ('2020-07-15 16:00',5,'Disney Ch');


Create table If Not Exists Content (content_id int, title varchar(100),Kids_content varchar(100), content_type varchar(100));
insert into Content (content_id,title,Kids_content,content_type) value (1,'Leetcode Movie','N','Movie');
insert into Content (content_id,title,Kids_content,content_type) value (2,'Alg. for Kids','N','Series');
insert into Content (content_id,title,Kids_content,content_type) value (3,'Database Sols','N','Series');
insert into Content (content_id,title,Kids_content,content_type) value (4,'Aladdin','Y','Movie');
insert into Content (content_id,title,Kids_content,content_type) value (5,'Cinderella','N','Movie');


select
    title
from
    Content
left join
    TVProgram TP on Content.content_id = TP.content_id
where
    extract(MONTH from program_date) = 6
and
    Kids_content = 'Y';

