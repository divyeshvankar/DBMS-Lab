-- Active: 1675674032170@@127.0.0.1@3306@week05




-- Task 01
CREATE DATABASE week05;
use week05;


-- Task 02
CREATE Table 
student(cid VARCHAR(7),roll_number VARCHAR(10),name VARCHAR(100) NOT NULL,approval_status VARCHAR(20),credit_status VARCHAR(10),PRIMARY KEY(roll_number,cid));CREATE Table course(cid VARCHAR(7),name VARCHAR(100) NOT NULL,PRIMARY KEY(cid));
CREATE Table credit(cid VARCHAR(7),l INT NOT NULL,t INT NOT NULL,p INT NOT NULL,c FLOAT NOT NULL,PRIMARY KEY(cid));set GLOBAL local_infile=1;


-- task 03
LOAD DATA LOCAL INFILE '/home/divyeshvankar/Desktop/students-credits.csv' INTO TABLE student FIELDS TERMINATED BY',' ENCLOSED BY '"' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE '/home/divyeshvankar/Desktop/courses.csv' INTO TABLE course FIELDS TERMINATED BY',' ENCLOSED BY '"' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE '/home/divyeshvankar/Desktop/credits.csv' INTO TABLE credit FIELDS TERMINATED BY',' ENCLOSED BY '"' LINES TERMINATED BY '\n';


-- task 04
select * from student WHERE name='Adarsh Kumar Udai';
select cid, name , credit_status from student WHERE cid='EE 390' AND credit_status='Credit';
select cid, roll_number, credit_status, approval_status from student WHERE approval_status='pending' AND credit_status='Credit';
select cid, l, t, p, c from credit WHERE c <>6;
select roll_number, name, cid, credit_status, approval_status from student WHERE approval_status='Approved' AND credit_status='Audit';


-- task 05
select name, l, t, p, c from course natural join credit where c = 8;
select name, l, t, p, c from course natural join credit where t > 0;
select cid, name, l, t, p, c from course natural join credit where c = 6 and not(l = 3 and t = 0 and p = 0);
select student.cid, course.name, student.name, l, t, p, c from credit,course,student where course.cid = student.cid and course.cid = credit.cid and student.name = 'Pasch paul Ole';
select roll_number, student.name, student.cid, course.name, l, t, p, c from course , credit ,student where course.cid = student.cid and course.cid = credit.cid and student.cid like 'EE%' and (l = 3 and t = 1 and p = 0 and c=8);


-- task 06
select upper(cid), upper(name) from student where name like '%ATUL%';
select roll_number, credit_status, lower(course.name) from student, course where course.cid=student.cid AND course.name like 'introduction to%';
select cid,count(*) from student where cid like 'EE 3%' group by cid;
select cid,name from course where cid LIKE '____2_M';
select upper(student.name), student.cid, upper(course.name), upper(credit_status) from student,course where course.cid=student.cid and student.name like 'A%TA';