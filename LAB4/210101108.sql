-- to create database
-- task 1
CREATE SCHEMA `week04` ;

-- task 02-a
-- to create coloumn in table fo 2 a    

CREATE TABLE `week04`.`hss_table01` (
  `sno` INT NOT NULL,
  `roll_number` INT NOT NULL,
  `sname` VARCHAR(50) NOT NULL,
  `cid` VARCHAR(10) NOT NULL,
  `cname` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`sno`));

-- task 02-b
-- to see the data you have imported
SELECT * FROM week04.hss_table01;
-- our observations are:
-- we are able to insert only 1431 rows as we have select primary key as srno;


-- task 03-a
CREATE TABLE `week04`.`hss_table02` (
  `sno` INT NOT NULL,
  `roll_number` INT NOT NULL,
  `sname` VARCHAR(50) NOT NULL,
  `cid` VARCHAR(10) NOT NULL,
  `cname` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`cname`));



-- task 3-b
SELECT * FROM week04.hss_table02;
-- our observations are:
-- we are able to insert only 21 rows as we have select primary key as cname;


-- task 04-a

CREATE TABLE `week04`.`hss_table03` (
  `sno` INT NOT NULL,
  `roll_number` INT NOT NULL,
  `sname` VARCHAR(50) NOT NULL,
  `cid` VARCHAR(10) NOT NULL,
  `cname` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`roll_number`, `cid`));


SELECT * FROM week04.hss_table03;
-- our observations are:
-- we are able to insert only 1431 rows;

-- task 04-b
SELECT * FROM week04.hss_table03;
-- our observations are:
-- we are able to insert only 9 rows as we have import additional_hss_course.csv;

-- task 5

CREATE TABLE `week04`.`hss_table04` (
  `sno` INT NOT NULL,
  `roll_number` INT NOT NULL,
  `sname` VARCHAR(50) NOT NULL,
  `cid` VARCHAR(10) NOT NULL,
  `cname` VARCHAR(60) NOT NULL);


-- 5-a

ALTER TABLE `week04`.`hss_table04` 
ADD PRIMARY KEY (`sno`);
;

--  5-b
ALTER TABLE `week04`.`hss_table04` 
DROP PRIMARY KEY,
ADD PRIMARY KEY (`sno`, `roll_number`);
;



-- 6-a

CREATE TABLE `week04`.`hss_course01` (
  `cid` VARCHAR(10) NOT NULL,
  `cname` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`cid`));


-- 6-b
CREATE TABLE `week04`.`hss_table05` (
  `sno` INT NOT NULL,
  `roll_number` INT NOT NULL,
  `sname` VARCHAR(50) NOT NULL,
  `cid` VARCHAR(10) NOT NULL,
  `cname` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`roll_number`),
  INDEX `cid_idx` (`cid` ASC) VISIBLE,
  CONSTRAINT `cid`
    FOREIGN KEY (`cid`)
    REFERENCES `week04`.`hss_course01` (`cid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- 6-c

-- Insert hss courses.csv into table hss course01  inserted 21 record in this table;
--  Insert hss electives.csv file into table hss table05 inserted 1431  record in this table;

-- 6-d

-- Insert violate fk.csv file into table hss table05 => inserted 0 record in this table because same file exists in this table already


-- 7-a

CREATE TABLE `week04`.`hss_course02` (
  `cid` VARCHAR(10) NULL,
  `cname` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`cname`));



-- 7-b

CREATE TABLE `week04`.`hss_table06` (
  `srno` INT NOT NULL,
  `roll_number` INT NOT NULL,
  `sname` VARCHAR(50) NULL,
  `cid` VARCHAR(10) NULL,
  `cname` VARCHAR(60) NULL,
  PRIMARY KEY (`roll_number`),
  INDEX `cid_idx` (`cid` ASC) VISIBLE,
  CONSTRAINT `cid`
    FOREIGN KEY (`cid`)
    REFERENCES `week04`.`hss_course02` (`cname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- Operation failed: There was an error while applying the SQL script to the database.
-- Executing:
-- CREATE TABLE `week04`.`hss_table06` (
--   `srno` INT NOT NULL,
--   `roll_number` INT NOT NULL,
--   `sname` VARCHAR(50) NULL,
--   `cid` VARCHAR(10) NULL,
--   `cname` VARCHAR(60) NULL,
--   PRIMARY KEY (`roll_number`),
--   INDEX `cid_idx` (`cid` ASC) VISIBLE,
--   CONSTRAINT `cid`
--     FOREIGN KEY (`cid`)
--     REFERENCES `week04`.`hss_course02` (`cname`)
--     ON DELETE NO ACTION
--     ON UPDATE NO ACTION);

-- ERROR 1826: Duplicate foreign key constraint name 'cid'
-- SQL Statement:
-- CREATE TABLE `week04`.`hss_table06` (
--   `srno` INT NOT NULL,
--   `roll_number` INT NOT NULL,
--   `sname` VARCHAR(50) NULL,
--   `cid` VARCHAR(10) NULL,
--   `cname` VARCHAR(60) NULL,
--   PRIMARY KEY (`roll_number`),
--   INDEX `cid_idx` (`cid` ASC) VISIBLE,
--   CONSTRAINT `cid`
--     FOREIGN KEY (`cid`)
--     REFERENCES `week04`.`hss_course02` (`cname`)
--     ON DELETE NO ACTION
--     ON UPDATE NO ACTION)



-- 8-a

CREATE TABLE `week04`.`hss_course03` (
  `cid` VARCHAR(10) NULL,
  `cname` VARCHAR(60) NULL);

-- 8-b
CREATE TABLE `week04`.`hss_table07` (
  `sno` INT NULL,
  `roll_number` INT NULL,
  `sname` VARCHAR(50) NULL,
  `cid` VARCHAR(10) NULL,
  `cname` VARCHAR(60) NULL,
  PRIMARY KEY (`roll_number`),
  INDEX `cid_idx` (`cid` ASC) VISIBLE,
  CONSTRAINT `cid`
    FOREIGN KEY (`cid`)
    REFERENCES `week04`.`hss_course03` (`cid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- 8-c




-- -Executing:
-- CREATE TABLE `week04`.`hss_table07` (
--   `sno` INT NULL,
--   `roll_number` INT NOT NULL,
--   `sname` VARCHAR(50) NULL,
--   `cid` VARCHAR(10) NULL,
--   `cname` VARCHAR(60) NULL,
--   PRIMARY KEY (`roll_number`),
--   INDEX `cid_idx` (`cid` ASC) VISIBLE,
--   CONSTRAINT `cid`
--     FOREIGN KEY (`cid`)
--     REFERENCES `week04`.`hss_course03` (`cid`)
--     ON DELETE NO ACTION
--     ON UPDATE NO ACTION);

-- Operation failed: There was an error while applying the SQL script to the database.
-- ERROR 1822: Failed to add the foreign key constraint. Missing index for constraint 'cid' in the referenced table 'hss_course03'
-- SQL Statement:
-- CREATE TABLE `week04`.`hss_table07` (
--   `sno` INT NULL,
--   `roll_number` INT NOT NULL,
--   `sname` VARCHAR(50) NULL,
--   `cid` VARCHAR(10) NULL,
--   `cname` VARCHAR(60) NULL,
--   PRIMARY KEY (`roll_number`),
--   INDEX `cid_idx` (`cid` ASC) VISIBLE,
--   CONSTRAINT `cid`
--     FOREIGN KEY (`cid`)
--     REFERENCES `week04`.`hss_course03` (`cid`)
--     ON DELETE NO ACTION
--     ON UPDATE NO ACTION)









LOAD DATA LOCAL INFILE '~/home/divyeshvankar/Downloads/hss_electives.csv'
INTO TABLE hss_table01
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
SELECT *FROM hss_table01;

load data local infile '/home/divyeshvankar/Downloads/hss_electives.csv' 
into table hss_table01
fields terminated by ',' 
enclosed by '"'
lines terminated by'\n';