import mysql.connector
import sys

#Question 4

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="Divyesh@2019",
  database="week09"
)

mycursor = mydb.cursor()

#a
print("Indian Institutte of Technology Guwahati\n")
print("Programme Duration: 4 years                      Semesters:Eight(8)\n")

#b
rollno = str(sys.argv[1])

sql = ("SELECT name FROM student18 WHERE roll_number ='"+str(sys.argv[1])+"';")

mycursor.execute(sql)

myresult = mycursor.fetchone()

print("Name:  %20s                    Roll Number: %s\n"%(myresult[0],str(sys.argv[1])))

print("Semester     Course          CourseName  \t\t\t\t\t Cr")
#c
sql = "Select semester ,course18.cid, course18.name, letter_grade\
      From  grade18 Natural Join course18 \
        Where roll_number ='%s'\
        Order by semester"%(rollno)

mycursor.execute(sql)

myresult = mycursor.fetchall()

for x in myresult:
    print("%-14s%-16s%-50s%2s"%(x[0],x[1],x[2],x[3]))
#d
for semester in range(1, 9):
    mycursor.execute(f"SELECT SUM(c * CASE letter_grade WHEN 'AA' THEN 10 WHEN 'AB' THEN 9 WHEN 'BB' THEN 8 WHEN 'BC' THEN 7 WHEN 'CC' THEN 6 WHEN 'CD' THEN 5 WHEN 'DD' THEN 4 ELSE 0 END) AS total_grade_points, SUM(c) AS total_credits FROM grade18 JOIN course18 ON grade18.cid = course18.cid WHERE roll_number = '{rollno}' AND semester = {semester}")
    total_grade_points, total_credits = mycursor.fetchone()
    print("Semester: %d SPI: %4.2f"%(semester,total_grade_points/total_credits))

print("")
#e
for semester in range(1, 9):
    mycursor.execute(f"SELECT SUM(c * CASE letter_grade WHEN 'AA' THEN 10 WHEN 'AB' THEN 9 WHEN 'BB' THEN 8 WHEN 'BC' THEN 7 WHEN 'CC' THEN 6 WHEN 'CD' THEN 5 WHEN 'DD' THEN 4 ELSE 0 END) AS total_grade_points, SUM(c) AS total_credits FROM grade18 JOIN course18 ON grade18.cid = course18.cid WHERE roll_number = '{rollno}' AND semester <= {semester}")
    total_grade_points, total_credits = mycursor.fetchone()
    print("Semester: %d CPI: %4.2f"%(semester,total_grade_points/total_credits))

mycursor.execute(f"SELECT SUM(c * CASE letter_grade WHEN 'AA' THEN 10 WHEN 'AB' THEN 9 WHEN 'BB' THEN 8 WHEN 'BC' THEN 7 WHEN 'CC' THEN 6 WHEN 'CD' THEN 5 WHEN 'DD' THEN 4 ELSE 0 END) AS total_grade_points, SUM(c) AS total_credits FROM grade18 JOIN course18 ON grade18.cid = course18.cid WHERE roll_number = '{rollno}'")
total_grade_points, total_credits = mycursor.fetchone()
print("Total CPI: %4.2f"%(total_grade_points/total_credits))

print("")
#f
for semester in range(1, 9):
    mycursor.execute(f" select Count(cid) as cn  from (Select cid From curriculum \
                     Where number = {semester} And !(cid Like 'HS101' Or cid like 'SA1__'or cid like 'SA2__' or cid like 'HS200' or cid like 'HS1__' or cid like 'SA3__' or (cid like '%M' and !(cid like'XX101M'))or cid like 'SA4__' or cid like 'CS498' or cid like 'CS499')\
                     except\
                     (Select cid from grade18 where roll_number = '{rollno}'))as derived;")
    result = mycursor.fetchone()
    if result[0]==0:
        print(f"For semester {semester} completed all courses : True")
    else:
        print(f"For semester {semester} completed all courses : False")


print("")
#g
for semester in range(1, 9):
    mycursor.execute(f" select Count(cid) as cn  from (Select cid From curriculum \
                     Where number = {semester} And (cid like 'CS5%' or cid like 'CSxxx')\
                     except\
                     (Select cid from grade18 where roll_number = '{rollno}'))as derived;")
    result = mycursor.fetchone()
    if result[0]==0:
        print(f"For semester {semester} completed all elective : True")
    else:
        print(f"For semester {semester} completed all elective : False")

print("")
#h
for semester in range(1, 9):
    mycursor.execute(f" select Count(cid) as cn  from (Select cid From curriculum \
                     Where number = {semester} And (cid like '%M')\
                     except\
                     (Select cid from grade18 where roll_number = '{rollno}'))as derived;")
    result = mycursor.fetchone()
    if result[0]==0:
        print(f"For semester {semester} completed all Minor: True")
    else:
        print(f"For semester {semester} completed all Minor : False")

print("")
#i
for semester in range(1, 9):
    mycursor.execute(f" select Count(cid) as cn  from (Select cid From curriculum \
                     Where number = {semester} And (cid like 'OE%')\
                     except\
                     (Select cid from grade18 where roll_number = '{rollno}'))as derived;")
    result = mycursor.fetchone()
    if result[0]==0:
        print(f"For semester {semester} completed all Open Electives: True")
    else:
        print(f"For semester {semester} completed all Open Electives: False")

print("")
#j
for semester in range(1, 9):
    mycursor.execute(f" select Count(cid) as cn  from (Select cid From curriculum \
                     Where number = {semester} And (cid like 'HS%')\
                     except\
                     (Select cid from grade18 where roll_number = '{rollno}'))as derived;")
    result = mycursor.fetchone()
    if result[0]==0:
        print(f"For semester {semester} completed all HSS: True")
    else:
        print(f"For semester {semester} completed all HSS: False")

print("")
#k
for semester in range(1, 9):
    mycursor.execute(f" select Count(cid) as cn  from (Select cid From curriculum \
                     Where number = {semester} And (cid like 'SA%')\
                     except\
                     (Select cid from grade18 where roll_number = '{rollno}'))as derived;")
    result = mycursor.fetchone()
    if result[0]==0:
        print(f"For semester {semester} completed all SA: True")
    else:
        print(f"For semester {semester} completed all SA: False")

print("")
#l
for semester in range(1, 9):
    mycursor.execute(f" select Count(cid) as cn  from (Select grade18.cid from grade18 join course18 on grade18.cid = course18.cid WHERE roll_number = '{rollno}' AND semester = {semester} And letter_grade like 'FF') as derived")
    result = mycursor.fetchone()
    if result[0]==0:
        print(f"For semester {semester} Passed: True")
    else:
        print(f"For semester {semester} Passed: False")

print("")
#m
for semester in range(1, 9):
    mycursor.execute(f" select Count(cid) as cn  from (Select grade18.cid from grade18 join course18 on grade18.cid = course18.cid WHERE roll_number = '{rollno}' AND semester = {semester} And letter_grade like 'FF' And grade18.cid like 'SA%') as derived")
    result = mycursor.fetchone()
    if result[0]==0:
        print(f"For semester {semester} SA Passed: True")
    else:
        print(f"For semester {semester} SA Passed: False")

