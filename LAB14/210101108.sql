-- Active: 1675678875828@@127.0.0.1@3306@week14a
CREATE DATABASE week14a;
use week14a;
CREATE TABLE account (
    account_number varchar(5) PRIMARY KEY,
    balance INT,
    original_balance INT
);
CREATE TABLE move_funds (
    from_acc varchar(5),
    to_acc varchar(5),
    transfer_amount INT,
    FOREIGN KEY (from_acc) REFERENCES account(account_number),
    FOREIGN KEY (to_acc) REFERENCES account(account_number)
);
CREATE TABLE move_funds_log (
    account_number varchar(5),
    move_fund_type varchar(10) CHECK (move_fund_type IN ('deposit', 'withdraw')),
    amount INT,
    timestamp DATETIME,
    FOREIGN KEY (account_number) REFERENCES account(account_number)
);
set GLOBAL local_infile = 1;
load data local INFILE '/home/divyeshvankar/Desktop/DBMS/LAB14/account.csv' INTO TABLE account FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;
load data local INFILE '/home/divyeshvankar/Desktop/DBMS/LAB14/trnx.csv' INTO TABLE move_funds FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

-- CREATE USER 'saradhi' @'localhost' IDENTIFIED BY 'Divyesh@2019';
-- CREATE USER 'pbhaduri' @'localhost' IDENTIFIED BY 'Divyesh@2019';






-- 5th
GRANT SELECT,
    INSERT,
    UPDATE,
    DELETE
    ON week14a.account TO 'saradhi' @'localhost';
GRANT SELECT,
    INSERT,
    UPDATE,
    DELETE ON week14a.move_funds TO 'saradhi' @'localhost';
GRANT SELECT,
    INSERT,
    UPDATE,
    DELETE ON week14a.move_funds_log TO 'saradhi' @'localhost';
GRANT SELECT,
    INSERT,
    UPDATE,
    DELETE ON week14a.account TO 'pbhaduri' @'localhost';
GRANT SELECT,
    INSERT,
    UPDATE,
    DELETE ON week14a.move_funds TO 'pbhaduri' @'localhost';
GRANT SELECT,
    INSERT,
    UPDATE,
    DELETE ON week14a.move_funds_log TO 'pbhaduri' @'localhost';

GRANT LOCK TABLES ON week14a.* TO 'saradhi'@'localhost';
GRANT LOCK TABLES ON week14a.* TO 'pbhaduri' @'localhost';






-- 6th

-- a
CREATE PROCEDURE transfer_funds_1(IN from_acc CHAR(5), IN to_acc CHAR(5), IN transfer_amount INT)
BEGIN
    START TRANSACTION;
    UPDATE account SET balance = balance - transfer_amount WHERE account_number = from_acc;
    UPDATE account SET balance = balance + transfer_amount WHERE account_number = to_acc;
    COMMIT;
END ;


GRANT EXECUTE ON PROCEDURE week14a.transfer_funds_1 TO 'saradhi'@'localhost';
GRANT EXECUTE ON PROCEDURE week14a.transfer_funds_1 TO 'pbhaduri'@'localhost';

-- b
-- run as other user
LOCK TABLES account WRITE;
CALL transfer_funds_1('06428','15873',500);
UNLOCK TABLES;



-- c
LOCK TABLES account WRITE;
CALL transfer_funds_1('52149','15873',250);
UNLOCK TABLES;




-- 7th 


CREATE PROCEDURE transfer_funds_2(
    IN from_acc CHAR(5),
    IN to_acc CHAR(5),
    IN transfer_amount INT
) BEGIN START TRANSACTION;
IF (
    SELECT balance
    FROM account
    WHERE account_number = from_acc
) >= 100 THEN
UPDATE account
SET balance = balance - transfer_amount
WHERE account_number = from_acc;
UPDATE account
SET balance = balance + transfer_amount
WHERE account_number = to_acc;
INSERT INTO move_funds_log VALUES (from_acc, 'withdraw', transfer_amount, NOW());
INSERT INTO move_funds_log VALUES (to_acc, 'deposit', transfer_amount, NOW());
COMMIT;
ELSE ROLLBACK;
END IF;
END ;


GRANT EXECUTE ON PROCEDURE transfer_funds_2 to 'pbhaduri'@'localhost'; 
GRANT EXECUTE ON PROCEDURE transfer_funds_2 to 'saradhi'@'localhost';


-- 8
DELIMITER $$ CREATE PROCEDURE main_transfer_2() BEGIN
DECLARE done INT DEFAULT FALSE;
DECLARE cur_from_acc,
    cur_to_acc VARCHAR(5);
DECLARE cur_transfer_amount INT;
DECLARE cur_move_funds CURSOR FOR
SELECT from_acc,
    to_acc,
    transfer_amount
FROM move_funds;
DECLARE CONTINUE HANDLER FOR NOT FOUND
SET done = TRUE;
OPEN cur_move_funds;
read_loop: LOOP FETCH cur_move_funds INTO cur_from_acc,
cur_to_acc,
cur_transfer_amount;
IF done THEN LEAVE read_loop;
END IF;
CALL transfer_funds_2(cur_from_acc, cur_to_acc, cur_transfer_amount);
END LOOP;
CLOSE cur_move_funds;
END $$ DELIMITER;

-- 9

CALL main_transfer_2();


-- 10
-- a 

SELECT account_number,
    SUM(amount) as total_withdraw
FROM move_funds_log
WHERE move_fund_type = 'withdraw'
GROUP BY account_number;

-- b

SELECT account_number,
    SUM(amount) as total_deposit
FROM move_funds_log
WHERE move_fund_type = 'deposit'
GROUP BY account_number;


-- c
SELECT* from `account`;


SELECT a.account_number,
    a.original_balance as balance,
    
    b.total_deposit,
    c.total_withdraw,
    a.balance as original_balance
    -- a.original_balance = a.balance + b.total_deposit - c.total_withdraw as integrity_check
FROM account a
    JOIN (
        SELECT account_number,
            SUM(amount) as total_deposit
        FROM move_funds_log
        WHERE move_fund_type = 'deposit'
        GROUP BY account_number
    ) b ON a.account_number = b.account_number
    JOIN (
        SELECT account_number,
            SUM(amount) as total_withdraw
        FROM move_funds_log
        WHERE move_fund_type = 'withdraw'
        GROUP BY account_number
    ) c ON a.account_number = c.account_number;



