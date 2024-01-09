-- Active: 1675678875828@@127.0.0.1@3306@week11

CREATE SCHEMA `week11` ;
use week11;
CREATE TABLE `week11`.`emp_boss_small` (
  `ename` VARCHAR(50) NOT NULL,
  `bname` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ename`, `bname`));

CREATE TABLE `week11`.`emp_boss_large` (
  `ename` VARCHAR(50) NOT NULL,
  `bname` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ename`, `bname`));



  set GLOBAL local_infile = 1 ;
load data
    local INFILE '/home/divyeshvankar/Desktop/DBMS/LAB11/week-11-emp_small.csv' INTO
TABLE
    emp_boss_small FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' ;

load data
    local INFILE '/home/divyeshvankar/Desktop/DBMS/LAB11/week-11-emp_large.csv' INTO
TABLE
    emp_boss_large FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' ;



-- task4
-- Create stored procedure sp2
CREATE TABLE output_small(
    ename VARCHAR(50),
    bname VARCHAR(50)
);
CREATE TABLE output_large(
    ename VARCHAR(50),
    bname VARCHAR(50)
);


CREATE PROCEDURE sp2(in ename char(50),in data_size char(20))
BEGIN   
    if(data_size = "emp_boss_small") THEN
    SET @emp = ename;
    SET @original_emp = ename;
    WHILE((SELECT bname FROM emp_boss_small WHERE emp_boss_small.ename=@emp)!="NA") DO
        INSERT INTO output_small VALUE (@original,(SELECT bname FROM emp_boss_small WHERE emp_boss_small.ename=@emp));
        SET @emp =(SELECT bname FROM emp_boss_small WHERE emp_boss_small.ename=@emp);
    end WHILE;
    ELSE
    SET @emp = ename;
    SET @original_emp = ename;
    WHILE((SELECT bname FROM emp_boss_large WHERE emp_boss_large.ename=@emp)!="NA") DO
        INSERT INTO output_large VALUE (@original,(SELECT bname FROM emp_boss_large WHERE emp_boss_large.ename=@emp));
        SET @emp =(SELECT bname FROM emp_boss_large WHERE emp_boss_large.ename=@emp);
    end WHILE;
    end if;
END;


call `sp2`('Employee 01','emp_boss_small');
call `sp2`('Employee 02','emp_boss_small');
call `sp2`('Employee 03','emp_boss_small');
call `sp2`('Employee 04','emp_boss_small');
call `sp2`('Employee 05','emp_boss_small');
call `sp2`('Employee 06','emp_boss_small');
call `sp2`('Employee 07','emp_boss_small');
call `sp2`('Employee 08','emp_boss_small');
call `sp2`('Employee 09','emp_boss_small');
call `sp2`('Employee 10','emp_boss_small');
call `sp2`('Employee 11','emp_boss_small');
call `sp2`('Employee 12','emp_boss_small');
call `sp2`('Employee 13','emp_boss_small');





call `sp2`('Employee 01','emp_boss_large');
call `sp2`('Employee 02','emp_boss_large');
call `sp2`('Employee 03','emp_boss_large');
call `sp2`('Employee 04','emp_boss_large');
call `sp2`('Employee 05','emp_boss_large');
call `sp2`('Employee 06','emp_boss_large');
call `sp2`('Employee 07','emp_boss_large');
call `sp2`('Employee 08','emp_boss_large');
call `sp2`('Employee 09','emp_boss_large');
call `sp2`('Employee 10','emp_boss_large');
call `sp2`('Employee 11','emp_boss_large');
call `sp2`('Employee 12','emp_boss_large');
call `sp2`('Employee1 3','emp_boss_large');
call `sp2`('Employee 14','emp_boss_large');
call `sp2`('Employee 15','emp_boss_large');
call `sp2`('Employee 16','emp_boss_large');
call `sp2`('Employee 17','emp_boss_large');
call `sp2`('Employee 18','emp_boss_large');
call `sp2`('Employee 19','emp_boss_large');
call `sp2`('Employee 20','emp_boss_large');
call `sp2`('Employee 21','emp_boss_large');
call `sp2`('Employee 22','emp_boss_large'); 
call `sp2`('Employee 23','emp_boss_large');
call `sp2`('Employee 24','emp_boss_large');
call `sp2`('Employee 25','emp_boss_large');
call `sp2`('Employee 26','emp_boss_large');
call `sp2`('Employee 27','emp_boss_large');
call `sp2`('Employee 28','emp_boss_large');
call `sp2`('Employee 29','emp_boss_large');
call `sp2`('Employee 30','emp_boss_large');
call `sp2`('Employee 31','emp_boss_large');
call `sp2`('Employee 32','emp_boss_large');
call `sp2`('Employee 33','emp_boss_large');
call `sp2`('Employee 34','emp_boss_large');
call `sp2`('Employee 35','emp_boss_large');
call `sp2`('Employee 36','emp_boss_large');
call `sp2`('Employee 37','emp_boss_large');
call `sp2`('Employee 38','emp_boss_large');
call `sp2`('Employee 39','emp_boss_large');
call `sp2`('Employee 40','emp_boss_large');
call `sp2`('Employee 41','emp_boss_large');
call `sp2`('Employee 42','emp_boss_large');
call `sp2`('Employee 43','emp_boss_large');
call `sp2`('Employee 44','emp_boss_large');
call `sp2`('Employee 45','emp_boss_large');
call `sp2`('Employee 46','emp_boss_large');
call `sp2`('Employee 47','emp_boss_large');
call `sp2`('Employee 48','emp_boss_large');
call `sp2`('Employee 49','emp_boss_large');



select bname from output_small;

select bname from output_large;

