CREATE DATABASE week10;
use week10;
CREATE TABLE student18(
    name char(100),
    roll_number char(10) PRIMARY KEY,
    cpi FLOAT DEFAULT 0.0
);
CREATE TABLE course18(
    semester INT,
    cid char(7) PRIMARY KEY,
    name char(100),
    l INT,
    t INT,
    p INT,
    c INT
);
CREATE TABLE grade18(
    roll_number char(100),
    cid char(7),
    letter_grade char(2),
    PRIMARY KEY (roll_number, cid)
);
CREATE TABLE curriculum(
    dept char(4),
    number INT,
    cid char(7)
);
CREATE TABLE grade_point(
    letter_grade char(2) PRIMARY KEY,
    value INT
);
-- drop TABLE transcript ;
CREATE TABLE trigger_log(
    my_action char(10),
    roll_number char(10),
    semester INT,
    SPI DECIMAL(5, 2),
    CPI DECIMAL(5, 2),
    check(my_action in ('INSERT', 'UPDATE', 'DELETE'))
);
CREATE TABLE transcript(
    roll_number char(10),
    semester INT,
    SPI DECIMAL(5, 2),
    CPI DECIMAL(5, 2)
);
CREATE TABLE u_grade18(
    roll_number char(100),
    cid char(7),
    letter_grade char(2),
    PRIMARY KEY (roll_number, cid)
);
set GLOBAL local_infile = 1;
LOAD DATA LOCAL infile '/home/divyeshvankar/Desktop/student18.csv' INTO TABLE student18 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';
LOAD DATA LOCAL infile '/home/divyeshvankar/Desktop/course18.csv' INTO TABLE course18 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';
LOAD DATA LOCAL infile '/home/divyeshvankar/Desktop/curriculum.csv' INTO TABLE curriculum FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';
LOAD DATA LOCAL infile '/home/divyeshvankar/Desktop/u_grade18.csv' INTO TABLE u_grade18 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';
LOAD DATA LOCAL infile '/home/divyeshvankar/Desktop/transcript.csv' INTO TABLE transcript FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';
-- TASK 4
-- TASK 4aINSERT INTO grade_point
INSERT INTO grade_point
VALUES('AS', '10');
INSERT INTO grade_point
VALUES ('AA', '10');
INSERT INTO grade_point
VALUES ('AB', '9');
INSERT INTO grade_point
VALUES ('BB', '8');
INSERT INTO grade_point
VALUES ('BC', '7');
INSERT INTO grade_point
VALUES ('CC', '6');
INSERT INTO grade_point
VALUES ('CD', '5');
INSERT INTO grade_point
VALUES ('DD', '4');
INSERT INTO grade_point
VALUES ('FP', '0');
INSERT INTO grade_point
VALUES ('FA', '0');
INSERT INTO grade_point
VALUES ('I', '0');
INSERT INTO grade_point
VALUES ('X', '0');
INSERT INTO grade_point
VALUES ('PP', '0');
INSERT INTO grade_point
VALUES ('NP', '0');
-- (i)
CREATE TRIGGER trigger1 BEFORE
INSERT on grade18 FOR EACH ROW BEGIN IF NEW.letter_grade NOT IN (
        "AS",
        "AA",
        "AB",
        "BB",
        "BC",
        "CC",
        "CD",
        "DD",
        "FP",
        "FA",
        "PP",
        "NP",
        "I",
        "X"
    ) THEN SIGNAL sqlstate '50001'
SET MESSAGE_TEXT = 'letter_grade invalid';
END IF;
END;
-- (ii)
-- DROP TRIGGER trigger5 ;
CREATE TRIGGER trigger2
AFTER
INSERT on grade18 FOR EACH ROW BEGIN
SET @semester = (
        SELECT semester
        FROM course18
        WHERE cid = NEW.cid
    );
UPDATE transcript
SET SPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester = @semester
            AND roll_number = NEW.roll_number
    )
WHERE roll_number = NEW.roll_number
    AND semester = @semester;
UPDATE transcript
SET CPI = 0 + (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 1
            AND roll_number = NEW.roll_number and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 1;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 2
            AND roll_number = NEW.roll_number and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 2;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 3
            AND roll_number = NEW.roll_number and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 3;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 4
            AND roll_number = NEW.roll_number and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 4;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 5
            AND roll_number = NEW.roll_number and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 5;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 6
            AND roll_number = NEW.roll_number  and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 6;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 7
            AND roll_number = NEW.roll_number  and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 7;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 8
            AND roll_number = NEW.roll_number  and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 8;
SET @SPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester = @semester
            AND roll_number = NEW.roll_number
    );
SET @CPI = (
        SELECT (sum(value * c) / sum(c))
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= @semester
            AND roll_number = NEW.roll_number
    );
INSERT INTO trigger_log
VALUES(
        "INSERT",
        NEW.roll_number,
        @semester,
        @SPI,
        @CPI
    );
END;
DELETE FROM grade18;
INSERT INTO grade18
VALUES('180101078', 'MA101', 'AA');
INSERT INTO grade18
VALUES('180101078', 'CH101', 'BB');
-- TASK 4b
-- (i)
CREATE TRIGGER trigger3 BEFORE
UPDATE on grade18 FOR EACH ROW BEGIN IF NEW.letter_grade NOT IN (
        "AS",
        "AA",
        "AB",
        "BB",
        "BC",
        "CC",
        "CD",
        "DD",
        "FP",
        "FA",
        "PP",
        "NP",
        "I",
        "X"
    ) THEN SIGNAL sqlstate '50001'
SET MESSAGE_TEXT = 'letter_grade invalid';
END IF;
END;
-- (ii)
CREATE TRIGGER trigger4
AFTER
UPDATE on grade18 FOR EACH ROW BEGIN
SET @semester = (
        SELECT semester
        FROM course18
        WHERE cid = NEW.cid
    );
UPDATE transcript
SET SPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester = @semester
            AND roll_number = NEW.roll_number and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = @semester;
UPDATE transcript
SET CPI = 0 + (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 1
            AND roll_number = NEW.roll_number and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 1;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 2
            AND roll_number = NEW.roll_number and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 2;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 3
            AND roll_number = NEW.roll_number and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 3;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 4
            AND roll_number = NEW.roll_number and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 4;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 5
            AND roll_number = NEW.roll_number and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 5;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 6
            AND roll_number = NEW.roll_number and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 6;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 7
            AND roll_number = NEW.roll_number and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 7;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 8
            AND roll_number = NEW.roll_number and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 8;
SET @SPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester = @semester
            AND roll_number = NEW.roll_number
    );
SET @CPI = (
        SELECT (sum(value * c) / sum(c))
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= @semester
            AND roll_number = NEW.roll_number
    );
INSERT INTO trigger_log
VALUES(
        "UPDATE",
        NEW.roll_number,
        @semester,
        @SPI,
        @CPI
    );
END;
-- TASK 4c
CREATE TRIGGER trigger5
AFTER DELETE on grade18 FOR EACH ROW BEGIN
SET @semester = (
        SELECT semester
        FROM course18
        WHERE cid = OLD.cid
    );
UPDATE transcript
SET SPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester = @semester
            AND roll_number = OLD.roll_number
    )
WHERE roll_number = OLD.roll_number
    AND semester = @semester;
UPDATE transcript
SET CPI = 0 + (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 1
            AND roll_number = OLD.roll_number AND c!=0
    )
WHERE roll_number = OLD.roll_number
    AND semester = 1;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 2
            AND roll_number = OLD.roll_number and c!=0
    )
WHERE roll_number = OLD.roll_number
    AND semester = 2;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 3
            AND roll_number = OLD.roll_number and c!=0
    )
WHERE roll_number = OLD.roll_number
    AND semester = 3;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 4
            AND roll_number = OLD.roll_number and c!=0
    )
WHERE roll_number = OLD.roll_number
    AND semester = 4;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 5
            AND roll_number = OLD.roll_number and c!=0
    )
WHERE roll_number = OLD.roll_number
    AND semester = 5;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 6
            AND roll_number = OLD.roll_number and c!=0
    )
WHERE roll_number = OLD.roll_number
    AND semester = 6;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 7
            AND roll_number = OLD.roll_number and c!=0
    )
WHERE roll_number = OLD.roll_number
    AND semester = 7;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 8
            AND roll_number = OLD.roll_number and c!=0
    )
WHERE roll_number = OLD.roll_number
    AND semester = 8;
SET @SPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester = @semester
            AND roll_number = OLD.roll_number
    );
SET @CPI = (
        SELECT (sum(value * c) / sum(c))
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= @semester
            AND roll_number = OLD.roll_number
    );
INSERT INTO trigger_log
VALUES(
        "DELETE",
        OLD.roll_number,
        @semester,
        @SPI,
        @CPI
    );
END;
load data local INFILE '/home/divyeshvankar/Desktop/grade18.csv' INTO TABLE grade18 FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';

CREATE DATABASE week10;
use week10;
CREATE TABLE student18(
    name char(100),
    roll_number char(10) PRIMARY KEY,
    cpi FLOAT DEFAULT 0.0
);
CREATE TABLE course18(
    semester INT,
    cid char(7) PRIMARY KEY,
    name char(100),
    l INT,
    t INT,
    p INT,
    c INT
);
CREATE TABLE grade18(
    roll_number char(100),
    cid char(7),
    letter_grade char(2),
    PRIMARY KEY (roll_number, cid)
);
CREATE TABLE curriculum(
    dept char(4),
    number INT,
    cid char(7)
);
CREATE TABLE grade_point(
    letter_grade char(2) PRIMARY KEY,
    value INT
);
-- drop TABLE transcript ;
CREATE TABLE trigger_log(
    my_action char(10),
    roll_number char(10),
    semester INT,
    SPI DECIMAL(5, 2),
    CPI DECIMAL(5, 2),
    check(my_action in ('INSERT', 'UPDATE', 'DELETE'))
);
CREATE TABLE transcript(
    roll_number char(10),
    semester INT,
    SPI DECIMAL(5, 2),
    CPI DECIMAL(5, 2)
);
CREATE TABLE u_grade18(
    roll_number char(100),
    cid char(7),
    letter_grade char(2),
    PRIMARY KEY (roll_number, cid)
);
set GLOBAL local_infile = 1;
LOAD DATA LOCAL infile '/home/divyeshvankar/Desktop/student18.csv' INTO TABLE student18 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';
LOAD DATA LOCAL infile '/home/divyeshvankar/Desktop/course18.csv' INTO TABLE course18 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';
LOAD DATA LOCAL infile '/home/divyeshvankar/Desktop/curriculum.csv' INTO TABLE curriculum FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';
LOAD DATA LOCAL infile '/home/divyeshvankar/Desktop/u_grade18.csv' INTO TABLE u_grade18 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';
LOAD DATA LOCAL infile '/home/divyeshvankar/Desktop/transcript.csv' INTO TABLE transcript FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';
-- TASK 4
-- TASK 4aINSERT INTO grade_point
INSERT INTO grade_point
VALUES('AS', '10');
INSERT INTO grade_point
VALUES ('AA', '10');
INSERT INTO grade_point
VALUES ('AB', '9');
INSERT INTO grade_point
VALUES ('BB', '8');
INSERT INTO grade_point
VALUES ('BC', '7');
INSERT INTO grade_point
VALUES ('CC', '6');
INSERT INTO grade_point
VALUES ('CD', '5');
INSERT INTO grade_point
VALUES ('DD', '4');
INSERT INTO grade_point
VALUES ('FP', '0');
INSERT INTO grade_point
VALUES ('FA', '0');
INSERT INTO grade_point
VALUES ('I', '0');
INSERT INTO grade_point
VALUES ('X', '0');
INSERT INTO grade_point
VALUES ('PP', '0');
INSERT INTO grade_point
VALUES ('NP', '0');
-- (i)
CREATE TRIGGER trigger1 BEFORE
INSERT on grade18 FOR EACH ROW BEGIN IF NEW.letter_grade NOT IN (
        "AS",
        "AA",
        "AB",
        "BB",
        "BC",
        "CC",
        "CD",
        "DD",
        "FP",
        "FA",
        "PP",
        "NP",
        "I",
        "X"
    ) THEN SIGNAL sqlstate '50001'
SET MESSAGE_TEXT = 'letter_grade invalid';
END IF;
END;
-- (ii)
-- DROP TRIGGER trigger5 ;
CREATE TRIGGER trigger2
AFTER
INSERT on grade18 FOR EACH ROW BEGIN
SET @semester = (
        SELECT semester
        FROM course18
        WHERE cid = NEW.cid
    );
UPDATE transcript
SET SPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester = @semester
            AND roll_number = NEW.roll_number
    )
WHERE roll_number = NEW.roll_number
    AND semester = @semester;
UPDATE transcript
SET CPI = 0 + (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 1
            AND roll_number = NEW.roll_number and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 1;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 2
            AND roll_number = NEW.roll_number and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 2;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 3
            AND roll_number = NEW.roll_number and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 3;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 4
            AND roll_number = NEW.roll_number and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 4;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 5
            AND roll_number = NEW.roll_number and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 5;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 6
            AND roll_number = NEW.roll_number  and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 6;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 7
            AND roll_number = NEW.roll_number  and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 7;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 8
            AND roll_number = NEW.roll_number  and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 8;
SET @SPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester = @semester
            AND roll_number = NEW.roll_number
    );
SET @CPI = (
        SELECT (sum(value * c) / sum(c))
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= @semester
            AND roll_number = NEW.roll_number
    );
INSERT INTO trigger_log
VALUES(
        "INSERT",
        NEW.roll_number,
        @semester,
        @SPI,
        @CPI
    );
END;
DELETE FROM grade18;
INSERT INTO grade18
VALUES('180101078', 'MA101', 'AA');
INSERT INTO grade18
VALUES('180101078', 'CH101', 'BB');
-- TASK 4b
-- (i)
CREATE TRIGGER trigger3 BEFORE
UPDATE on grade18 FOR EACH ROW BEGIN IF NEW.letter_grade NOT IN (
        "AS",
        "AA",
        "AB",
        "BB",
        "BC",
        "CC",
        "CD",
        "DD",
        "FP",
        "FA",
        "PP",
        "NP",
        "I",
        "X"
    ) THEN SIGNAL sqlstate '50001'
SET MESSAGE_TEXT = 'letter_grade invalid';
END IF;
END;
-- (ii)
CREATE TRIGGER trigger4
AFTER
UPDATE on grade18 FOR EACH ROW BEGIN
SET @semester = (
        SELECT semester
        FROM course18
        WHERE cid = NEW.cid
    );
UPDATE transcript
SET SPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester = @semester
            AND roll_number = NEW.roll_number and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = @semester;
UPDATE transcript
SET CPI = 0 + (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 1
            AND roll_number = NEW.roll_number and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 1;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 2
            AND roll_number = NEW.roll_number and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 2;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 3
            AND roll_number = NEW.roll_number and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 3;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 4
            AND roll_number = NEW.roll_number and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 4;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 5
            AND roll_number = NEW.roll_number and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 5;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 6
            AND roll_number = NEW.roll_number and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 6;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 7
            AND roll_number = NEW.roll_number and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 7;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 8
            AND roll_number = NEW.roll_number and c!=0
    )
WHERE roll_number = NEW.roll_number
    AND semester = 8;
SET @SPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester = @semester
            AND roll_number = NEW.roll_number
    );
SET @CPI = (
        SELECT (sum(value * c) / sum(c))
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= @semester
            AND roll_number = NEW.roll_number
    );
INSERT INTO trigger_log
VALUES(
        "UPDATE",
        NEW.roll_number,
        @semester,
        @SPI,
        @CPI
    );
END;
-- TASK 4c
CREATE TRIGGER trigger5
AFTER DELETE on grade18 FOR EACH ROW BEGIN
SET @semester = (
        SELECT semester
        FROM course18
        WHERE cid = OLD.cid
    );
UPDATE transcript
SET SPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester = @semester
            AND roll_number = OLD.roll_number
    )
WHERE roll_number = OLD.roll_number
    AND semester = @semester;
UPDATE transcript
SET CPI = 0 + (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 1
            AND roll_number = OLD.roll_number AND c!=0
    )
WHERE roll_number = OLD.roll_number
    AND semester = 1;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 2
            AND roll_number = OLD.roll_number and c!=0
    )
WHERE roll_number = OLD.roll_number
    AND semester = 2;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 3
            AND roll_number = OLD.roll_number and c!=0
    )
WHERE roll_number = OLD.roll_number
    AND semester = 3;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 4
            AND roll_number = OLD.roll_number and c!=0
    )
WHERE roll_number = OLD.roll_number
    AND semester = 4;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 5
            AND roll_number = OLD.roll_number and c!=0
    )
WHERE roll_number = OLD.roll_number
    AND semester = 5;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 6
            AND roll_number = OLD.roll_number and c!=0
    )
WHERE roll_number = OLD.roll_number
    AND semester = 6;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 7
            AND roll_number = OLD.roll_number and c!=0
    )
WHERE roll_number = OLD.roll_number
    AND semester = 7;
UPDATE transcript
SET CPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= 8
            AND roll_number = OLD.roll_number and c!=0
    )
WHERE roll_number = OLD.roll_number
    AND semester = 8;
SET @SPI = (
        SELECT sum(value * c) / sum(c)
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester = @semester
            AND roll_number = OLD.roll_number
    );
SET @CPI = (
        SELECT (sum(value * c) / sum(c))
        FROM grade18
            NATURAL JOIN course18
            NATURAL JOIN grade_point
        WHERE semester <= @semester
            AND roll_number = OLD.roll_number
    );
INSERT INTO trigger_log
VALUES(
        "DELETE",
        OLD.roll_number,
        @semester,
        @SPI,
        @CPI
    );
END;
load data local INFILE '/home/divyeshvankar/Desktop/grade18.csv' INTO TABLE grade18 FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';

UPDATE grade18 AS g 
JOIN u_grade18 AS u ON g.roll_number=u.roll_number AND g.cid=u.cid
SET g.letter_grade=u.letter_grade;

select * from grade18;

DELETE from grade18;UPDATE grade18 AS g 
JOIN u_grade18 AS u ON g.roll_number=u.roll_number AND g.cid=u.cid
SET g.letter_grade=u.letter_grade;



DELETE from grade18;