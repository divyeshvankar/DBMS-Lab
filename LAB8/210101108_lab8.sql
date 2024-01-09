-- Active: 1675678875828@@127.0.0.1@3306@week08

-- ****some commented code runs in terminal to chnage user/ connection
-- ROLL NUMBER : 210101108
-- NAME: VANKAR DIVYESH KUMAR










--TASK-01
CREATE DATABASE week08;
USE DATABASE week08;











--TASK-02
CREATE TABLE cs245_student(
 roll_number char(9) primary key,
 name char(100),
 reg_status char(20),
 audit_credit char(10),
 email char(50),
 phone char(8)
 );
 
 CREATE TABLE cs245_marks(
 roll_number char(9) primary key,
 marks int,
 foreign key(roll_number) references cs245_student(roll_number)
 );
 
 CREATE TABLE cs245_grade(
 roll_number char(9) primary key,
 letter_grade char(2),
 foreign key(roll_number) references cs245_student(roll_number)
 );
 
 CREATE TABLE cs246_student(
 roll_number char(9) primary key,
 name char(100),
 reg_status char(20),
 audit_credit char(10),
 email char(50),
 phone char(8)
 );
 
 CREATE TABLE cs246_marks(
 roll_number char(9) primary key,
 marks int,
 foreign key(roll_number) references cs246_student(roll_number)
 );
 
 CREATE TABLE cs246_grade(
 roll_number char(9) primary key,
 letter_grade char(2),
 foreign key(roll_number) references cs246_student(roll_number)
 );
 








 --TASK-03
 LOAD DATA LOCAL infile '/home/divyesh/Downloads/cs245_student.csv'
     INTO TABLE cs245_student
     FIELDS TERMINATED BY ','
     ENCLOSED BY '"'
     LINES TERMINATED BY '\n'
     ;
 
 LOAD DATA LOCAL infile '/home/divyesh/Downloads/cs245_marks.csv'
     INTO TABLE cs245_marks
     FIELDS TERMINATED BY ','
     ENCLOSED BY '"'
     LINES TERMINATED BY '\n'(roll_number,marks)
     ;
 
 
 LOAD DATA LOCAL infile '/home/divyesh/Downloads/cs245_grade.csv'
     INTO TABLE cs245_grade
     FIELDS TERMINATED BY ','
     ENCLOSED BY '"'
     LINES TERMINATED BY '\n'(roll_number,letter_grade)
     ;
 
 LOAD DATA LOCAL infile '/home/divyesh/Downloads/cs246_student.csv'
     INTO TABLE cs246_student
     FIELDS TERMINATED BY ','
     ENCLOSED BY '"'
     LINES TERMINATED BY '\n'
     ;
 
 LOAD DATA LOCAL infile '/home/divyesh/Downloads/cs246_marks.csv'
     INTO TABLE cs246_marks
     FIELDS TERMINATED BY ','
     ENCLOSED BY '"'
     LINES TERMINATED BY '\n'
     ;
 
 LOAD DATA LOCAL infile '/home/divyesh/Downloads/cs246_grade.csv'
     INTO TABLE cs246_grade
     FIELDS TERMINATED BY ','
     ENCLOSED BY '"'
     LINES TERMINATED BY '\n'(roll_number,letter_grade)
     ;
 







 --TASK-04
 Create user 'headTA'@'localhost' identified by '12345';
 Create user 'saradhi'@'localhost' identified by '12345';
 Create user 'pbhaduri'@'localhost' identified by '12345';
 Create user 'doaa'@'localhost' identified by '12345';
 















 --TASK-05a
 grant select,update,insert on cs245_marks to 'headTA'@'localhost'; 
 grant select,update,insert on cs246_marks to 'headTA'@'localhost';
 grant select,update on cs246_grade to 'saradhi'@'localhost';
 grant select,update on cs245_grade to 'pbhaduri'@'localhost';
 grant select,update,insert,delete on cs245_student to 'doaa'@'localhost';
 grant select,update,insert,delete on cs246_student to 'doaa'@'localhost';




 --TASK-05b
 --1
 --sudo mysql -u headTA -p 
 use week08;
 select marks
 from cs246_marks
 where roll_number = '270123065';
 --2
 --sudo mysql -u headTA -p 
 delete from cs245_marks
 where roll_number = 210123065;
 --0 rows affected because we did not grant delete for headTA
 
 --3
 --sudo mysql -u saradhi -p
 use week08;
 delete from cs246_grade
 where roll_number = 270101005;
 --ERROR 1142 (42000): DELETE command denied to user 'saradhi'@'localhost' for table 'cs246_grade'

delete from cs245_grade
where roll_number = 270101005;
--ERROR 1142 (42000): DELETE command denied to user 'saradhi'@'localhost' for table 'cs245_grade'
 --4
  --sudo mysql -u saradhi -p
 update cs246_grade
 set letter_grade = 'BC'
 where roll_number = 270101005;
 --Rows matched: 1  Changed: 1  Warnings: 0

--5
 --sudo mysql -u pbhaduri -p
update cs245_marks
set marks = 95
where roll_number = 270101064;
--ERROR 1142 (42000): UPDATE command denied to user 'pbhaduri'@'localhost' for table 'cs245_marks'

--6
 --sudo mysql -u pbhaduri -p
select letter_grade
from cs245_grade
where roll_number = 270101064;

--7
--sudo mysql -u doaa -p
insert into cs245_student
values(270123089,'Alex','Approved','Credit','alex@protonmail.edu','9607830');
--8
--sudo mysql -u doaa -p
insert into cs245_marks
values (270123089,67);
 --ERROR 1142 (42000): INSERT command denied to user 'doaa'@'localhost' for table 'cs245_marks'

--9
--sudo mysql -u saradhi -p 
update cs245_grade
set letter_grade ='DD'
where roll_number = 270101053;
--ERROR 1142 (42000): UPDATE command denied to user 'saradhi'@'localhost' for table 'cs245_grade'

--10
--sudo mysql -u pbhaduri -p 
delete from cs246_grade 
where roll_number in (270101004,270101019,270101029,270101039,270101049,270101059);
--ERROR 1142 (42000): DELETE command denied to user 'pbhaduri'@'localhost' for table 'cs246_grade'













--TASK-06a


grant select(roll_number,name,eamil) on cs245_student to 'headTA';
grant select(roll_number,name,eamil) on cs246_student to 'headTA';
grant select(roll_number,name,eamil) on cs245_student to 'pbhaduri';
grant select(roll_number,name,eamil) on cs246_student to 'saradhi';
grant select(roll_number,name,reg_status,audit_credit),insert(roll_number,name,reg_status,audit_credit),update(roll_number,name,reg_status,audit_credit)on cs246_student to 'doaa';





-- 6-b


 --b

--HEAdTA

--i
SELECT email,phone from cs245_student  where name='Craig Salazar';
--SELECT command denied to user 'headTA'@'localhost' for column 'phone' in table 'cs245_student'

--ii
SELECT roll_number,email from cs245_student  where name='Lionel Battle';
--270101015   quis@aol.edu

--iii
delete  from cs246_student where name='Jenette Parks';
--DELETE command denied to user 'headTA'@'localhost' for table 'cs246_student'

--iv
update cs246_student SET email='jparks@aol.ca' WHERE name='Jenette Parks';
--UPDATE command denied to user 'headTA'@'localhost' for table 'cs246_student'

--saradhi

  --v
update cs246_student SET roll_number=290101051 WHERE roll_number=270101051;
 --UPDATE command denied to user 'saradhi'@'localhost' for table 'cs246_student'

  --vi
SELECT email,marks from cs246_student natural JOIN cs246_marks where name='Garrison Donovan';

--SELECT command denied to user 'saradhi'@'localhost' for table 'cs246_marks'


--pbhduri

  --vii
update cs245_student SET reg_status='Approved' and audit_credit='Credit'  WHERE email like '%icloud.couk';

--UPDATE command denied to user 'pbhaduri'@'localhost' for table 'cs245_student'

  --viii
SELECT email,grade from cs245_student natural JOIN cs245_grade where name='Benedict Warren';
--posuere.cubilia@yahoo.ca ,CD

--doaa

--ix
insert into cs246_student values('270123436','Anjali','Pending',NULL,NULL,'844-5838');
-- updated

--x
update cs245_student set audit_credit = 'Audit'where email = 'semper.tellus.id@google.net';
--updated










-- Task 7:
 

 CREATE VIEW viewA as select roll_number, name ,eamil,letter_grade from cs245_grade natural join cs245_student; 
 -- ERROR 1142 (42000): CREATE VIEW command denied to user 'saradhi'@'localhost' for table 'view' 
 CREATE VIEW viewB as select roll_number, name ,eamil,marks from cs245_marks natural join cs245_student; 
 -- ERROR 1142 (42000): CREATE VIEW command denied to user 'headTA'@'localhost' for table 'view' ;
 CREATE VIEW viewC as select roll_number, name ,eamil,letter_grade from cs245_grade natural join cs245_student;
-- ERROR 1142 (42000): CREATE VIEW command denied to user 'headTA'@'localhost' for table 'view3' 
UPDATE cs245_grade SET letter_grade='AA' WHERE name='Zenaida Fleming';
-- update command denied to user 'headTA'@'localhost' for table 'cs245_grade'





 -- Task 08 -- 8a


 GRANT GRANT OPTION on cs246_grade to 'saradhi'@'localhost'; 
 -- 8b 
 GRANT SELECT on cs246_grade to 'headTA'@'localhost';
  -- 8c 
  SELECT roll_number, name, email, marks, letter_grade from cs246_student NATURAL JOIN cs246_grade NATURAL join cs246_marks; 
  -- 206 rows 










-- task09-- 9a



REVOKE SELECT on cs246_grade from 'headTA'@'localhost';
-- 9b
select roll_number, name, email, marks, letter_gradefrom cs246_student natural join cs246_marks natural join cs246_grade;
 -- SELECT command denied to user 'headTA'@'localhost' for table 'cs246_grade' 

-- 9c
revoke select(roll_number, name, reg_status, audit_credit),insert(roll_number, name, reg_status, audit_credit),update(roll_number, name, reg_status, audit_credit) on cs246_student from 'headTA'@'localhost';

-- 9d
REVOKE SELECT(roll_number, name, email) on cs245_student FROM 'headTA'@'localhost';
REVOKE SELECT(roll_number, name, email) on cs246_student FROM 'headTA'@'localhost';
REVOKE SELECT(roll_number, name, email) on cs245_student FROM 'pbhaduri'@'localhost';
REVOKE SELECT(roll_number, name, email) on cs246_student FROM 'saradhi'@'localhost';
REVOKE SELECT(roll_number, name, reg_status, audit_credit) on cs246_student FROM 'doaa'@'localhost';
REVOKE INSERT(roll_number, name, reg_status, audit_credit) on cs246_student FROM 'doaa'@'localhost';
REVOKE UPDATE(roll_number, name, reg_status, audit_credit) on cs246_student FROM 'doaa'@'localhost'; 


-- 9e
REVOKE SELECT, UPDATE, INSERT on cs245_marks FROM 'headTA'@'localhost';
REVOKE SELECT, UPDATE, INSERT on cs246_marks FROM 'headTA'@'localhost';
REVOKE SELECT, UPDATE on cs246_grade FROM 'saradhi'@'localhost';
REVOKE SELECT, UPDATE on cs245_grade FROM 'pbhaduri'@'localhost';
REVOKE SELECT, UPDATE, INSERT, DELETE on cs245_student FROM 'doaa'@'localhost';
REVOKE SELECT, UPDATE, INSERT, DELETE on cs246_student FROM 'doaa'@'localhost'; 
revoke select(roll_number, name, reg_status, audit_credit),insert(roll_number, name, reg_status, audit_credit),update(roll_number, name, reg_status, audit_credit) on cs246_studentfrom 'headTA'@'localhost';








  -- task10 a,b,c,d 
  DROP USER 'headTA'@'localhost';
   DROP USER saradhi'@'localhost';
    DROP USER 'pbhaduri'@'localhost'; 
    DROP USER 'doaa'@'localhost'; 
    
    -- task 10e 
    use mysql; 
    select user from user; 
    -- Output is the list of users, not having headTA, saradhi, pbhaduri, doaa 



 