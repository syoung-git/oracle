--�������� (SELECT �������� Ư�� ��ġ�� �ٽ� SELECT�� ���� ����)
--������ �������� : ���������� ����� 1���� ��������

--Nancy���� �޿��� ���� ���
--1. ������ �޿��� ã�´�.
--2. ã�� �޿��� WHERE���� �ִ´�.

SELECT *
FROM EMPLOYEES
WHERE FIRST_NAME = 'Nancy';

SELECT *
FROM EMPLOYEES 
WHERE SALARY >= (SELECT SALARY
                 FROM EMPLOYEES
                 WHERE FIRST_NAME = 'Nancy');
                 
-- 103���� ������ ���� ���
SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 103;

SELECT *
FROM EMPLOYEES
WHERE JOB_ID = ( SELECT JOB_ID
                 FROM EMPLOYEES
                 WHERE EMPLOYEE_ID=103);
                 
--������ �� : ���� �÷��� �Ѱ����� �Ѵ�.
SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103);

--������ �� : ���� ���� ������ �����̶��, ���� �� �������� �����ڸ� ����� �Ѵ�. (������ ���������� ó��)
SELECT *
FROM EMPLOYEES
WHERE FIRST_NAME = 'Steven';
SELECT *
FROM EMPLOYEES
WHERE SALARY >= (SELECT SALARY 
                 FROM EMPLOYEES
                 WHERE FIRST_NAME = 'Steven');
                 
-------------------------------------------------------------
--������ �������� : ���������� ����� ���� �� ���ϵǴ� ��� IN, ANY, ALL

SELECT SALARY
FROM EMPLOYEES
WHERE FIRST_NAME = 'David'; --4800, 6800, 9500

--���̺���� �ּұ޿����� ���� �޴� ���
--4800���� ū
SELECT *
FROM EMPLOYEES
WHERE SALARY > ANY (SELECT SALARY
                    FROM EMPLOYEES
                    WHERE FIRST_NAME = 'David');

--���̺���� �ִ�޿����� ���� �޴� ���
--9500���� ����
SELECT *
FROM EMPLOYEES
WHERE SALARY < ANY (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

--���̺���� �ִ�޿����� ���� �޴� ���
--9500���� ū
SELECT *
FROM EMPLOYEES
WHERE SALARY > ALL (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

--���̺���� �ּ� �޿����� ���� �޴� ���
--4800���� ����
SELECT *
FROM EMPLOYEES
WHERE SALARY < ALL (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

--IN ���� �� ������ �� ��ġ�ϴ� ������
--���̺��� �μ��� ����
SELECT DEPARTMENT_ID
FROM EMPLOYEES
WHERE FIRST_NAME='David';

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID -- �÷� �ϳ����� ��
                        FROM EMPLOYEES
                        WHERE FIRST_NAME = 'David');
                                                
---------------------------------------------------------------
--��Į�� ���� : SELECT���� ���������� ���� ��� (JOIN�� ��ü��)
SELECT FIRST_NAME,
       DEPARTMENT_NAME
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
--��Į��� �ٲٱ�(LEFT JOIN�� ����)
SELECT FIRST_NAME,
       (SELECT DEPARTMENT_NAME 
        FROM DEPARTMENTS D 
        WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID)
        AS DEPALRTMENT_NAME
FROM EMPLOYEES E;

--��Į�������� �ٸ� ���̺��� 1���� �÷��� ������ �� ��, JOIN���� ������ �� ����ϴ�.
SELECT * FROM JOBS;
SELECT FIRST_NAME,
       JOB_ID,
       (SELECT JOB_TITLE 
        FROM JOBS J 
        WHERE J.JOB_ID = E.JOB_ID) 
        AS JOB_TITLE
FROM EMPLOYEES E;
--��Į�������� �� ���� �ϳ��� �÷��� �������� ������, ���� ���� ������ �� ���� 
--������ JOIN������ �������� �� ���� �� �ִ�.
SELECT FIRST_NAME,
       JOB_ID,
       (SELECT JOB_TITLE FROM JOBS J WHERE J.JOB_ID = E.JOB_ID) AS JOB_TITLE,
       (SELECT MIN_SALARY FROM JOBS J WHERE J.JOB_ID = E.JOB_ID) AS MIN_SALARY
FROM EMPLOYEES E;

--����
--FIRST_NAME�÷�, DEPARTMENT_NAME, JOB_TITLE�� ���ÿ� SELECT
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM JOBS;
--
SELECT FIRST_NAME,
       DEPARTMENT_NAME,
       JOB_TITLE
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN JOBS J
ON E.JOB_ID = J.JOB_ID;
--
SELECT FIRST_NAME,
        (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) AS DEPARTMNET_NAME,
        (SELECT JOB_TITLE FROM JOBS J WHERE J.JOB_ID = E.JOB_ID) AS JOB_TITLE
FROM EMPLOYEES E;
--------------------------------------------------------------------------------
--�ζ��� �� : FROM�� ������ ������������ ����.
--�ζ��� �信�� (�����÷�)�� �����, �� �÷��� ���ؼ� ��ȸ�� ���� �� ����Ѵ�.

SELECT *
FROM (SELECT *
      FROM EMPLOYEES);

--ROWNUM�� ��ȸ�� ������ ���� ��ȣ�� �ٴ´�.
SELECT ROWNUM,
        FIRST_NAME,
        SALARY
FROM EMPLOYEES
ORDER BY SALARY DESC;
--ORDER�� ���� ��Ų ����� ���ؼ� ����ȸ

SELECT ROWNUM, FIRST_NAME, SALARY
FROM (SELECT FIRST_NAME,
             SALARY
      FROM EMPLOYEES
      ORDER BY SALARY DESC)
WHERE ROWNUM BETWEEN 11 AND 20; --ROWNUM�� �ݵ�� 1���� �����ؾ� ��.

--ORDER�� ���� ��ų ����� �����, ROWNUM ���󿭷� �ٽ� �����, ����ȸ
SELECT *
FROM (
      SELECT ROWNUM AS RN,--����(���������� ������ ��)
            FIRST_NAME,
            SALARY
      FROM (
            SELECT FIRST_NAME,
                    SALARY
            FROM EMPLOYEES
            ORDER BY SALARY DESC
            )
      )
WHERE RN BETWEEN 11 AND 20; -- �ȿ��� RN���� ������� ������ �ۿ��� ��� ����

--����
--�ټӳ�� 5��° �Ǵ� ����鸸 ���
SELECT *
FROM (
      SELECT FIRST_NAME,
            TRUNC((SYSDATE - HIRE_DATE)/365) AS �ټӳ��,
            HIRE_DATE AS �Ի���
      FROM EMPLOYEES
      ORDER BY �ټӳ�� DESC
     )
WHERE MOD(�ټӳ��,5)=0 ;

--�ζ��� �信�� ���̺� ������� ��ȸ

SELECT ROWNUM AS RN,
        A.*        
FROM (
       SELECT E.*,
              TRUNC((SYSDATE - HIRE_DATE)/365) AS �ټӳ��
       FROM EMPLOYEES E
       ORDER BY �ټӳ�� DESC
) A;






