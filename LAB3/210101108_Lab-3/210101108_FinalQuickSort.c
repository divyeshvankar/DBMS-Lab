#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define MAX_STUDENTS 160
#define MAX_COURSES 100
int flag = 0;
struct course
{
    int sem;
    int L, T, P, C;
    char id[8];
    char title[59];
};
struct student
{
    char roll_no[15];
    char name[50];
};
struct student students[MAX_STUDENTS];
struct course courses[MAX_COURSES];
struct gra
{
    char roll_no[15];
    char name[50];
    char id[10];
    char course_name[59];
    char grade[5];
	int credits;
};
struct gra grades[MAX_STUDENTS * MAX_COURSES];
struct gra grades[MAX_STUDENTS * MAX_COURSES];
int partition(int low, int high)
{
    struct gra pivot = grades[high];
    int i = (low - 1);
    for (int j = low; j <= high - 1; j++)
    {
        if (strcmp(grades[j].name, pivot.name) < 0)
        {
            i++;
            struct gra temp = grades[i];
            grades[i] = grades[j];
            grades[j] = temp;
        }
        else if (strcmp(grades[j].name, pivot.name) == 0)
        {
			if(grades[j].credits > pivot.credits)
            {
                i++;
                struct gra temp = grades[i];
                grades[i] = grades[j];
                grades[j] = temp;
            }
			else if (grades[j].credits == pivot.credits)
            {
                if (strcmp(grades[j].grade, pivot.grade) < 0)
                {
                    i++;
                    struct gra temp = grades[i];
                    grades[i] = grades[j];
                    grades[j] = temp;
                }
            }
        }
    }
    struct gra temp = grades[i + 1];
    grades[i + 1] = grades[high];
    grades[high] = temp;
    return (i + 1);
}
void quickSort(int low, int high)
{
    if (low < high)
    {
        int pi = partition(low, high);
        quickSort(low, pi - 1);
        quickSort(pi + 1, high);
    }
}
int main()
{
	int Scount = 0;
	int Ccount = 0;
	int Gcount = 0;
    FILE *fin = NULL;
    FILE *fout = NULL;
    int n = 0;
    fin = fopen("students01.csv", "r");
    while (true)
    {
        char roll_no[15], name[50];
        for (int i = 0;; i++)
        {
            char c = fgetc(fin);
            if (c == EOF)
            {
                flag = 1;
                break;
            }
            if (c != ',' && c != '\n' && c != EOF)
            {
                name[i] = c;
            }
            else if (c == ',')
            {
                name[i] = '\0';
                break;
            }
            else if (c == EOF)
            {
                flag = 1;
            }
        }
        if (flag == 1)
        {
            break;
        }
        for (int i = 0;; i++)
        {
            char c = fgetc(fin);
            if (c == EOF)
            {
                flag = 1;
                break;
            }
            if (c != '\n' && c != EOF)
            {
                roll_no[i] = c;
            }
            else if (c == '\n')
            {
                roll_no[i] = '\0';
                break;
            }
            else if (c == EOF)
            {
                flag = 1;
            }
        }
        if (flag == 1)
        {
            break;
        }
        if (strlen(name) > 0)
        {	Scount++;
            strcpy(students[n].name, name);
            strcpy(students[n].roll_no, roll_no);
        }
        n++;
    }
    fclose(fin);
    fin = fopen("courses01.csv", "r");
    n = 0;
    flag = 0;
    while (true)
    {
        char sem[10], id[10], L[10], T[10], P[10], C[10], title[59];
        for (int i = 0;; i++)
        {
            char c = fgetc(fin);
            if (c == EOF)
            {
                flag = 1;
                break;
            }
            if (c != ',' && c != '\n' && c != EOF)
            {
                sem[i] = c;
            }
            else if (c == ',')
            {
                sem[i] = '\0';
                break;
            }
            else if (c == EOF)
            {
                flag = 1;
            }
        }
        if (flag == 1)
        {
            break;
        }
        for (int i = 0;; i++)
        {
            char c = fgetc(fin);
            if (c == EOF)
            {
                flag = 1;
                break;
            }
            if (c != ',' && c != '\n' && c != EOF)
            {
                id[i] = c;
            }
            else if (c == ',')
            {
                id[i] = '\0';
                break;
            }
            else if (c == EOF)
            {
                flag = 1;
            }
        }
        if (flag == 1)
        {
            break;
        }
        for (int i = 0;; i++)
        {
            char c = fgetc(fin);
            if (c == EOF)
            {
                flag = 1;
                break;
            }
            if (c != ',' && c != '\n' && c != EOF)
            {
                title[i] = c;
            }
            else if (c == ',')
            {
                title[i] = '\0';
                break;
            }
            else if (c == EOF)
            {
                flag = 1;
            }
        }
        if (flag == 1)
        {
            break;
        }
        for (int i = 0;; i++)
        {
            char c = fgetc(fin);
            if (c == EOF)
            {
                flag = 1;
                break;
            }
            if (c != ',' && c != '\n' && c != EOF)
            {
                L[i] = c;
            }
            else if (c == ',')
            {
                L[i] = '\0';
                break;
            }
            else if (c == EOF)
            {
                flag = 1;
            }
        }
        if (flag == 1)
        {
            break;
        }
        for (int i = 0;; i++)
        {
            char c = fgetc(fin);
            if (c == EOF)
            {
                flag = 1;
                break;
            }
            if (c != ',' && c != '\n' && c != EOF)
            {
                T[i] = c;
            }
            else if (c == ',')
            {
                T[i] = '\0';
                break;
            }
            else if (c == EOF)
            {
                flag = 1;
            }
        }
        if (flag == 1)
        {
            break;
        }
        for (int i = 0;; i++)
        {
            char c = fgetc(fin);
            if (c == EOF)
            {
                flag = 1;
                break;
            }
            if (c != ',' && c != '\n' && c != EOF)
            {
                P[i] = c;
            }
            else if (c == ',')
            {
                P[i] = '\0';
                break;
            }
            else if (c == EOF)
            {
                flag = 1;
            }
        }
        if (flag == 1)
        {
            break;
        }
        for (int i = 0;; i++)
        {
            char c = fgetc(fin);
            if (c == EOF)
            {
                flag = 1;
                break;
            }
            if (c != '\n' && c != EOF)
            {
                C[i] = c;
            }
            else if (c == '\n')
            {
                C[i] = '\0';
                break;
            }
            else if (c == EOF)
            {
                flag = 1;
            }
        }
        if (flag == 1)
        {
            break;
        }
        if (strlen(id) > 0)
        {	Ccount++;
            courses[n].sem = atoi(sem);
            courses[n].L = atoi(L);
            courses[n].T = atoi(T);
            courses[n].P = atoi(P);
            courses[n].C = atoi(C);
            strcpy(courses[n].id, id);
            strcpy(courses[n].title, title);
            n++;
        }
    }
    fclose(fin);
    fin = fopen("grades01.csv", "r");
    n = 0;
    flag = 0;
    char roll[10], id[10], g[5];
    while (true)
    {
        for (int i = 0;; i++)
        {
            char c = fgetc(fin);
            if (c == EOF)
            {
                flag = 1;
                break;
            }
            if (c != ',' && c != '\n' && c != EOF)
            {
                roll[i] = c;
            }
            else if (c == ',')
            {
                roll[i] = '\0';
                break;
            }
            else if (c == EOF)
            {
                flag = 1;
            }
        }
        if (flag == 1)
        {
            break;
        }
        for (int i = 0;; i++)
        {
            char c = fgetc(fin);
            if (c == EOF)
            {
                flag = 1;
                break;
            }
            if (c != ',' && c != '\n' && c != EOF && c != ' ')
            {
                id[i] = c;
            }
            else if (c == ' ')
            {
                i--;
            }
            else if (c == ',')
            {
                id[i] = '\0';
                break;
            }
            else if (c == EOF)
            {
                flag = 1;
            }
        }
        if (flag == 1)
        {
            break;
        }
        for (int i = 0;; i++)
        {
            char c = fgetc(fin);
            if (c == EOF)
            {
                flag = 1;
                break;
            }
            if (c != '\n' && c != EOF)
            {
                g[i] = c;
            }
            else if (c == '\n')
            {
                g[i] = '\0';
                break;
            }
            else if (c == EOF)
            {
                flag = 1;
            }
        }
        if (flag == 1)
        {
            break;
        }
        if (strlen(roll) > 0)
        {	Gcount++;
            strcpy(grades[n].roll_no, roll);
            strcpy(grades[n].id, id);
            strcpy(grades[n].grade, g);
            n++;
        }
    }
    fclose(fin);

    for (int i = 0; i < Scount; i++)
    {
        for (int k = 0; k < Gcount; k++)
        {
            if (strcmp(grades[k].roll_no, students[i].roll_no) == 0)
            {
                strcpy(grades[k].name, students[i].name);
            }
        }
    }
    for (int z = 0; z < Ccount; z++)
    {
        for (int k = 0; k < Gcount; k++)
        {
            if (strcmp(grades[k].id, courses[z].id) == 0)
            {
                strcpy(grades[k].course_name, courses[z].title);
				grades[k].credits = courses[z].C;
            }
        }
    }
    quickSort(0, Gcount - 1);
    fout = fopen("grades-sorted-Q.csv", "w");
    for (int j = 0; j < Gcount; j++)
    {
        fprintf(fout, "%s,%s,%d,%s\n", grades[j].name, grades[j].course_name,grades[j].credits,grades[j].grade);
    }
    fclose(fout);
    return 0;
}
