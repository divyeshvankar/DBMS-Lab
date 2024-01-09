-- Active: 1675678875828@@127.0.0.1@3306@week07

-- 1
CREATE DATABASE week07 ;

use week07;
-- 2-a
CREATE TABLE week07.student18a (
  name VARCHAR(100) NULL,
  roll_number VARCHAR(10) NOT NULL,
  PRIMARY KEY (roll_number));

-- 2-b
CREATE TABLE week07.course18a (
  semester INT NULL,
  cid VARCHAR(7) NOT NULL,
  name VARCHAR(100) NULL,
  l INT NULL,
  t INT NULL,
  p INT NULL,
  c INT NULL,
  PRIMARY KEY (cid));


-- 2-c
CREATE TABLE week07.grade18a (
  roll_number VARCHAR(10) NOT NULL,
  cid VARCHAR(7) NOT NULL,
  letter_grade VARCHAR(2),
  PRIMARY KEY (roll_number, cid));



--  3
LOAD DATA LOCAL INFILE '/home/divyeshvankar/Desktop/student18.csv' INTO TABLE week07.student18a FIELDS TERMINATED BY',' ENCLOSED BY '"' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE '/home/divyeshvankar/Desktop/course18.csv' INTO TABLE week07.course18a FIELDS TERMINATED BY',' ENCLOSED BY '"' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE '/home/divyeshvankar/Desktop/grade18.csv' INTO TABLE week07.grade18a FIELDS TERMINATED BY',' ENCLOSED BY '"' LINES TERMINATED BY '\n';






-- 4-a-i


CREATE VIEW  4a1 AS
SELECT roll_number,cid,letter_grade
FROM grade18a
WHERE cid like '%M';

-- 4-a-ii

INSERT INTO week07.grade18a (roll_number, cid, letter_grade) VALUES ('180101000', 'CS101', 'AB');


SELECT * 
FROM grade18a;

-- 4-a-iii
SELECT * 
FROM `4a1`
WHERE roll_number=180101000;
--  no not meterialized as view is not containing the data i have added to table grade18a


-- 4-b-i
CREATE VIEW  4b1 AS
SELECT  distinct cid,letter_grade
FROM grade18a;


SELECT * 
FROM `4b1`;

-- 4-b-ii
INSERT INTO `4b1`  VALUES ( 'CS101', 'PM');
-- 4-b-iii
-- not Updatable this will not work as its parent doesnt contain its primary key and also if we want to add it first add it to main table than insert in view or make new view

-- 4-c-i
CREATE VIEW 4c1 AS
SELECT cid,letter_grade,COUNT(*) as num
FROM grade18a
GROUP BY cid,letter_grade;


SELECT * FROM 4c1;
-- 4-c-ii
INSERT INTO `4c1` (cid,letter_grade,num) VALUES ( 'CS101', 'NP','17');

-- 4-c-iii
--not updatable because of whem group by clause is comes into play we cant able to insert data again the same main reason as above







-- 5-a-i
CREATE TABLE week07.course18b (
  semester INT NULL,
  cid VARCHAR(7) NOT NULL,
  name VARCHAR(100) NULL,
  l INT NULL,
  t INT NULL,
  p INT NULL,
  c INT NULL,
  PRIMARY KEY (cid),
  CHECK (semester IN ('1','2','3','4','5','6','7','8')));

-- 5-a-ii
INSERT INTO course18b VALUES (10,'CS 777', 'Introduction to Chat GPT','3','0','0','6');


-- 5-b
CREATE TABLE `week07`.`allowable_letter_grade` (
  `grade` VARCHAR(2) NOT NULL,
  `value` INT NULL,
  PRIMARY KEY (`grade`));


SELECT * from allowable_letter_grade;


INSERT INTO allowable_letter_grade VALUES('AS','10');
INSERT INTO allowable_letter_grade VALUES ('AA', '10');
INSERT INTO allowable_letter_grade VALUES ('AB', '9');
INSERT INTO allowable_letter_grade VALUES ('BB', '8');
INSERT INTO allowable_letter_grade VALUES ('BC', '7');
INSERT INTO allowable_letter_grade VALUES ('CC', '6');
INSERT INTO allowable_letter_grade VALUES ('CD', '5');
INSERT INTO allowable_letter_grade VALUES ('DD', '4');
INSERT INTO allowable_letter_grade VALUES ('FP', '0');
INSERT INTO allowable_letter_grade VALUES ('FA', '0');
INSERT INTO allowable_letter_grade VALUES ('NP', '0');
INSERT INTO allowable_letter_grade VALUES ('PP', '0');
INSERT INTO allowable_letter_grade VALUES ('I ','0');
INSERT INTO allowable_letter_grade VALUES ('X ','0');


-- 5-c-i

CREATE TABLE week07.grade18b (
  roll_number VARCHAR(10) NOT NULL,
  cid VARCHAR(7) NOT NULL,
  letter_grade VARCHAR(2),
  PRIMARY KEY (roll_number, cid),
  CHECK (grade18b.letter_grade IN ('AS' ,'AA','AB','BB','BC','CC','CD','DD','FP','FA','NP','PP','I','X' )));


-- 5-c-ii

SELECT * from grade18b;
SELECT * from grade18a;

LOAD DATA LOCAL INFILE '/home/divyeshvankar/Desktop/grade18.csv' INTO TABLE grade18b FIELDS TERMINATED BY',' ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- 5-c-iii

UPDATE  grade18b 
SET letter_grade='MP'
WHERE cid='XX102M' AND letter_grade='DD';


-- 5-c-iv
-- it will not be updated as it will violet the constratint we have seted;






-- 6-a
CREATE TABLE week07.student18c (
  name VARCHAR(100) NULL,
  roll_number VARCHAR(10) NOT NULL,
  CONSTRAINT ak PRIMARY KEY (roll_number));





-- 6-b

CREATE TABLE week07.grade18c (
  roll_number VARCHAR(10) NOT NULL,
  cid VARCHAR(7) NOT NULL,
  letter_grade VARCHAR(2),
 CONSTRAINT pk PRIMARY KEY (roll_number, cid),
  CONSTRAINT ak FOREIGN KEY (roll_number) REFERENCES student18c(roll_number));



-- 6-c
ALTER TABLE grade18c
DROP CONSTRAINT ak;




--7-a
CREATE TABLE student18d (
  roll_number CHAR(10) NOT NULL PRIMARY KEY,
  name CHAR(100) NOT NULL
);

--7-b

LOAD DATA LOCAL INFILE'/home/divyeshvankar/Desktop/student18.csv' INTO TABLE student18d
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    (name,roll_number);

--7-c
SELECT Sum(Cast(roll_number as UNSIGNED INT)),MIN(Cast(roll_number as UNSIGNED INT)),MAX(Cast(roll_number as UNSIGNED INT)),AVG(Cast(roll_number as UNSIGNED INT))
FROM student18d;

--7-d
SELECT Cast(roll_number as DATETIME)
FROM student18d;


--8-a
CREATE table course18e like course18a;

--8-b
INSERT INTO course18e 
(SELECT * FROM course18a);




--9-a
CREATE TABLE student18f (
  roll_number CHAR(10) NOT NULL PRIMARY KEY,
  name CHAR(100),
  redundant01 INT DEFAULT 10
);

SELECT * from student18f;
CREATE TABLE course18f (
    semester INT ,
  cid CHAR(7) NOT NULL PRIMARY KEY,
  name CHAR(100) ,
  l INT ,
   t INT ,
   p INT ,
    c INT, 
    redundant01 INT DEFAULT 10
);
SELECT * from course18f;
CREATE TABLE grade18f (
  roll_number CHAR(10) NOT NULL ,
  cid CHAR(7) NOT NULL ,
  letter_grade CHAR(2),
  PRIMARY KEY (roll_number , cid),
  redundant01 INT DEFAULT 10
);
SELECT * from grade18f;
--9-b
LOAD DATA LOCAL INFILE '/home/divyeshvankar/Desktop/student18.csv' INTO TABLE student18f
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    (name,roll_number);

LOAD DATA LOCAL INFILE '/home/divyeshvankar/Desktop/course18.csv' INTO TABLE course18f
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    (semester,cid,name,l,t,p,c);

LOAD DATA LOCAL INFILE '/home/divyeshvankar/Desktop/grade18.csv' INTO TABLE grade18f
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    (roll_number,cid,letter_grade);

--9-c
SELECT student18f.roll_number,student18f.name,cid 
FROM student18f join grade18f USING (roll_number) JOIN course18f USING(cid)
WHERE l = 3 and t=1 and p=0 and c=8;
SELECT * from grade18f;
--9-d
DELETE FROM grade18f;
SELECT * from grade18f;
--9-e
LOAD DATA LOCAL INFILE '/home/divyeshvankar/Desktop/cs570.csv' INTO TABLE grade18f
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    (roll_number,cid,letter_grade);

--9-f
SELECT student18f.roll_number,student18f.name,letter_grade 
FROM student18f left join grade18f USING (roll_number); 

