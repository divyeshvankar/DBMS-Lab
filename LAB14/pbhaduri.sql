-- Active: 1682330587543@@127.0.0.1@3306@week14a
-- 6th b 
use week14a;

LOCK TABLES account WRITE;
CALL transfer_funds_1(06428,15873,5000 );
UNLOCK TABLES;
CALL main_transfer_2();



-- 6th c 




LOCK TABLES account WRITE;

CALL transfer_funds_1(00002,00003,10005);

UNLOCK TABLES;

CALL main_transfer_2();
