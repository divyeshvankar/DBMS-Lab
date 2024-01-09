#include <stdio.h>
int main()
{
    FILE *f1 = fopen("hss_electives.csv", "r");
    FILE *f2 = fopen("task2b.sql", "w");
    int sno;
    int roll_no;
    char cname[100], sname[50], cno[10];
    fprintf(f2, "INSERT INTO hss_table01(sno,roll_number,sname,cid,cname)\n");
    fprintf(f2, "VALUES\n");
    for (int i = 0; i < 1431; i++)
    {
        fscanf(f1, "%d,%d,%50[^,],%10[^,],%100[^\n]\n", &sno, &roll_no, sname, cno, cname);
        if (i == 1430)
            fprintf(f2, "('%d','%d','%s','%s','%s');\n", sno, roll_no, sname, cno, cname);
        else
            fprintf(f2, "('%d','%d','%s','%s','%s'),\n", sno, roll_no, sname, cno, cname);
    }
}