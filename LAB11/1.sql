-- Active: 1675678875828@@127.0.0.1@3306@week11

-- task1
-- drop DATABASE week11;

CREATE DATABASE IF NOT EXISTS week11;


-- task2

USE week11;

-- Table emp boss small
CREATE TABLE IF NOT EXISTS emp_boss_small (
  ename VARCHAR(50) NOT NULL,
  bname VARCHAR(50) NOT NULL,
  PRIMARY KEY (ename, bname)
);

-- Table emp boss large
CREATE TABLE IF NOT EXISTS emp_boss_large (
  ename VARCHAR(50) NOT NULL,
  bname VARCHAR(50) NOT NULL,
  PRIMARY KEY (ename, bname)
);


-- task3
set GLOBAL LOCAL_infile=1;
-- Load data into emp_boss_small

load data
    local INFILE '/home/divyeshvankar/Desktop/DBMS/LAB11/week-11-emp_small.csv' INTO
TABLE
    emp_boss_small FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' ;

load data
    local INFILE '/home/divyeshvankar/Desktop/DBMS/LAB11/week-11-emp_large.csv' INTO
TABLE
    emp_boss_large FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' ;


-- Load data into emp_boss_large



-- task4
-- Create stored procedure sp2

CREATE PROCEDURE sp2 (
  IN p_ename VARCHAR(50),
  IN p_data_size VARCHAR(20)
)
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE v_boss VARCHAR(50);
  DECLARE cur CURSOR FOR
    SELECT bname
    FROM emp_boss_large
    WHERE ename = p_ename
    UNION
    SELECT bname
    FROM emp_boss_large
    WHERE ename = p_ename;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  
  -- Create output table
  IF p_data_size = 'emp_boss_small' THEN
    CREATE TABLE IF NOT EXISTS output_small (
      ename VARCHAR(50) NOT NULL,
      boss VARCHAR(50) NOT NULL
    );
  ELSEIF p_data_size = 'emp_boss_large' THEN
    CREATE TABLE IF NOT EXISTS output_large (
      ename VARCHAR(50) NOT NULL,
      boss VARCHAR(50) NOT NULL
    );
  END IF;
  
  -- Loop over bosses in the hierarchy and insert into output table
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO v_boss;
    IF done THEN
      LEAVE read_loop;
    END IF;
    INSERT INTO output_small (ename, boss) VALUES (p_ename, v_boss) 
    ON DUPLICATE KEY UPDATE ename = p_ename, boss = v_boss;
  END LOOP;
  CLOSE cur; 
  END;
use week11;


-- SELECT * from output_large;

-- SELECT * FROM output_small;


-- SELECT * from output_large;

-- SELECT * FROM output_small;
-- task5
-- Call sp2 for every distinct employee in emp boss small

SELECT DISTINCT ename FROM week11.emp_boss_small;

-- Loop through the result set and call sp2 for each employee'
CREATE PROCEDURE sp3 ()
BEGIN
DECLARE emp_name VARCHAR(50);
DECLARE data_size VARCHAR(20) DEFAULT 'emp_boss_small';
DECLARE done INT DEFAULT FALSE;

DECLARE emp_cursor CURSOR FOR 
    SELECT DISTINCT ename FROM week11.emp_boss_small;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

OPEN emp_cursor;

emp_loop: LOOP
    FETCH emp_cursor INTO emp_name;
    IF done THEN
        LEAVE emp_loop;
    END IF;
    CALL sp2(emp_name, data_size);
END LOOP;

CLOSE emp_cursor;

END;

-- SELECT * from output_large;

-- SELECT * FROM output_small;
CALL sp3();

-- SELECT * from output_large;

SELECT * FROM output_small;

-- task6

-- Call sp2 for every distinct employee in emp boss large
SELECT DISTINCT ename FROM week11.emp_boss_large;

-- Loop through the result set and call sp2 for each employee

-- SELECT * from output_large;

-- SELECT * FROM output_small;

CREATE PROCEDURE sp4 ()
BEGIN

DECLARE emp_name VARCHAR(50);
DECLARE data_size VARCHAR(20) DEFAULT 'emp_boss_large';
DECLARE done INT DEFAULT FALSE;

DECLARE emp_cursor CURSOR FOR 
    SELECT DISTINCT ename FROM week11.emp_boss_large;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

OPEN emp_cursor;

emp_loop: LOOP
    FETCH emp_cursor INTO emp_name;
    IF done THEN
        LEAVE emp_loop;
    END IF;
    CALL sp2(emp_name, data_size);
END LOOP;

CLOSE emp_cursor;
END;

CALL sp4();


-- CALL sp2('Employee 01', 'emp boss large');
-- SELECT * from output_large;

SELECT * FROM output_small;