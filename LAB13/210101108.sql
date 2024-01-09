-- Active: 1675678875828@@127.0.0.1@3306@week13
create DATABASE week13;
USE week13;
CREATE TABLE location (
    location_id INT NOT NULL,
    city VARCHAR(10) NULL,
    state VARCHAR(2) NULL,
    country VARCHAR(20) NULL,
    PRIMARY KEY (location_id)
);
SELECT *
from location;
CREATE TABLE product (
    product_id INT NOT NULL,
    product_name VARCHAR(10) NULL,
    category VARCHAR(2) NULL,
    price INT NULL,
    PRIMARY KEY (product_id)
);
SELECT *
from product;
CREATE TABLE sale (
    product_id INT NOT NULL,
    time_id INT NOT NULL,
    location_id INT NOT NULL,
    sales INT NULL,
    PRIMARY KEY (product_id, time_id, location_id)
);
SELECT *
from sale;
set GLOBAL local_infile = 1;
load data local INFILE '/home/divyeshvankar/Desktop/DBMS/LAB13/location.csv' INTO TABLE location FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;
load data local INFILE '/home/divyeshvankar/Desktop/DBMS/LAB13/product.csv' INTO TABLE product FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;
load data local INFILE '/home/divyeshvankar/Desktop/DBMS/LAB13/sale.csv' INTO TABLE sale FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;
-- 4-a 
CREATE Table year_state_01(year char(10), WI INT, CA INT, Total INT);
INSERT INTO year_state_01
values ('1995', 0, 0, 0),
    ('1996', 0, 0, 0),
    ('1997', 0, 0, 0),
    ('Total', 0, 0, 0);
SELECT *
FROM year_state_01;
-- i 
Update year_state_01
set WI = (
        SELECT SUM(sales)
        FROM sale as s
            JOIN location as l ON s.location_id = l.location_id
        WHERE l.state = 'WI'
            AND s.time_id = 1995
    )
where year = '1995';
SELECT *
FROM year_state_01;
-- ii
Update year_state_01
set WI = (
        SELECT SUM(sales)
        FROM sale as s
            JOIN location as l ON s.location_id = l.location_id
        WHERE l.state = 'WI'
            AND s.time_id = 1996
    )
where year = '1996';
SELECT *
FROM year_state_01;
-- iii
Update year_state_01
set WI = (
        SELECT SUM(sales)
        FROM sale as s
            JOIN location as l ON s.location_id = l.location_id
        WHERE l.state = 'WI'
            AND s.time_id = 1997
    )
where year = '1997';
SELECT *
FROM year_state_01;
-- iv
Update year_state_01
set WI = (
        SELECT SUM(sales)
        FROM sale as s
            JOIN location as l ON s.location_id = l.location_id
        WHERE l.state = 'WI'
            AND s.time_id in (1995, 1996, 1997)
    )
where year = 'Total';
SELECT *
FROM year_state_01;
-- v
Update year_state_01
set CA = (
        SELECT SUM(sales)
        FROM sale as s
            JOIN location as l ON s.location_id = l.location_id
        WHERE l.state = 'CA'
            AND s.time_id = 1995
    )
where year = '1995';
SELECT *
FROM year_state_01;
-- vi
Update year_state_01
set CA = (
        SELECT SUM(sales)
        FROM sale as s
            JOIN location as l ON s.location_id = l.location_id
        WHERE l.state = 'CA'
            AND s.time_id = 1996
    )
where year = '1996';
SELECT *
FROM year_state_01;
-- vii
Update year_state_01
set CA = (
        SELECT SUM(sales)
        FROM sale as s
            JOIN location as l ON s.location_id = l.location_id
        WHERE l.state = 'CA'
            AND s.time_id = 1997
    )
where year = '1997';
SELECT *
FROM year_state_01;
-- viii
Update year_state_01
set CA = (
        SELECT SUM(sales)
        FROM sale as s
            JOIN location as l ON s.location_id = l.location_id
        WHERE l.state = 'CA'
            AND s.time_id in (1995, 1996, 1997)
    )
where year = 'Total';
SELECT *
FROM year_state_01;
-- ix
Update year_state_01
set Total = (
        SELECT SUM(sales)
        FROM sale as s
            JOIN location as l ON s.location_id = l.location_id
        WHERE l.state in ('WI', 'CA')
            AND s.time_id = 1995
    )
where year = '1995';
SELECT *
FROM year_state_01;
-- x
Update year_state_01
set Total = (
        SELECT SUM(sales)
        FROM sale as s
            JOIN location as l ON s.location_id = l.location_id
        WHERE l.state in ('WI', 'CA')
            AND s.time_id = 1996
    )
where year = '1996';
SELECT *
FROM year_state_01;
-- xi
Update year_state_01
set Total = (
        SELECT SUM(sales)
        FROM sale as s
            JOIN location as l ON s.location_id = l.location_id
        WHERE l.state in ('WI', 'CA')
            AND s.time_id = 1997
    )
where year = '1997';
SELECT *
FROM year_state_01;
-- xii
Update year_state_01
set Total = (
        SELECT SUM(sales)
        FROM sale as s
            JOIN location as l ON s.location_id = l.location_id
        WHERE l.state in ('WI', 'CA')
            AND s.time_id in (1995, 1996, 1997)
    )
where year = 'Total';
SELECT *
FROM year_state_01;
SELECT *
FROM year_state_01;














-- 4-b
create table year_state_02_01 as (
    select time_id as year,
        SUM(
            CASE
                when state = 'WI' then sales
                else 0
            end
        ) as WI,
        SUM(
            CASE
                when state = 'CA' then sales
                else 0
            end
        ) as CA
    from sale
        natural join location
    group by year
);

SELECT * FROM year_state_02_01;
CREATE Table year_state_02_02 as (
    select sum(WI + CA) as Total
    from year_state_02_01
    group by year
);
SELECT * FROM year_state_02_02;

create Table year_state_02_03 as (
    select sum(WI) as sum_wi,
        sum(CA) as sum_ca
    from year_state_02_01
);

SELECT * FROM year_state_02_03;

create Table year_state_02_04 as (
    select sum(Total)
    from year_state_02_02
);

SELECT * FROM year_state_02_04;

-- 4-c
CREATE TABLE year_state_03 AS(
    SELECT time_id,
        SUM(
            CASE
                WHEN state = 'WI' THEN sales
                ELSE 0
            END
        ) AS WI,
        SUM(
            CASE
                WHEN state = 'CA' THEN sales
                ELSE 0
            END
        ) AS CA,
        SUM(sales) AS Total
    FROM sale
        NATURAL JOIN location
    GROUP BY time_id
    UNION
    SELECT "Total",
        SUM(
            CASE
                WHEN state = 'WI' THEN sales
                ELSE 0
            END
        ) AS WI,
        SUM(
            CASE
                WHEN state = 'CA' THEN sales
                ELSE 0
            END
        ) AS CA,
        SUM(sales) AS Total
    FROM sale
        NATURAL JOIN location
);

SELECT * FROM year_state_03;

-- 4-d
create table year_state_04 as
select case
        when grouping (time_id) = 1 then "Total"
        else time_id
    end time_id,
    sum(
        case
            when state = "WI" then sales
            else 0
        end
    ) as WI,
    sum(
        case
            when state = "CA" then sales
            else 0
        end
    ) as CA,
    sum(sales) as Total
from sale
    natural join location
group by time_id with rollup;
select *
from year_state_04;