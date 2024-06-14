SELECT * FROM INFO;
SELECT * FROM AUTH;

--INNER JOIN : ���� �� ���� �����ʹ� ������ ����
SELECT *
FROM INFO /*INNER*/ JOIN AUTH
ON INFO.AUTH_ID=AUTH.AUTH_ID;

SELECT INFO.ID,
        INFO.TITLE,
        INFO.CONTENT,
        INFO.AUTH_ID, --AUTH_ID�� ������ �� �ִ� KEY, ���̺�.�÷��� �����ؾ� �Ѵ�.
        AUTH.NAME
FROM INFO /*INNER*/ JOIN AUTH
ON INFO.AUTH_ID=AUTH.AUTH_ID;
--���̺� ALIAS
SELECT I.ID,
        I.TITLE,
        A.AUTH_ID,
        A.NAME,
        A.JOB
FROM INFO I
INNER JOIN AUTH A
ON I.AUTH_ID = A.AUTH_ID;

--������ Ű�� ���ٸ� USING���� ��� ����
SELECT *
FROM INFO I
INNER JOIN AUTH A
USING (AUTH_ID);

-----------------------------------------------------
--OUTER JOIN
--LEFT OUTER JOIN (OUTER ��������) : �������̺��� ������ �ż�, ���� ���̺��� �� ����

SELECT * FROM INFO I LEFT OUTER JOIN AUTH A ON I.AUTH_ID=A.AUTH_ID;

--RIGHT OUTER JOIN : ���������̺��� ������ �ż�, ���������̺��� �� ����
SELECT * FROM INFO I RIGHT OUTER JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;

--RIGHT������ ���̺� �ڸ��� �ٲٸ� LEFT JOIN
SELECT * FROM AUTH A RIGHT OUTER JOIN INFO I ON A.AUTH_ID = I.AUTH_ID;

--FULL OUTER JOIN : ���� ������ �������� �� ����
SELECT * FROM INFO I FULL OUTER JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;

--CROSS JOIN(�߸��� ������ ����; ���� �� ���� ����)
SELECT * FROM INFO I CROSS JOIN AUTH A;

---------------------------------------------------------------
--SELF JOIN(�ϳ��� ���̺��� ������ ������ �Ŵ� ��)
SELECT * FROM EMPLOYEES;

SELECT * 
FROM EMPLOYEES E 
LEFT JOIN EMPLOYEES E2
ON E.MANAGER_ID = E2.EMPLOYEE_ID;
-----------------------------------------------------------------
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;

SELECT * FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
--������ ���� �� �� �� ����
SELECT E.EMPLOYEE_ID,
        E.FIRST_NAME,
        D.DEPARTMENT_NAME,
        L.CITY
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
WHERE EMPLOYEE_ID >= 150;
--����ϰ� �����ϸ� N���̺� 1���̺��� ���̴°� ���� ����

--1�� N�� ����
SELECT * FROM DEPARTMENTS D LEFT JOIN EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;

------------------------------------------------------------

--����Ŭ LEFT OIN
SELECT *
FROM INFO I, AUTH A
WHERE I.AUTH_ID(+) - A.AUTH_ID;

--����Ŭ FULL OUTER JOIN �� ����
--ũ�ν� ������ �߸��� ����(���������� �������� �� ��Ÿ��)
SELECT *
FROM INFO I, AUTH A;














