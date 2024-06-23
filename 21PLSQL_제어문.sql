--���
/*
IF ������ THEN
ELSIF
ELSE~~~

END IF;
*/
SET SERVEROUTPUT ON;

DECLARE
    POINT NUMBER := TRUNC( DBMS_RANDOM.VALUE(1,101) );
BEGIN
    DBMS_OUTPUT.PUT_LINE('����: '||POINT);
    /*
    IF POINT >= 90 THEN
        DBMS_OUTPUT.PUT_LINE('A����');
    ELSIF POINT >= 80 THEN
        DBMS_OUTPUT.PUT_LINE('B����');
    ELSIF POINT >= 70 THEN
        DBMS_OUTPUT.PUT_LINE('C����');
    ELSE
        DBMS_OUTPUT.PUT_LINE('F����');
    END IF;
    */
    
    CASE WHEN POINT >= 90 THEN DBMS_OUTPUT.PUT_LINE('A');
         WHEN POINT >= 80 THEN DBMS_OUTPUT.PUT_LINE('B');
         WHEN POINT >= 70 THEN DBMS_OUTPUT.PUT_LINE('C');
         ELSE DBMS_OUTPUT.PUT_LINE('F');
    END CASE;
    
END;
---------------------------------------------------------------------
--�ݺ���

DECLARE
    CNT NUMBER := 1;
BEGIN
    WHILE CNT <= 9
    LOOP
        DBMS_OUTPUT.PUT_LINE('3 X ' || CNT || ' = ' || CNT*3);
        
        CNT := CNT+1; -- 1����
    END LOOP;
    
END;
--------------------------------------------------------------------------
DECLARE
    
BEGIN
    FOR I IN 1..9 --1���� 9���� I�� ����
    LOOP
        CONTINUE WHEN I = 5; -- I�� 5�� ��������
        DBMS_OUTPUT.PUT_LINE('3 X ' || I || ' = '|| 3*I);
        --EXIT WHEN I = 5; --I�� 5�� Ż��
    END LOOP;
END;
---------------------------------------------------------------------------
--1. 2~9�ܱ��� ����ϴ� �͸���
DECLARE
    NUM NUMBER:=2;
BEGIN
    WHILE NUM<=9
    LOOP
        FOR I IN 1..9
        LOOP
        
        DBMS_OUTPUT.PUT_LINE(NUM||' * '||I||' = '||NUM*I);
        
        END LOOP;
        
        NUM:=NUM+1;
    END LOOP;
END;
---------------------------------------------------------------------------
--Ŀ��

DECLARE
    NAME VARCHAR2(30);
BEGIN
    --SELECT ����� ���� ���̶� ERROR�߻�
    SELECT FIRST_NAME 
    INTO NAME
    FROM EMPLOYEES 
    WHERE JOB_ID = 'IT_PROG';
    
    DBMS_OUTPUT.PUT_LINE(NAME);
END;
--------------------------------------------------------------------------
DECLARE
    NM VARCHAR2(30); --�Ϲݺ���
    SALARY NUMBER;

    CURSOR X IS SELECT FIRST_NAME, SALARY
                FROM EMPLOYEES
                WHERE JOB_ID = 'IT_PROG';
BEGIN
    OPEN X;
        DBMS_OUTPUT.PUT_LINE('============Ŀ�� ����=============');
    LOOP 
        FETCH X INTO NM, SALARY; --NM������, SALARY ����
        EXIT WHEN X%NOTFOUND; --XĿ���� ���̻� ���� ���� ������ TRUE
        DBMS_OUTPUT.PUT_LINE(NM);
        DBMS_OUTPUT.PUT_LINE(SALARY);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('===========Ŀ�� ����==============');
    DBMS_OUTPUT.PUT_LINE('������ ��: ' || X%ROWCOUNT); --Ŀ������ ���� ������ ��
    CLOSE X; --Ŀ�� ����
END;
--------------------------------------------------------------------------------
SELECT * FROM EMP_SAL;
--4. �μ��� �޿����� ����ϴ� Ŀ�������� �ۼ��غ��ô�.
--

DECLARE
    D VARCHAR(30);
    S NUMBER;
    
    CURSOR X IS SELECT DEPARTMENT_ID, SUM(SALARY)
                FROM EMPLOYEES
                WHERE DEPARTMENT_ID IS NOT NULL
                GROUP BY DEPARTMENT_ID;
BEGIN
    OPEN X;
    LOOP
        FETCH X INTO D,S;
        EXIT WHEN X%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('�μ�: '||D);
        DBMS_OUTPUT.PUT_LINE('�޿���: '||S);
        
    END LOOP;
    CLOSE X;
END;

--5. ������̺��� ������ �޿����� ���Ͽ� EMP_SAL�� ���������� INSERT�ϴ� Ŀ�������� �ۼ��غ��ô�.
--
DECLARE
    CURSOR X IS SELECT S, SUM(SALARY) AS D
                FROM (SELECT TO_CHAR(HIRE_DATE,'YYYY') AS S,
                             SALARY
                      FROM EMPLOYEES)
                GROUP BY S;
BEGIN
    FOR I IN X --Ŀ���� FOR IN ������ ������ OPEN���� ����
    LOOP
        --DBMS_OUTPUT.PUT_LINE(I.D||' '||I.S);
        INSERT INTO EMP_SAL VALUES(I.D, I.S); 
    END LOOP;

--    OPEN X;
--    LOOP
--        FETCH X INTO D,S;
--        EXIT WHEN X%NOTFOUND;
--        
--        INSERT INTO EMP_SAL(YEARS,SALARY) VALUES ( D,S);
--        
--        DBMS_OUTPUT.PUT_LINE('�μ���: '||D||', �޿���: '||S);
--    END LOOP;
--    CLOSE X;
END;
/*
SELECT A,
       SUM(SALARY) AS B
FROM (SELECT TO_CHAR(HIRE_DATE, 'YYYY') AS A,
             SALARY
      FROM EMPLOYEES
      )
GROUP BY A;
*/








