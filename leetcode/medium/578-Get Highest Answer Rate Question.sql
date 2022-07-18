use leetcode;
CREATE TABLE IF NOT EXISTS SurveyLog (id int, action varchar(100), question_id int, answer_id int, q_num int, timestamp_vals int);
insert into SurveyLog (id, action,question_id,answer_id,q_num,timestamp_vals) values (5,'show',285,null,1,123);
insert into SurveyLog (id, action,question_id,answer_id,q_num,timestamp_vals) values (5,'answer',285,124124,1,124);
insert into SurveyLog (id, action,question_id,answer_id,q_num,timestamp_vals) values (5,'show',369,null,2,125);
insert into SurveyLog (id, action,question_id,answer_id,q_num,timestamp_vals) values (5,'skip',369,null,2,126);


select
    question_id,
    sum(action='answer')/sum(action='show') as ratio
from
    SurveyLog
group by
    question_id
order by
    ratio desc
limit 1
