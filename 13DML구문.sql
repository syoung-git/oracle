--INSERT
--���̺� ������ ������ Ȯ���ϴ� ���
DESC DEPARTMENTS;
--1ST
INSERT INTO DEPARTMENTS VALUES(280, 'DEVELOPER', NULL, 1700);

SELECT * FROM DEPARTMENTS;
--DML���� Ʈ������� �׻� ��ϵǴµ�,
ROLLBACK;

--2ND (�÷��� ��������)
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID) VALUES(280, 'DEVELOPER', 1700);

--INSERT������ �������� �ȴ�.
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME) VALUES ((SELECT MAX(DEPARTMENT_ID)+10 FROM DEPARTMENTS),'DEV');
--INSERT������ ��������(������)

CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES WHERE 1 = 2); --���̺� ���� ����

SELECT * FROM EMPS; -- �� ���̺� �������̺��� Ư�� �����͸� �۴� ����

INSERT INTO EMPS(EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
(SELECT EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID FROM EMPLOYEES WHERE JOB_ID = 'SA_MAN');

COMMIT; -- Ʈ������� �ݿ���
--------------------------------------------------------------------------------
--UPDATE
SELECT * FROM EMPS;

--������Ʈ ������ ����ϱ� ������ SELECT�� �ش� ���� ������ ������ Ȯ���ϰ�, ������Ʈ ó���ؾ� �Ѵ�.
UPDATE EMPS SET SALARY = 1000, COMMISSION_PCT = 0.1 WHERE EMPLOYEE_ID = 148; --KEY�� ���ǿ� ���°� �Ϲ����̴�.
UPDATE EMPS SET SALARY = NVL(SALARY,0)+1000 WHERE EMPLOYEE_ID >= 145;
--������Ʈ ������ ����������
--1ST (���� �� ��������)
UPDATE EMPS SET SALARY = (SELECT SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID = 100) WHERE EMPLOYEE_ID = 148;

--2ND(������ ��������)
UPDATE EMPS 
SET (SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
= (SELECT SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 100)
WHERE EMPLOYEE_ID = 148;

--3RD(WHERE���� ��)
UPDATE EMPS
SET SALARY = 1000
WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');
-----------------------------------------------------------------------------
DELETE����
--Ʈ������� �ֱ� ������, ���� ���� �ݵ�� SELECT������ ���� ���ǿ� �ش��ϴ� �����͸� �� Ȯ���ϴ� ���� �ʿ�
SELECT * FROM EMPS WHERE EMPLOYEE_ID = 148;

DELETE FROM EMPS WHERE EMPLOYEE_ID = 148; --KEY�� ���� ����� ���� ����
--DELETE������ ��������
DELETE FROM EMPS WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE DEPARTMENT_ID = 80);
------------------------------------------------------------------------------
--DELETE���� ���� ����Ǵ� ���� �ƴϴ�.
--���̺��� ��������(FK)������ �����ٸ�, �������� �ʴ´�. : �������Ἲ ����
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
DELETE FROM DEPARTMENTS WHERE DEPARTMENT_ID = 100;--EMPLOYEES���� 100�� �����͸� FK�� ����ϰ� �־, ���� �Ұ�

-------------------------------------------------------------------------------------
--TARGET�� : Ÿ�����̺� �����Ͱ� ������ UPDATE, ������ INSERT������ �����ϴ� ����
MERGE INTO EMPS A --Ÿ�����̺�
USING (SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG') B --�պ����̺�
ON (A.EMPLOYEE_ID = B.EMPLOYEE_ID) --������ Ű
WHEN MATCHED THEN --��ġ�ϴ� ���
    UPDATE SET A.SALARY = B.SALARY,
                A.COMMISSION_PCT = B.COMMISSION_PCT,    
                A.HIRE_DATE = SYSDATE
           --...����
WHEN NOT MATCHED THEN --��ġ���� ���� ���
    INSERT /*INTO*/(EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
    VALUES (B.EMPLOYEE_ID, B.LAST_NAME, B.EMAIL, B.HIRE_DATE, B.JOB_ID);
    
SELECT * FROM EMPS;
--2ND : ������������ �ٸ� ���̺��� �������°� �ƴ�, ���� ���� ���� �� DUAL�� �� �� ����
MERGE INTO EMPS A
USING DUAL
ON (A.EMPLOYEE_ID=107) --����
WHEN MATCHED THEN
    UPDATE SET A.SALARY = 10000,
                A.COMMISSION_PCT = 0.1,
                A.DEPARTMENT_ID = 100
WHEN NOT MATCHED THEN
    INSERT (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
    VALUES (107,'HONG', 'EXAMPLE' ,SYSDATE, 'DBA');
    
SELECT * FROM EMPS;
-----------------------------------------------------------------------
DROP TABLE EMPS;

--CTAS : ���̺� ���� ����
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES); --�����ͱ��� ����
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEESE WHERE 1 = 2); --������ ����
SELECT * FROM EMPS;

------------------------------------------------------------------------
--���� 1.
--DEPTS���̺��� �����͸� �����ؼ� �����ϼ���.
--DEPTS���̺��� ������ INSERT �ϼ���.
--
SELECT * FROM DEPARTMENTS;
CREATE TABLE DEPTS AS (SELECT * FROM DEPARTMENTS);
SELECT * FROM DEPTS;
INSERT INTO DEPTS(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) VALUES (280,'����',NULL,1800);
INSERT INTO DEPTS(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) VALUES (290,'ȸ���',NULL,1800);
INSERT INTO DEPTS(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) VALUES (300,'����',301,1800);
INSERT INTO DEPTS(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) VALUES (310,'�λ�',302,1800);
INSERT INTO DEPTS(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) VALUES (320,'����',303,1700);
--���� 2.
--DEPTS���̺��� �����͸� �����մϴ�
--1. department_name �� IT Support �� �������� department_name�� IT bank�� ����
--2. department_id�� 290�� �������� manager_id�� 301�� ����
--3. department_name�� IT Helpdesk�� �������� �μ����� IT Help�� , �Ŵ������̵� 303����, �������̵�
--1800���� �����ϼ���
--4. �μ���ȣ (290,300,310,320) �� �Ŵ������̵� 301�� �ѹ��� �����ϼ���.
--
UPDATE DEPTS SET DEPARTMENT_NAME = 'IT bank' WHERE DEPARTMENT_NAME = 'IT Support';
UPDATE DEPTS SET MANAGER_ID = 301 WHERE DEPARTMENT_ID = 290;
UPDATE DEPTS SET DEPARTMENT_NAME = 'IT Help', MANAGER_ID = 303, LOCATION_ID = 1800 WHERE DEPARTMENT_NAME = 'IT Helpdesk';
UPDATE DEPTS SET MANAGER_ID = 301 WHERE DEPARTMENT_ID IN (290, 300, 310, 320);
--
--���� 3.
--������ ������ �׻� primary key�� �մϴ�, ���⼭ primary key�� department_id��� �����մϴ�.
--1. �μ��� �����θ� ���� �ϼ���
--2. �μ��� NOC�� �����ϼ���
--
DELETE FROM DEPTS WHERE DEPARTMENT_NAME = '����';
DELETE FROM DEPTS WHERE DEPARTMENT_NAME = 'NOC';
SELECT * FROM DEPTS;
--
--����4
--1. Depts �纻���̺��� department_id �� 200���� ū �����͸� ������ ������.
--2. Depts �纻���̺��� manager_id�� null�� �ƴ� �������� manager_id�� ���� 100���� �����ϼ���.
--3. Depts ���̺��� Ÿ�� ���̺� �Դϴ�.
--4. Departments���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� Depts�� ���Ͽ�
--��ġ�ϴ� ��� Depts�� �μ���, �Ŵ���ID, ����ID�� ������Ʈ �ϰ�, �������Ե� �����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���.
--
DELETE FROM DEPTS WHERE DEPARTMENT_ID > 200;
UPDATE DEPTS SET MANAGER_ID = 100 WHERE MANAGER_ID IS NOT NULL;
MERGE INTO DEPTS DE
USING (SELECT * FROM DEPARTMENTS) D
ON (DE.DEPARTMENT_ID = D.DEPARTMENT_ID)
WHEN MATCHED THEN
    UPDATE SET  DE.DEPARTMENT_NAME = D.DEPARTMENT_NAME,
                DE.MANAGER_ID = D.MANAGER_ID,
                DE.LOCATION_ID = D.LOCATION_ID;
WHEN NOT MATCHED THEN
    INSERT (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
    VALUES (D.DEPARTMENT_ID, D.DEPARTMENT_NAME, D.MANAGER_ID, D.LOCATION_ID);
--
--���� 5
--1. jobs_it �纻 ���̺��� �����ϼ��� (������ min_salary�� 6000���� ū �����͸� �����մϴ�)
--2. jobs_it ���̺� �Ʒ� �����͸� �߰��ϼ���
--3. obs_it�� Ÿ�� ���̺� �Դϴ�
--jobs���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� jobs_it�� ���Ͽ�
--min_salary�÷��� 0���� ū ��� ������ �����ʹ� min_salary, max_salary�� ������Ʈ �ϰ� ���� ���Ե�
--�����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���.
CREATE TABLE JOBS_IT AS (SELECT * FROM JOBS WHERE MIN_SALARY > 6000);
INSERT INTO JOBS_IT VALUES ('IT_DEV','����Ƽ������',6000,20000);
INSERT INTO JOBS_IT VALUES ('NET_DEV','��Ʈ��ũ������',5000,20000);
INSERT INTO JOBS_IT VALUES ('SEC_DEV','���Ȱ�����',6000,19000);
SELECT * FROM JOBS_IT;

MERGE INTO JOBS_IT JI
USING (SELECT JOB_ID, MIN_SALARY, MAX_SALARY
        FROM JOBS
        WHERE MIN_SALARY > 0 ) J 
ON (JI.JOB_ID = J.JOB_ID)
WHEN MATCHED THEN
    UPDATE SET JI.MIN_SALARY = J.MIN_SALARY,
               JI.MAX_SALARY = J.MAX_SALARY;
WHEN NOT MATCHED THEN
    INSERT (JOB_ID,MIN_SALARY, MAX_SALARY)
    VALUES (J.JOB_ID,J.MIN_SALARY, J.MAX_SALARY);

