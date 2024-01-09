-- Active: 1675678875828@@127.0.0.1@3306@week06

-- TASK 1, 2,3

 CREATE SCHEMA week06 ;

CREATE TABLE week06.student (
  cid VARCHAR(7) NOT NULL,
  roll_number CHAR(10) NOT NULL,
  name VARCHAR(100) NOT NULL,
  approval_status VARCHAR(20) NULL,
  credit_status VARCHAR(10) NULL,
  PRIMARY KEY (cid, roll_number));


LOAD DATA LOCAL INFILE '/home/divyeshvankar/Desktop/students-credits.csv' INTO TABLE student FIELDS TERMINATED BY',' ENCLOSED BY '"' LINES TERMINATED BY '\n';


CREATE TABLE week06.course (
  cid VARCHAR(7) NOT NULL,
  name VARCHAR(100) NOT NULL,
  PRIMARY KEY (cid));


LOAD DATA LOCAL INFILE '/home/divyeshvankar/Desktop/courses.csv' INTO TABLE course FIELDS TERMINATED BY',' ENCLOSED BY '"' LINES TERMINATED BY '\n';



CREATE TABLE week06.credit (
  cid VARCHAR(7) NOT NULL,
  l INT NOT NULL,
  t INT NOT NULL,
  p INT NOT NULL,
  c FLOAT NOT NULL,
  PRIMARY KEY (cid));


LOAD DATA LOCAL INFILE '/home/divyeshvankar/Desktop/credits.csv' INTO TABLE credit FIELDS TERMINATED BY',' ENCLOSED BY '"' LINES TERMINATED BY '\n';

CREATE TABLE week06.faculty (
  cid VARCHAR(7)  NULL,
  name VARCHAR(50)  NULL);

LOAD DATA LOCAL INFILE '/home/divyeshvankar/Desktop/faculty-course.csv' INTO TABLE faculty FIELDS TERMINATED BY',' ENCLOSED BY '"' LINES TERMINATED BY '\n';

CREATE TABLE week06.semester (
  dept VARCHAR(4) NULL,
  number VARCHAR(4) NULL,
  cid VARCHAR(7) NULL);

LOAD DATA LOCAL INFILE '/home/divyeshvankar/Desktop/semester.csv' INTO TABLE semester FIELDS TERMINATED BY',' ENCLOSED BY '"' LINES TERMINATED BY '\n';











-- TASK 4


SELECT SUM(l) as total_lectures
FROM week06.credit;


SELECT SUM(c)
from week06.credit
WHERE cid like 'EE%';

SELECT SUM(p)*3
from week06.credit
WHERE cid like 'DD%';









-- TASK 5

SELECT cid,count(*)
FROM week06.student
WHERE cid like '%M' and credit_status='AUDIT'
GROUP BY cid;





SELECT substr(cid,1,2),sum(c)
       FROM week06.credit
GROUP BY substr(cid,1,2);








-- TASK 6



SELECT cid,count
FROM (SELECT cid,count(*) as count
FROM week06.student
WHERE credit_status='AUDIT' 
GROUP BY cid) as table1
WHERE table1.count>3;


SELECT cid ,course.name,count
FROM (SELECT cid ,count(*) as count
FROM faculty 
GROUP BY cid) as table1 NATURAL JOIN course 
WHERE count>1 
GROUP BY table1.cid;



SELECT  table1.name,count as count
FROM (SELECT count(*) as count ,faculty.name
FROM faculty
GROUP BY faculty.name)as table1
WHERE count>1
GROUP BY table1.name;





-- TASK 7

SELECT cid,course.name  
FROM credit NATURAL join course
WHERE c=(SELECT min(c)  
FROM credit)
;





SELECT cid ,faculty.name 
FROM credit NATURAL join faculty
WHERE c=(
    SELECT min(tab1.c)
    FROM(
        SELECT cid,c 
        FROM credit
        WHERE cid like 'CS%') as tab1) and cid like 'CS%';









-- TASK 8


create table t8a(
    select number ,sum(c) as total_credit
    from semester natural join credit
    where dept like 'DD%'
    group by number
);


create Table t8a1(
    SELECT number ,sum(c) as total_credit
    from semester natural join credit
    WHERE dept like 'BSBE%'
    GROUP BY number
);


select * from t8a;

select * from t8a1;


SELECT number 
from t8a1
WHERE total_credit <(
    SELECT max(total_credit) from t8a
);


SELECT number
from t8a1
WHERE total_credit>= ALL (
    SELECT(total_credit) from t8a
);