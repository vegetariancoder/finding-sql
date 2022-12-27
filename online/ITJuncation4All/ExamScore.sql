drop database online;
create database online;
use online;

Create Table Exam_Score
(
StudentId int,
SubjectID int,
Marks int
);

Insert Into Exam_Score values(101,1,60);
Insert Into Exam_Score values(101,2,71);
Insert Into Exam_Score values(101,3,65);
Insert Into Exam_Score values(101,4,60);
Insert Into Exam_Score values(102,1,40);
Insert Into Exam_Score values(102,2,55);
Insert Into Exam_Score values(102,3,64);
Insert Into Exam_Score values(102,4,50);
Insert Into Exam_Score values(103,1,45);
Insert Into Exam_Score values(103,2,39);
Insert Into Exam_Score values(103,3,60);
Insert Into Exam_Score values(103,4,65);
Insert Into Exam_Score values(104,1,83);
Insert Into Exam_Score values(104,2,77);
Insert Into Exam_Score values(104,3,91);
Insert Into Exam_Score values(104,4,74);
Insert Into Exam_Score values(105,1,83);
Insert Into Exam_Score values(105,2,77);
Insert Into Exam_Score values(105,4,74);


select * from Exam_Score;

with answer as (
select
    StudentId,
    ifnull(sum(case
        when SubjectID=1 then Marks
    end),0) as Subject1,
    ifnull(sum(case
        when SubjectID=2 then Marks
    end),0) as Subject2,
    ifnull(sum(case
        when SubjectID=3 then Marks
    end),0) as Subject3,
    ifnull(sum(case
        when SubjectID=4 then Marks
    end),0) as Subject4
from
    Exam_Score
group by
    StudentId),
    main_answer as (
select
    *,
    (Subject1+Subject2+Subject3+Subject4) as total_marks,
    round((Subject1+Subject2+Subject3+Subject4)/(select count(distinct SubjectID) from Exam_Score),0) as percentage
from
    answer)
select
    StudentId,
    Subject1,
    Subject2,
    Subject3,
    Subject4,
    total_marks,
    if(least(Subject1,Subject2,Subject3,Subject4) < 40 or percentage<50,'Fail','Pass') as test
from
    main_answer;