Create table If Not Exists Patients (patient_id int, name varchar(100), conditions varchar(100));

insert into Patients (patient_id, name, conditions) values (1, 'Winston', 'YFEV COUGH');
insert into Patients (patient_id, name, conditions) values (2, 'Jonathan', '');
insert into Patients (patient_id, name, conditions) values (3, 'Moustafa', 'DIAB100 MYOP');
insert into Patients (patient_id, name, conditions) values (4, 'Alan', 'ACNE DIAB100');
insert into Patients (patient_id, name, conditions) values (5, 'Deepak', 'DIAB201');

select
    patient_id,
    name,
    conditions
from
    Patients
where
    conditions like '%DIAB1%';
