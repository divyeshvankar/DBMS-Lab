-- 4a(trigger inserting)

-- 1

CREATE Trigger grade18_before_insert BEFORE INSERT ON grade18 FOR EACH ROW
BEGIN 
    IF NEW.letter_grade NOT IN ('AS', 'AA', 'AB', 'BB', 'BC', 'CC', 'CD', 'DD', 'FP', 'FA', 'PP', 'NP', 'I', 'X')
    THEN
        SIGNAL SQLSTATE '50001' SET MESSAGE_TEXT = 'INVALID LETTER GRADE, ALLOWED LETTER GRADES ARE AS, AA, AB, BB, BC, CC, CD, DD, FP, FA, PP, NP, I, X';
    END IF;
END;

-- INSERT INTO grade18 values ('210101035', '1234567', 'ac');

-- 2(i)

DROP TRIGGER trigger5 ;
CREATE TRIGGER trigger2 AFTER INSERT on grade18 FOR EACH ROW

    BEGIN
        SET @semester = (SELECT semester
        FROM course18
        WHERE cid = NEW.cid );
        UPDATE transcript

        SET SPI = (SELECT sum( value*c )/sum(c)
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester = @semester AND roll_number = NEW.roll_number and c!=0 )
        WHERE roll_number = NEW.roll_number AND semester = @semester ;

        UPDATE transcript
        SET CPI = 0 + (SELECT sum( value*c )/sum(c)
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester <=1 AND roll_number = NEW.roll_number and c!=0)
        WHERE roll_number = NEW.roll_number AND semester = 1 ;

        UPDATE transcript
        SET CPI = (SELECT sum( value*c )/sum(c)
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester <=2 AND roll_number = NEW.roll_number and c!=0)
        WHERE roll_number = NEW.roll_number AND semester = 2 ;

        UPDATE transcript
        SET CPI = (SELECT sum( value*c )/sum(c)
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester <=3 AND roll_number = NEW.roll_number and c!=0)
        WHERE roll_number = NEW.roll_number AND semester = 3 ;

        UPDATE transcript
        SET CPI = (SELECT sum( value*c )/sum(c)
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester <=4 AND roll_number = NEW.roll_number and c!=0)
        WHERE roll_number = NEW.roll_number AND semester = 4 ;

        UPDATE transcript
        SET CPI = (SELECT sum( value*c )/sum(c)
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester <=5 AND roll_number = NEW.roll_number and c!=0)
        WHERE roll_number = NEW.roll_number AND semester = 5 ;

        UPDATE transcript
        SET CPI = (SELECT sum( value*c )/sum(c)
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester <=6 AND roll_number = NEW.roll_number and c!=0)
        WHERE roll_number = NEW.roll_number AND semester = 6 ;

        UPDATE transcript
        SET CPI = (SELECT sum( value*c )/sum(c)
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester <=7 AND roll_number = NEW.roll_number and c!=0)
        WHERE roll_number = NEW.roll_number AND semester = 7 ;

        UPDATE transcript
        SET CPI = (SELECT sum( value*c )/sum(c)
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester <=8 AND roll_number = NEW.roll_number and c!=0)
        WHERE roll_number = NEW.roll_number AND semester = 8 ;


        SET @SPI = (SELECT sum( value*c )/sum(c)
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester = @semester AND roll_number = NEW.roll_number) ;

        SET @CPI = (SELECT (sum( value*c )/sum(c))
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester <= @semester AND roll_number = NEW.roll_number) ;
-- 2(ii)
        INSERT INTO trigger_log VALUES("INSERT" , NEW.roll_number, @semester ,@SPI , @CPI );
    END ;


DELETE FROM grade18 ;
INSERT INTO grade18 VALUES('180101078' , 'MA101','AA');
INSERT INTO grade18 VALUES('180101078' , 'CH101','BB');


--4b (trigger updating)

--1
CREATE TRIGGER trigger3 BEFORE UPDATE on grade18
FOR EACH ROW
    BEGIN
        IF NEW.letter_grade NOT IN ("AS", "AA", "AB", "BB", "BC", "CC", "CD", "DD", "FP", "FA", "PP", "NP", "I", "X") THEN
        SIGNAL sqlstate '50001' SET MESSAGE_TEXT = 'LETTER GRADE INVALID' ;
        END IF ;
    END;

--2(i)

CREATE TRIGGER trigger4 AFTER UPDATE on grade18
FOR EACH ROW
    BEGIN
        SET @semester = (SELECT semester
        FROM course18
        WHERE cid = NEW.cid );
        UPDATE transcript
        SET SPI = (SELECT sum( value*c )/sum(c)
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester = @semester AND roll_number = NEW.roll_number and c!=0)
        WHERE roll_number = NEW.roll_number AND semester = @semester ;

        UPDATE transcript
        SET CPI = 0 + (SELECT sum( value*c )/sum(c)
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester <=1 AND roll_number = NEW.roll_number and c!=0)
        WHERE roll_number = NEW.roll_number AND semester = 1 ;

        UPDATE transcript
        SET CPI = (SELECT sum( value*c )/sum(c)
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester <=2 AND roll_number = NEW.roll_number and c!=0)
        WHERE roll_number = NEW.roll_number AND semester = 2 ;

        UPDATE transcript
        SET CPI = (SELECT sum( value*c )/sum(c)
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester <=3 AND roll_number = NEW.roll_number and c!=0)
        WHERE roll_number = NEW.roll_number AND semester = 3 ;

        UPDATE transcript
        SET CPI = (SELECT sum( value*c )/sum(c)
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester <=4 AND roll_number = NEW.roll_number and c!=0)
        WHERE roll_number = NEW.roll_number AND semester = 4 ;

        UPDATE transcript
        SET CPI = (SELECT sum( value*c )/sum(c)
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester <=5 AND roll_number = NEW.roll_number and c!=0)
        WHERE roll_number = NEW.roll_number AND semester = 5 ;

        UPDATE transcript
        SET CPI = (SELECT sum( value*c )/sum(c)
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester <=6 AND roll_number = NEW.roll_number and c!=0)
        WHERE roll_number = NEW.roll_number AND semester = 6 ;

        UPDATE transcript
        SET CPI = (SELECT sum( value*c )/sum(c)
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester <=7 AND roll_number = NEW.roll_number and c!=0)
        WHERE roll_number = NEW.roll_number AND semester = 7 ;

        UPDATE transcript
        SET CPI = (SELECT sum( value*c )/sum(c)
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester <=8 AND roll_number = NEW.roll_number and c!=0)
        WHERE roll_number = NEW.roll_number AND semester = 8 ;

        SET @SPI = (SELECT sum( value*c )/sum(c)
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester = @semester AND roll_number = NEW.roll_number) ;

        SET @CPI = (SELECT (sum( value*c )/sum(c))
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester <= @semester AND roll_number = NEW.roll_number) ;

-- 2(ii)
        INSERT INTO trigger_log VALUES("UPDATE" , NEW.roll_number, @semester ,@SPI , @CPI );
    END ;



--4c(trigger deletion)

-- 1(i)
CREATE TRIGGER trigger5 AFTER DELETE on grade18
FOR EACH ROW
    BEGIN
        SET @semester = (SELECT semester
        FROM course18
        WHERE cid = OLD.cid );
        UPDATE transcript
        SET SPI = (SELECT sum( value*c )/sum(c)
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester = @semester AND roll_number = OLD.roll_number and c!=0)
        WHERE roll_number = OLD.roll_number AND semester = @semester ;

        UPDATE transcript
        SET CPI = 0 + (SELECT sum( value*c )/sum(c)
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester <=1 AND roll_number = OLD.roll_number and c!=0)
        WHERE roll_number = OLD.roll_number AND semester = 1 ;

        UPDATE transcript
        SET CPI = (SELECT sum( value*c )/sum(c)
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester <=2 AND roll_number = OLD.roll_number and c!=0)
        WHERE roll_number = OLD.roll_number AND semester = 2 ;

        UPDATE transcript
        SET CPI = (SELECT sum( value*c )/sum(c)
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester <=3 AND roll_number = OLD.roll_number and c!=0)
        WHERE roll_number = OLD.roll_number AND semester = 3 ;

        UPDATE transcript
        SET CPI = (SELECT sum( value*c )/sum(c)
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester <=4 AND roll_number = OLD.roll_number and c!=0)
        WHERE roll_number = OLD.roll_number AND semester = 4 ;

        UPDATE transcript
        SET CPI = (SELECT sum( value*c )/sum(c)
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester <=5 AND roll_number = OLD.roll_number and c!=0)
        WHERE roll_number = OLD.roll_number AND semester = 5 ;

        UPDATE transcript
        SET CPI = (SELECT sum( value*c )/sum(c)
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester <=6 AND roll_number = OLD.roll_number and c!=0)
        WHERE roll_number = OLD.roll_number AND semester = 6 ;

        UPDATE transcript
        SET CPI = (SELECT sum( value*c )/sum(c)
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester <=7 AND roll_number = OLD.roll_number and c!=0)
        WHERE roll_number = OLD.roll_number AND semester = 7 ;

        UPDATE transcript
        SET CPI = (SELECT sum( value*c )/sum(c)
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester <=8 AND roll_number = OLD.roll_number and c!=0)
        WHERE roll_number = OLD.roll_number AND semester = 8 ;

        SET @SPI = (SELECT sum( value*c )/sum(c)
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester = @semester AND roll_number = OLD.roll_number) ;

        SET @CPI = (SELECT (sum( value*c )/sum(c))
        FROM grade18 NATURAL JOIN course18 NATURAL JOIN grade_point
        WHERE semester <= @semester AND roll_number = OLD.roll_number) ;

-- 1(ii)
        INSERT INTO trigger_log VALUES("DELETE" , OLD.roll_number, @semester ,@SPI , @CPI );
    END ;




