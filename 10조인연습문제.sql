--���� 1.
--EMPLOYEES ���̺��, DEPARTMENTS ���̺��� DEPARTMENT_ID�� ����Ǿ� �ֽ��ϴ�.
--EMPLOYEES, DEPARTMENTS ���̺��� ������� �̿��ؼ� 
--���� INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER ���� �ϼ���. (�޶����� ���� ���� Ȯ��)
SELECT COUNT(*)
FROM EMPLOYEES E
FULL JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
--���� 2.
--EMPLOYEES, DEPARTMENTS ���̺��� INNER JOIN�ϼ���
--����)employee_id�� 200�� ����� �̸�, department_id�� ����ϼ���
--����)�̸� �÷��� first_name�� last_name�� ���ļ� ����մϴ�
SELECT CONCAT(FIRST_NAME, LAST_NAME) AS �̸�,
       D.DEPARTMENT_ID
FROM EMPLOYEES E
JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE EMPLOYEE_ID = 200;
--���� 3.
--EMPLOYEES, JOBS���̺��� INNER JOIN�ϼ���
--����) ��� ����� �̸��� �������̵�, ���� Ÿ��Ʋ�� ����ϰ�, �̸� �������� �������� ����
--HINT) � �÷����� ���� ����� �ִ��� Ȯ��
SELECT * FROM JOBS;
SELECT * FROM EMPLOYEES;

SELECT CONCAT(FIRST_NAME, LAST_NAME) AS �̸�,
       E.JOB_ID,
       J.JOB_TITLE
FROM EMPLOYEES E
JOIN JOBS J
ON E.JOB_ID = J.JOB_ID
ORDER BY �̸�;
--���� 4.
--JOBS���̺�� JOB_HISTORY���̺��� LEFT_OUTER JOIN �ϼ���.
SELECT * FROM JOBS;
SELECT * FROM JOB_HISTORY;

SELECT * 
FROM JOBS J1
LEFT JOIN JOB_HISTORY J2
ON J1.JOB_ID = J2.JOB_ID;
--���� 5.
--Steven King�� �μ����� ����ϼ���.
SELECT E.FIRST_NAME,
       E.LAST_NAME,
       D.DEPARTMENT_NAME
FROM EMPLOYEES E
JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE FIRST_NAME = 'Steven' AND LAST_NAME = 'King';
--���� 6.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� Cartesian Product(Cross join)ó���ϼ���
SELECT *
FROM EMPLOYEES E
CROSS JOIN DEPARTMENTS D;
--���� 7.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� �μ���ȣ�� �����ϰ� SA_MAN ������� �����ȣ, �̸�, 
--�޿�, �μ���, �ٹ����� ����ϼ���. (Alias�� ���)
SELECT * FROM LOCATIONS;

SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       E.SALARY,
       D.DEPARTMENT_NAME,
       L.STREET_ADDRESS
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID
WHERE JOB_ID = 'SA_MAN';
--���� 8.
--employees, jobs ���̺��� ���� �����ϰ� job_title�� 'Stock Manager', 'Stock Clerk'�� ���� ������
--����ϼ���.
SELECT *
FROM EMPLOYEES E
LEFT JOIN JOBS J
ON E.JOB_ID = J.JOB_ID
WHERE JOB_TITLE IN ('Stock Manager', 'Stock Clerk');

SELECT *
FROM JOBS J
LEFT JOIN EMPLOYEES E
ON J.JOB_ID = E.JOB_ID
WHERE JOB_TITLE IN ('Stock Manager', 'Stock Clerk');
--���� 9.
--departments ���̺��� ������ ���� �μ��� ã�� ����ϼ���. LEFT OUTER JOIN ���
SELECT * 
FROM DEPARTMENTS D
LEFT JOIN EMPLOYEES E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
WHERE EMPLOYEE_ID IS NULL;
--���� 10. 
--join�� �̿��ؼ� ����� �̸��� �� ����� �Ŵ��� �̸��� ����ϼ���
--��Ʈ) EMPLOYEES ���̺�� EMPLOYEES ���̺��� �����ϼ���.
SELECT CONCAT( E2.FIRST_NAME || ' > ', E1.FIRST_NAME) AS �Ŵ���
FROM EMPLOYEES E1
LEFT JOIN EMPLOYEES E2
ON E1.MANAGER_ID = E2.EMPLOYEE_ID;
--���� 11. 
--EMPLOYEES ���̺��� left join�Ͽ� ������(�Ŵ���)��, �Ŵ����� �̸�, �Ŵ����� �޿� ���� ����ϼ���
--����) �Ŵ��� ���̵� ���� ����� �����ϰ� �޿��� �������� ����ϼ���.
SELECT E1.FIRST_NAME, -- ���
       E1.SALARY,
       E2.FIRST_NAME AS �Ŵ�����,
       E2.SALARY AS �Ŵ����Ǳ޿�
FROM EMPLOYEES E1
LEFT JOIN EMPLOYEES E2
ON E1.MANAGEr_ID = E2.EMPLOYEE_ID
WHERE E1.MANAGER_ID IS NOT NULL
ORDER BY SALARY DESC;







