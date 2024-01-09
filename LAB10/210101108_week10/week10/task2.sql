use  week10;

CREATE Table student18(
    name char(100),
    roll_number char(10) primary key,
    cpi FLOAT DEFAULT 0.0
    
);

CREATE Table course18(
    semester INT,
    cid char(7) PRIMARY KEY,
    name char(100),
    l INT ,
    t INT ,
    p INT ,
    c INT
);

CREATE Table grade18(
    roll_number char(10),
    cid char(7),
    letter_grade char(2),
    PRIMARY KEY(roll_number, cid)
);

CREATE Table curriculum(
    dept char(4),
    number int,
    cid char(7)
);

CREATE Table grade_point(
    letter_grade char(2) PRIMARY KEY,
    value INT
);

CREATE Table trigger_log(
    my_action char(10),
    roll_number char(10),
    semester int,
    SPI DECIMAL(4,2),
    CPI DECIMAL(4,2),
    check (my_action in ('INSERT', 'UPDATE', 'DELETE'))
);

CREATE Table transcript(
    roll_number char(10),
    semester int,
    SPI DECIMAL(4,2),
    CPI DECIMAL(4,2)
);

CREATE Table u_grade18 like grade18;

set GLOBAL local_infile=1;

