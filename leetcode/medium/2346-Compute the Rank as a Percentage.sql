use leetcode;
CREATE TABLE IF NOT EXISTS Students (student_id int, department_id  int, mark int);
insert into Students (student_id, department_id, mark) values (2,2,650);
insert into Students (student_id, department_id, mark) values (8,2,650);
insert into Students (student_id, department_id, mark) values (7,1,920);
insert into Students (student_id, department_id, mark) values (1,1,610);
insert into Students (student_id, department_id, mark) values (3,1,530);


select
    student_id,
    department_id,
    round(((dense_rank() over (partition by department_id order by mark desc )-1)*100)/((count(department_id) over (partition by department_id))-1),1) as percentage
from
    Students;