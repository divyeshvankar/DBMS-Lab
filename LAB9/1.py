import sys
import mysql.connector
# Function to execute SQL queries and return results
def execute_query(sql_query, fetch_one=True):
    cursor = db.cursor()
    cursor.execute(sql_query)
    if fetch_one:
        result = cursor.fetchone()
    else:
        result = cursor.fetchall()
    cursor.close()
    return result
# Connect to the MySQL server
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Divyesh@2019",
    database="week09"
)

mycursor=db.cursor()
# Get roll number from command line argument
if len(sys.argv) < 2:
    print("Please provide roll number as argument.")
    sys.exit(1)
roll_number = sys.argv[1]
# print(roll_number)



# Subtask a: Print institute name
print(" Indian Institutte of Technology Guwahati")



# Subtask b: Print student information header
student_info_query = "SELECT name FROM student18 WHERE roll_number='{}'".format(roll_number)
student_name = execute_query(student_info_query)[0]
print("Student Name: ", student_name)
print("Roll Number: ", roll_number)
print("Semester     Course          CourseName                                                              Cr")





# Subtask c: Semester-wise transcript contents
semester_query = "SELECT DISTINCT semester FROM course18 "
semesters = execute_query(semester_query, False)
semesters.sort()
for semester in semesters:
    
    transcript_query = "SELECT semester,course18.cid, course18.name, grade18.letter_grade FROM course18 INNER JOIN grade18 ON course18.cid=grade18.cid WHERE grade18.roll_number='{}' AND course18.semester={}".format(roll_number, semester[0])
    transcript = execute_query(transcript_query, False)
    print("")
    for row in transcript:
        print(row[0], "             ", row[1], "           ", row[2],"                    ",row[3])

print("")


# Subtask d: Compute semester-wise SPI
# for semester in semesters:
#     semester_grade_query = "SELECT SUM(c*l), SUM(c*t), SUM(c*p), SUM(c) FROM course18 INNER JOIN grade18 ON course18.cid=grade18.cid WHERE grade18.roll_number='{}' AND course18.semester={}".format(roll_number, semester[0])
#     semester_grades = execute_query(semester_grade_query)
#     print("here:",semester_grades)
#     spi = round((semester_grades[0]+semester_grades[1]+semester_grades[2])/(semester_grades[3]), 2)
#     print("Semester {}: SPI = {}".format(semester[0], spi))


# task4d
print("\n")
mycursor.execute("select semester,sum(g_val*c)/sum(c) from course18 natural join grade18 natural join gradeval where roll_number=%s group by semester",(roll_number,))
myresult3=mycursor.fetchall()
for x in myresult3:
    print("Semester: "+str(x[0])+"  "+"SPI: "+str(x[1]))
# task4e
mycursor.execute("select sum(g_val*c)/sum(c) from course18 natural join grade18 natural join gradeval where roll_number=%s",(roll_number,))
myresult3=mycursor.fetchall()
for x in myresult3:
    print("CPI: "+str(x[0]))



# Subtask e: Compute semester-wise CPI
cumulative_grade_query = "SELECT SUM(c*l), SUM(c*t), SUM(c*p), SUM(c) FROM course18 INNER JOIN grade18 ON course18.cid=grade18.cid WHERE grade18.roll_number='{}'".format(roll_number)
cumulative_grades = execute_query(cumulative_grade_query)
cpi = round((cumulative_grades[0]+cumulative_grades[1]+cumulative_grades[2])/(cumulative_grades[3]*10), 2)
print("CPI: ", cpi)






# Subtask f: Check core courses for each semester
# for semester in semesters:
#     core_courses_query = "SELECT cid FROM curriculum WHERE dept='CSE' AND ((semester=1 AND cid!='HS101') OR (semester=2 AND cid NOT LIKE 'SA1%') OR (semester=3 AND cid NOT LIKE 'SA2%' AND cid!='HS200') OR (semester=4


