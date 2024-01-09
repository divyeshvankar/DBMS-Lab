-- Active: 1675678875828@@127.0.0.1@3306@Firstdb



SHOW DATABASES;

use Firstdb;

CREATE TABLE `Firstdb`.`course` (
  `cid` VARCHAR(7) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
   PRIMARY KEY (`cid`));


LOAD DATA INFILE '/home/divyeshvankar/Desktop/courses.csv' INTO TABLE course FIELDS TERMINATED BY ',' ENCLOSED BY "" LINES TERMINATED BY '\n' ;
