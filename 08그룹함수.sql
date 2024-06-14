--�׷��Լ�
--NULL�� ���� �� �����͵鿡 ���ؼ� �����.
SELECT MAX(SALARY), MIN(SALARY), SUM(SALARY), AVG(SALARY), COUNT(SALARY) FROM EMPLOYEES;
--MIN, MAX�� ��¥, ���ڿ��� ���� ����
SELECT MIN(HIRE_DATE), MAX(HIRE_DATE), MIN(FIRST_NAME), MAX(FIRST_NAME) FROM EMPLOYEES;
--COUNT() ��� �� ����
SELECT COUNT(*), COUNT(COMMISSION_PCT) FROM EMPLOYEES;

--�μ��� 80�� ����� ��, Ŀ�̼��� ���� ���� ���
SELECT MAX(COMMISSION_PCT) FROM EMPLOYEES WHERE DEPARTMENT_ID = 80;

--�׷��Լ��� �Ϲ� �÷��̶� ���ÿ� ��� �Ұ�
SELECT FIRST_NAME, AVG FROM EMPLOYEES;
--�׷��Լ� �ڿ� OVER()�� ���̸�, �Ϲ��÷��� ���ÿ� ��� ����
SELECT FIRST_NAME, AVG(SALARY) OVER(), COUNT(*) OVER(), SUM(SALARY) OVER() FROM EMPLOYEES;

----------------------------------------------------------
--GROUP BY�� - WHERE�� ORDER�� ���̿� ���´�.
SELECT DEPARTMENT_ID,
        SUM(SALARY),
        TRUNC(AVG(SALARY)),
        MIN(SALARY),
        MAX(SALARY),
        COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;
--GROUPȭ ��Ų Į���� SELECT������ ���� �� �ִ�.
SELECT DEPARTMENT_ID, FIRST_NAME
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID; --ERROR

--2�� �̻��� �׷�ȭ (�����׷�)
SELECT DEPARTMENT_ID
        , JOB_ID
        ,SUM(SALARY) AS "�μ��������޿��հ�"
        ,AVG(SALARY) AS "�μ��������޿����"
        ,COUNT(*) AS �μ��ο���
        ,COUNT(*) OVER() AS ��üī��Ʈ --COUNT(*) OVER() ����ϸ�, �� ���� ���� ���
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY DEPARTMENT_ID;
--�׷��Լ��� WHERE�� ���� �� ����
SELECT DEPARTMENT_ID,
        AVG(SALARY)
FROM EMPLOYEES
WHERE AVG(SALARY) >= 5000 --�׷��� ������ ���� ���� HAVING��
GROUP BY DEPARTMENT_ID; --ERROR

--------------------------------------------------------------------------------
--HAVING�� : GROUP BY ����
SELECT DEPARTMENT_ID, JOB_ID, AVG(SALARY), COUNT(*)
FROM EMPLOYEES
WHERE JOB_ID NOT LIKE 'SA%'
GROUP BY DEPARTMENT_ID, JOB_ID
HAVING AVG(SALARY) >= 10000
ORDER BY AVG(SALARY) DESC;

--�μ����̵� NULL�� �ƴ� �������߿��� �Ի����� 05�⵵�� ������� �μ��� �޿����, �޿����� ���ϰ�
--��ձ޿��� 5000�̻��� �����͸� ���ϰ� �μ����̵�� ��������
SELECT DEPARTMENT_ID AS �μ����̵�,
       AVG(SALARY) AS �޿����,
       SUM(SALARY) AS �޿���
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL AND HIRE_DATE LIKE '05%'
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) >= 5000
ORDER BY DEPARTMENT_ID DESC;






