-- Active: 1675678875828@@127.0.0.1@3306@week12

-- create DATABASE week12;

use week12;

CREATE TABLE student (
  name VARCHAR(50) NOT NULL,
  IQ INT NULL,
  gender VARCHAR(1),
  PRIMARY KEY (name));
 SELECT * from student;
 

CREATE TABLE speak (
  name VARCHAR(50) NOT NULL,
  language VARCHAR(50) NOT NULL,
  PRIMARY KEY (name,language));

   SELECT * from speak;



set GLOBAL local_infile = 1 ;
load data
    local INFILE '/home/divyeshvankar/Desktop/DBMS/LAB12/student.csv' INTO
TABLE
    student FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' ;

load data
    local INFILE '/home/divyeshvankar/Desktop/DBMS/LAB12/speaks.csv' INTO
TABLE
    speak FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' ;


-- 4th A
 select language 
 from speak
 GROUP BY LANGUAGE
 HAVING COUNT(DISTINCT name)=(
    SELECT MIN(student_count)
    FROM (
       SELECT COUNT(DISTINCT name) AS student_count
       FROM speak
       GROUP BY language
    ) AS student_count
 );







-- 4th B

 SELECT language 
 FROM (SELECT language,rank() OVER (ORDER BY COUNT(DISTINCT name)) AS rnk 
  FROM speak
  GROUP BY language

 ) t
 WHERE rnk=1;

-- 5th A  

SELECT name 
from (
   SELECT name,COUNT(DISTINCT language) as language_count
   from speak
   GROUP BY name
) as language_count
 ORDER BY language_count DESC
 LIMIT 1;



-- 5th B 
SELECT name 
FROM (
   SELECT name, RANK() OVER ( ORDER BY COUNT( DISTINCT language ) DESC ) AS rnk
   FROM speak
   GROUP BY name
) as ranked 
WHERE rnk= 1
;
-- LIMIT 1;





-- -- 6th A 
SELECT gender
FROM student
GROUP BY gender
ORDER BY AVG(IQ) DESC
LIMIT 1;






-- 6th B  



SELECT gender 
FROM(
    SELECT gender,AVG(IQ) AS avg_iq ,RANK() OVER (ORDER BY AVG(IQ) DESC) AS  rnk 
    FROM student
    GROUP BY gender
) as ranked
WHERE rnk=1;




-- 7th 

SELECT name,IQ 
FROM student
WHERE name IN(
  SELECT name
  FROM speak 
  WHERE language='Japanese'
)
ORDER BY IQ DESC
LIMIT 2;




-- 8th


SELECT s.name, s.IQ,s.gender
FROM student s 
INNER JOIN (
    select gender,MAX(IQ) as max_iq 
    FROM student 
    GROUP BY gender 
) as max_iq_table 
ON s.gender=max_iq_table.gender AND s.IQ = max_iq_table.max_iq;

