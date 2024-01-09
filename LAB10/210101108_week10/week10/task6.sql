-- task6
UPDATE grade18
SET letter_grade = (SELECT letter_grade FROM u_grade18 WHERE u_grade18.roll_number = grade18.roll_number and grade18.cid = u_grade18.cid)
WHERE EXISTS (SELECT * FROM u_grade18 WHERE u_grade18.roll_number = grade18.roll_number and grade18.cid = u_grade18.cid);

