

LOAD DATA LOCAL infile '/home/divyeshvankar/Desktop/student18.csv' INTO TABLE student18 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';
LOAD DATA LOCAL infile '/home/divyeshvankar/Desktop/course18.csv' INTO TABLE course18 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';
LOAD DATA LOCAL infile '/home/divyeshvankar/Desktop/curriculum.csv' INTO TABLE curriculum FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';
LOAD DATA LOCAL infile '/home/divyeshvankar/Desktop/u_grade18.csv' INTO TABLE u_grade18 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';
LOAD DATA LOCAL infile '/home/divyeshvankar/Desktop/transcript.csv' INTO TABLE transcript FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';

insert into grade_point(letter_grade, value)
    values('AS',10 ),
            ('AA',10 ),
            ('AB',9 ),
            ('BB',8 ),
            ('BC',7 ),
            ('CC',6 ),
            ('CD',5 ),
            ('DD',4 ),
            ('FP',0 ),
            ('FA',0 ),
            ('I',0 ),
            ('X',0 ),
            ('PP',0 ),
            ('NP',0 );
