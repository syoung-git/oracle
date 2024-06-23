--���� 1.
--EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� �����͸� ��� �ϼ��� ( AVG(�÷�) ���)
--EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���
--EMPLOYEES ���̺��� job_id�� IT_PFOG�� ������� ��ձ޿����� ���� ������� �����͸� ����ϼ���.
--
SELECT *
        FROM EMPLOYEES
        WHERE SALARY > (SELECT AVG(SALARY)
                        FROM EMPLOYEES);
--
SELECT COUNT(*)
        FROM EMPLOYEES
        WHERE SALARY > (SELECT AVG(SALARY)
                        FROM EMPLOYEES);
--
SELECT *
        FROM EMPLOYEES
        WHERE SALARY > (SELECT AVG(SALARY)
                        FROM EMPLOYEES
                        WHERE JOB_ID = 'IT_PROG');
--���� 2.
--DEPARTMENTS���̺��� manager_id�� 100�� ����� department_id(�μ����̵�) ��
--EMPLOYEES���̺��� department_id(�μ����̵�) �� ��ġ�ϴ� ��� ����� ������ �˻��ϼ���.
--
SELECT * 
FROM EMPLOYEES 
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE MANAGER_ID = 100);
--
SELECT *
FROM EMPLOYEES E
JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE D.MANAGER_ID = 100;
--���� 3.
--EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� ����ϼ���
--EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.
--
SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID > (SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Pat');
--
SELECT * 
FROM EMPLOYEES 
WHERE MANAGER_ID IN (SELECT MANAGER_ID 
                     FROM EMPLOYEES 
                     WHERE FIRST_NAME = 'James');
--Steven�� ������ �μ��� �ִ� ������� ������ּ���.
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Steven');
--Steven�� �޿����� ���� �޿��� �޴� ������� ����ϼ���.
SELECT FIRST_NAME FROM EMPLOYEES WHERE SALARY > ANY (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Steven');
--���� 4.
--EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� �� ��ȣ, �̸��� ����ϼ���
--�����
SELECT RN,
        FIRST_NAME
FROM (
        SELECT ROWNUM AS RN,
                A.*
        FROM(
            SELECT *
            FROM EMPLOYEES
            ORDER BY FIRST_NAME DESC
            ) A
)
WHERE RN >= 41 AND RN <=50;

--��
SELECT *
FROM ( 
        SELECT ROWNUM AS RN,
                FIRST_NAME
        FROM (SELECT FIRST_NAME
                FROM EMPLOYEES
                ORDER BY FIRST_NAME DESC)
      )
WHERE RN BETWEEN 41 AND 50;
--���� 5.
--EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� �� ��ȣ, ���id, �̸�, ��ȣ, 
--�Ի����� ����ϼ���.
--�����
SELECT RN,
       EMPLOYEE_ID,
       FIRST_NAME,
       PHONE_NUMBER,
       HIRE_DATE
FROM (
        SELECT ROWNUM AS RN,
        A.*
FROM (
        SELECT *
        FROM EMPLOYEES
        ORDER BY HIRE_DATE
      ) A
)
WHERE RN >= 31 AND RN <= 40;
--��
SELECT *
FROM (
        SELECT ROWNUM AS RN,
               EMPLOYEE_ID,
               FIRST_NAME,
               PHONE_NUMBER,
               HIRE_DATE
        FROM(
             SELECT *
             FROM EMPLOYEES
             ORDER BY HIRE_DATE ASC
             )
     )
WHERE RN BETWEEN 31 AND 40;
--���� 6.
--EMPLOYEES���̺� DEPARTMENTS���̺��� left �����ϼ���
--����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
--����) �������̵� ���� �������� ����
--
SELECT E.EMPLOYEE_ID,
        CONCAT(FIRST_NAME||' ',LAST_NAME) AS NAME,
        E.DEPARTMENT_ID AS �μ�ID,
        D.DEPARTMENT_NAME AS �μ���
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY E.EMPLOYEE_ID ASC;
--���� 7.
--���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
--
SELECT EMPLOYEE_ID,
        CONCAT(FIRST_NAME||' ',LAST_NAME) AS NAME,
        DEPARTMENT_ID,
        (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID) AS DEPARTMENT_NAME
FROM EMPLOYEES E
ORDER BY EMPLOYEE_ID;
--���� 8.
--DEPARTMENTS���̺� LOCATIONS���̺��� left �����ϼ���
--����) �μ����̵�, �μ��̸�, ��Ʈ��_��巹��, ��Ƽ �� ����մϴ�
--����) �μ����̵� ���� �������� ����
--
SELECT * FROM LOCATIONS;
SELECT D.DEPARTMENT_ID,
        D.DEPARTMENT_NAME,
        L.STREET_ADDRESS,
        L.CITY
FROM DEPARTMENTS D
LEFT JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID
ORDER BY DEPARTMENT_ID ASC;
--���� 9.
--���� 8�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
--
SELECT DEPARTMENT_ID,
        DEPARTMENT_NAME,
        (SELECT STREET_ADDRESS FROM LOCATIONS L WHERE L.LOCATION_ID = D.LOCATION_ID) AS STREET_ADDRESS,
        (SELECT CITY FROM LOCATIONS L WHERE L.LOCATION_ID = D.LOCATION_ID) AS CITY
FROM DEPARTMENTS D
ORDER BY DEPARTMENT_ID ASC;
--���� 10.
--LOCATIONS���̺� COUNTRIES���̺��� left �����ϼ���.
--����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
--����) country_name���� �������� ����
--
SELECT * FROM LOCATIONS;
SELECT * FROM COUNTRIES;

SELECT L.LOCATION_ID,
        L.STREET_ADDRESS,
        L.CITY,
        L.COUNTRY_ID,
        C.COUNTRY_NAME
FROM LOCATIONS L
LEFT JOIN COUNTRIES C
ON L.COUNTRY_ID = C.COUNTRY_ID
ORDER BY C.COUNTRY_NAME;
--���� 11.
--���� 10�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT LOCATION_ID,
        STREET_ADDRESS,
        CITY,
        COUNTRY_ID,
        (SELECT COUNTRY_NAME FROM COUNTRIES C WHERE C.COUNTRY_ID = L.COUNTRY_ID) AS COUNTRY_NAME
FROM LOCATIONS L;
--
--COMMISSION�� ������ �޿��� ���ο� �÷����� ����� 10000���� ū ������� �̾� ������.
--
SELECT *
FROM (
      SELECT FIRST_NAME,
             SALARY+SALARY*NVL(COMMISSION_PCT,0) AS �޿�
      FROM EMPLOYEES
      )
WHERE �޿� > 10000;

-----------------------------------------------------------------------------------
--����12
--EMPLOYEES���̺�, DEPARTMENTS ���̺��� left�����Ͽ�, �Ի��� �������� �������� 10-20��° �����͸� ����մϴ�.
--����) rownum�� �����Ͽ� ��ȣ, �������̵�, �̸�, �Ի���, �μ��̸� �� ����մϴ�.
--����) hire_date�� �������� �������� ���� �Ǿ�� �մϴ�. rownum�� �������� �ȵǿ�.
--
SELECT *
FROM (
    SELECT ROWNUM AS RN,
            A.*
    FROM ( 
        SELECT EMPLOYEE_ID,
            CONCAT(FIRST_NAME || ' ', LAST_NAME) AS NAME,
            HIRE_DATE,
            DEPARTMENT_NAME
        FROM EMPLOYEES E
        LEFT JOIN DEPARTMENTS D
        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        ORDER BY HIRE_DATE
    ) A
)
WHERE RN > 10 AND RN <=20;
--
--
SELECT *
FROM (
    SELECT ROWNUM AS RN,
        A.*,
        (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE A.DEPARTMENT_ID = D.DEPARTMENT_ID)AS DEPARTMENT_NAME
    FROM(
    SELECT EMPLOYEE_ID,
        CONCAT(FIRST_NAME||' ',LAST_NAME) AS NAME,
        HIRE_DATE,
        DEPARTMENT_ID
    FROM EMPLOYEES E
    ORDER BY HIRE_DATE
    ) A
)
WHERE RN > 10 AND RN<=20;
--����13
--SA_MAN ����� �޿� �������� �������� ROWNUM�� �ٿ��ּ���.
--����) SA_MAN ������� ROWNUM, �̸�, �޿�, �μ����̵�, �μ����� ����ϼ���.
--
SELECT ROWNUM AS RN,
        A.*,
        D.DEPARTMENT_NAME
FROM ( --�ζ��� ��� ���̺� �ڸ� ���� ��
    SELECT FIRST_NAME,
            SALARY,
            DEPARTMENT_ID
    FROM EMPLOYEES 
    WHERE JOB_ID = 'SA_MAN'
    ORDER BY SALARY DESC
) A
LEFT JOIN DEPARTMENTS D
ON A.DEPARTMENT_ID = D.DEPARTMENT_ID;


--����14
--DEPARTMENTS���̺��� �� �μ��� �μ���, �Ŵ������̵�, �μ��� ���� �ο��� �� ����ϼ���.
--����) �ο��� ���� �������� �����ϼ���.
--����) ����� ���� �μ��� ������� ���� �ʽ��ϴ�.
--��Ʈ) �μ��� �ο��� ���� ���Ѵ�. �� ���̺��� �����Ѵ�.
--
SELECT B.*,
       DEPARTMENT_NAME,
       MANAGER_ID
FROM DEPARTMENTS D
JOIN
(SELECT DEPARTMENT_ID, COUNT(*) AS �ο���
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL
GROUP BY DEPARTMENT_ID) B
ON D.DEPARTMENT_ID = B.DEPARTMENT_ID;
--
SELECT *
FROM (SELECT DEPARTMENT_ID, COUNT(*) AS �ο���
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID) C
LEFT JOIN DEPARTMENTS D
ON D.DEPARTMENT_ID = C.DEPARTMENT_ID;
--����15
--�μ��� ��� �÷�, �ּ�, �����ȣ, �μ��� ��� ������ ���ؼ� ����ϼ���.
--����) �μ��� ����� ������ 0���� ����ϼ���
--
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;

SELECT D.*,
        L.STREET_ADDRESS,
        L.POSTAL_CODE,
        E.�μ�����տ���
FROM DEPARTMENTS D
JOIN ( SELECT DEPARTMENT_ID, 
              TRUNC(AVG(SALARY)) AS �μ�����տ���
       FROM EMPLOYEES
       GROUP BY DEPARTMENT_ID ) E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
LEFT JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID;

--����16
--���� 15����� ���� DEPARTMENT_ID�������� �������� �����ؼ� ROWNUM�� �ٿ� 1-10������ ������
--����ϼ���

SELECT *
FROM ( SELECT ROWNUM AS RN,
        DEPARTMENT_ID,
        DEPARTMENT_NAME,
        MANAGER_ID,
        LOCATION_ID,
        STREET_ADDRESS,
        POSTAL_CODE,
        �μ�����տ���
FROM ( SELECT D.*,
        L.STREET_ADDRESS,
        L.POSTAL_CODE,
        E.�μ�����տ���
       FROM DEPARTMENTS D
       JOIN ( SELECT DEPARTMENT_ID, 
                    TRUNC(AVG(SALARY)) AS �μ�����տ���
             FROM EMPLOYEES
             GROUP BY DEPARTMENT_ID ) E
        ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
        LEFT JOIN LOCATIONS L
        ON D.LOCATION_ID = L.LOCATION_ID
        ORDER BY D.DEPARTMENT_ID DESC )
        )
WHERE RN >= 1 AND RN <= 10;