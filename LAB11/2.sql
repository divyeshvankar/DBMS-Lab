-- Active: 1675678875828@@127.0.0.1@3306@week11
-- TASK 1,2,3
DROP DATABASE week11;
create DATABASE week11;

USE week11;

-- Task 01: Create database week11

CREATE DATABASE IF NOT EXISTS week11;

-- Task 02a: Create table emp_boss_small
-- USE week11;
DROP TABLE IF EXISTS emp_boss_small;
CREATE TABLE emp_boss_small (
  ename VARCHAR(50) NOT NULL,
  bname VARCHAR(50) NOT NULL,
  PRIMARY KEY (ename, bname)
);

-- Task 02b: Create table emp_boss_large
DROP TABLE IF EXISTS emp_boss_large;
CREATE TABLE emp_boss_large (
  ename VARCHAR(50) NOT NULL,
  bname VARCHAR(50) NOT NULL,
  PRIMARY KEY (ename, bname)
);

-- Task 03a: Populate data into emp_boss_small
load data
    local INFILE '/home/divyeshvankar/Desktop/DBMS/LAB11/week-11-emp_small.csv' INTO
TABLE
    emp_boss_small FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' ;


-- Task 03b: Populate data into emp_boss_large
load data
    local INFILE '/home/divyeshvankar/Desktop/DBMS/LAB11/week-11-emp_large.csv' INTO
TABLE
    emp_boss_large FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' ;





-- CALL create_populate_week11();


-- This will find all the bosses of employee 'Emp 3' in the 'emp_boss_small' table and insert them into the 'output_small' table. If you want to find the bosses in the 'emp_boss_large' table, simply change the second argument to 'emp boss large'.

-- Note that the stored procedure assumes that there are no circular references in the employee hierarchy, and that every employee has at most one boss (except for the CEO, who has no boss). If these assumptions don't hold for your data, you may need to modify the stored procedure accordingly.


--  Task4  

 
 CREATE PROCEDURE sp2(IN ename VARCHAR(50), IN data_size VARCHAR(20)) BEGIN
DECLARE output_table_name VARCHAR(50);

 
 IF data_size = 'emp boss small' THEN
    SET output_table_name = 'output_small';

    CREATE TABLE IF NOT EXISTS output_small (
      ename VARCHAR(50) NOT NULL,
      boss VARCHAR(50) NOT NULL,
      PRIMARY KEY (ename, boss)
    );

  ELSEIF data_size = 'emp boss large' THEN
    SET output_table_name = 'output_large';
    CREATE TABLE IF NOT EXISTS output_large (
      ename VARCHAR(50) NOT NULL,
      boss VARCHAR(50) NOT NULL,
      PRIMARY KEY (ename, boss)
    );
  ELSE
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid data size argument';
  END IF;

  -- Step 2: Find all bosses of the given employee
  DROP TEMPORARY TABLE IF EXISTS employee_tree;
  CREATE TEMPORARY TABLE employee_tree (
    ename VARCHAR(50) NOT NULL,
    boss VARCHAR(50) NOT NULL,
    PRIMARY KEY (ename)
  );
  INSERT INTO employee_tree (ename, boss)
  SELECT ename, bname FROM
  (SELECT ename, bname FROM emp_boss_small WHERE ename = ename
   UNION ALL
   SELECT ename, bname FROM emp_boss_large WHERE ename = ename) AS emp_boss
  WHERE ename = ename
  UNION
  SELECT boss_tree.ename, boss_tree.boss FROM employee_tree AS sub_tree
  JOIN
  (SELECT ename, bname AS boss FROM
    (SELECT ename, bname FROM emp_boss_small WHERE ename = ename
     UNION ALL
     SELECT ename, bname FROM emp_boss_large WHERE ename = ename) AS emp_boss
   WHERE ename = ename
   UNION
   SELECT ename, boss FROM employee_tree) AS boss_tree
  ON sub_tree.boss = boss_tree.ename;

  -- Step 3: Insert the bosses into the output table
  INSERT IGNORE INTO @output_table_name (ename, boss)
  SELECT ename,boss FROM employee_tree WHERE employee_tree.ename =ename;

  -- Step 4: Drop the temporary table
  DROP TEMPORARY TABLE employee_tree;
END
;
CALL sp2('Employee 01', 'emp boss small');





-- Note that this code creates the output table output_small if it does not already exist. The cursor cur selects every distinct employee name from the table emp_boss_small, and then the stored procedure sp2 is called for each employee name to insert the corresponding boss information into output_small.
-- task5   
-- create output table output_small if it does not exist
CREATE TABLE IF NOT EXISTS output_small (
  ename VARCHAR(50),
  boss VARCHAR(50)
);

-- loop through every distinct employee in emp_boss_small
DECLARE emp_name VARCHAR(50);
DECLARE cur CURSOR FOR SELECT DISTINCT ename FROM emp_boss_small;
OPEN cur;

read_loop: LOOP
  FETCH cur INTO emp_name;
  IF done THEN
    LEAVE read_loop;
  END IF;
  
  -- call sp2 to get all bosses for current employee and insert into output_small
  CALL sp2(emp_name, 'emp_boss_small');
END LOOP;

CLOSE cur;








-- Note that this code creates the output table output_large if it does not already exist. The cursor cur selects every distinct employee name from the table emp_boss_large, and then the stored procedure sp2 is called for each employee name to insert the corresponding boss information into output_large.

-- task6  
-- create output table output_large if it does not exist
CREATE TABLE IF NOT EXISTS output_large (
  ename VARCHAR(50),
  boss VARCHAR(50)
);

-- loop through every distinct employee in emp_boss_large
DECLARE emp_name VARCHAR(50);
DECLARE cur CURSOR FOR SELECT DISTINCT ename FROM emp_boss_large;
OPEN cur;

read_loop: LOOP
  FETCH cur INTO emp_name;
  IF done THEN
    LEAVE read_loop;
  END IF;
  
  -- call sp2 to get all bosses for current employee and insert into output_large
  CALL sp2(emp_name, 'emp_boss_large');
END LOOP;

CLOSE cur;

