-- Active: 1675678875828@@127.0.0.1@3306@week09
CREATE TABLE `week09`.`student18` (
  `name` VARCHAR(100) NULL,
  `roll_number` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`roll_number`));



CREATE TABLE `week09`.`course18` (
  `semester` INT NULL,
  `cid` VARCHAR(7) NOT NULL,
  `name` VARCHAR(100) NULL,
  `l` INT NULL,
  `t` INT NULL,
  `p` INT NULL,
  `c` INT NULL,
  PRIMARY KEY (`cid`));

CREATE TABLE `week09`.`grade18` (
  `roll_number` VARCHAR(10) NOT NULL,
  `cid` VARCHAR(7) NOT NULL,
  `letter_grade` VARCHAR(2) NULL,
  PRIMARY KEY (`roll_number`, `cid`));


CREATE TABLE `week09`.`curriculum` (
  `dept` VARCHAR(3) NULL,
  `number` INT NULL,
  `cid` VARCHAR(7) NULL);




 LOAD DATA LOCAL infile '/home/divyeshvankar/Desktop/curriculum.csv'
     INTO TABLE curriculum
     FIELDS TERMINATED BY ','
     ENCLOSED BY '"'
     LINES TERMINATED BY '\n'
     ;


 LOAD DATA LOCAL infile '/home/divyeshvankar/Desktop/grade18 (1).csv'
     INTO TABLE grade18
     FIELDS TERMINATED BY ','
     ENCLOSED BY '"'
     LINES TERMINATED BY '\n'
     ;
 LOAD DATA LOCAL infile '/home/divyeshvankar/Desktop/course18(1).csv'
     INTO TABLE course18
     FIELDS TERMINATED BY ','
     ENCLOSED BY '"'
     LINES TERMINATED BY '\n'
     ;



create table gradeval(letter_grade char(2),g_val int);
insert into gradeval values('AS',10);
insert into gradeval values('AA',10);
insert into gradeval values('AB',9);
insert into gradeval values('BB',8);
insert into gradeval values('BC',7);
insert into gradeval values('CC',6);
insert into gradeval values('CD',5);
insert into gradeval values('DD',4);
insert into gradeval values('F',0);