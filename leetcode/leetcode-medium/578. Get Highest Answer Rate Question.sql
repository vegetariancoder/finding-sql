use leetcode;
CREATE TABLE IF NOT EXISTS SurveyLog (id int, action varchar(100), question_id int, answer_id int, q_num int, timestamp_vals int);
insert into SurveyLog (id, action,question_id,answer_id,q_num,timestamp_vals) values (5,'show',285,null,1,123);
insert into SurveyLog (id, action,question_id,answer_id,q_num,timestamp_vals) values (5,'answer',285,124124,1,124);
insert into SurveyLog (id, action,question_id,answer_id,q_num,timestamp_vals) values (5,'show',369,null,2,125);
insert into SurveyLog (id, action,question_id,answer_id,q_num,timestamp_vals) values (5,'skip',369,null,2,126);


with answer as (
select
    show_question,
    ifnull(sum(answer_count)/sum(shown_count),0) as checking
from
    (
select
    question_id as show_question,
    count(*) as shown_count
from
    SurveyLog
where
    action='show'
group by
    question_id)shown
left join
(select
    question_id as answer_question,
    count(*) as answer_count
from
    SurveyLog
where
    action='answer'
group by
    question_id) answer
on
    shown.show_question=answer.answer_question
group by
    show_question)
select
    show_question
from
    answer
order by
    checking desc
limit 1;
