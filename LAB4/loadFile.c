#include <stdio.h>
#include <mysql.h>

#include <string.h>
int main()
{
    char server[16] = "localhost";
    char username[16] = "DivyeshVankar";
    char password[16] = "Divyesh@2019";
    char database[16] = "week05";
    MYSQL* conn = mysql_init(NULL);
    if (conn == NULL) {
        printf("MySQL initialization failed");
        return 1;
    }
    if (mysql_real_connect(conn, server, username, password, database, 0, NULL, 0) == NULL) {
        printf("Unable to connect with MySQL server\n");
        mysql_close(conn);
        return 1;
    }
    if (mysql_query(conn, "CREATE TABLE Employee(Eid INT, Ename VARCHAR(16), Salary INT)")) {
        printf("Unable to create database table in MyDb database\n");
        mysql_close(conn);
        return 1;
    }
    if (mysql_query(conn, "insert into Employee values(101,'KIRAN', 10000)")) {
        printf("Unable to insert data into Employee table\n");
        mysql_close(conn);
        return 1;
    }
    if (mysql_query(conn, "Insert into Employee values(102,'SUMAN', 12000)")) {
        printf("Unable to insert data into Employee table\n");
        mysql_close(conn);
        return 1;
    }
    if (mysql_query(conn, "Insert into Employee values(103,'RAMAN', 16000)")) {
        printf("Unable to insert data into Employee table\n");
        mysql_close(conn);
        return 1;
    }
    mysql_close(conn);
    printf("Data inserted successfully\n");
    return 0;
}
