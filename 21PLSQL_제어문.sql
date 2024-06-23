--제어문
/*
IF 조건절 THEN
ELSIF
ELSE~~~

END IF;
*/
SET SERVEROUTPUT ON;

DECLARE
    POINT NUMBER := TRUNC( DBMS_RANDOM.VALUE(1,101) );
BEGIN
    DBMS_OUTPUT.PUT_LINE('점수: '||POINT);
    /*
    IF POINT >= 90 THEN
        DBMS_OUTPUT.PUT_LINE('A학점');
    ELSIF POINT >= 80 THEN
        DBMS_OUTPUT.PUT_LINE('B학점');
    ELSIF POINT >= 70 THEN
        DBMS_OUTPUT.PUT_LINE('C학점');
    ELSE
        DBMS_OUTPUT.PUT_LINE('F학점');
    END IF;
    */
    
    CASE WHEN POINT >= 90 THEN DBMS_OUTPUT.PUT_LINE('A');
         WHEN POINT >= 80 THEN DBMS_OUTPUT.PUT_LINE('B');
         WHEN POINT >= 70 THEN DBMS_OUTPUT.PUT_LINE('C');
         ELSE DBMS_OUTPUT.PUT_LINE('F');
    END CASE;
    
END;
---------------------------------------------------------------------
--반복문

DECLARE
    CNT NUMBER := 1;
BEGIN
    WHILE CNT <= 9
    LOOP
        DBMS_OUTPUT.PUT_LINE('3 X ' || CNT || ' = ' || CNT*3);
        
        CNT := CNT+1; -- 1증가
    END LOOP;
    
END;
--------------------------------------------------------------------------
DECLARE
    
BEGIN
    FOR I IN 1..9 --1부터 9까지 I에 대입
    LOOP
        CONTINUE WHEN I = 5; -- I가 5면 다음으로
        DBMS_OUTPUT.PUT_LINE('3 X ' || I || ' = '|| 3*I);
        --EXIT WHEN I = 5; --I가 5면 탈출
    END LOOP;
END;
---------------------------------------------------------------------------
--1. 2~9단까지 출력하는 익명블록
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
--커서

DECLARE
    NAME VARCHAR2(30);
BEGIN
    --SELECT 결과가 여러 행이라서 ERROR발생
    SELECT FIRST_NAME 
    INTO NAME
    FROM EMPLOYEES 
    WHERE JOB_ID = 'IT_PROG';
    
    DBMS_OUTPUT.PUT_LINE(NAME);
END;
--------------------------------------------------------------------------
DECLARE
    NM VARCHAR2(30); --일반변수
    SALARY NUMBER;

    CURSOR X IS SELECT FIRST_NAME, SALARY
                FROM EMPLOYEES
                WHERE JOB_ID = 'IT_PROG';
BEGIN
    OPEN X;
        DBMS_OUTPUT.PUT_LINE('============커서 시작=============');
    LOOP 
        FETCH X INTO NM, SALARY; --NM변수와, SALARY 저장
        EXIT WHEN X%NOTFOUND; --X커서에 더이상 읽을 값이 없으면 TRUE
        DBMS_OUTPUT.PUT_LINE(NM);
        DBMS_OUTPUT.PUT_LINE(SALARY);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('===========커서 종료==============');
    DBMS_OUTPUT.PUT_LINE('데이터 수: ' || X%ROWCOUNT); --커서에서 읽은 데이터 수
    CLOSE X; --커서 닫음
END;
--------------------------------------------------------------------------------
SELECT * FROM EMP_SAL;
--4. 부서벌 급여합을 출력하는 커서구문을 작성해봅시다.
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
        DBMS_OUTPUT.PUT_LINE('부서: '||D);
        DBMS_OUTPUT.PUT_LINE('급여합: '||S);
        
    END LOOP;
    CLOSE X;
END;

--5. 사원테이블의 연도별 급여합을 구하여 EMP_SAL에 순차적으로 INSERT하는 커서구문을 작성해봅시다.
--
DECLARE
    CURSOR X IS SELECT S, SUM(SALARY) AS D
                FROM (SELECT TO_CHAR(HIRE_DATE,'YYYY') AS S,
                             SALARY
                      FROM EMPLOYEES)
                GROUP BY S;
BEGIN
    FOR I IN X --커서를 FOR IN 구문에 넣으면 OPEN생략 가능
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
--        DBMS_OUTPUT.PUT_LINE('부서명: '||D||', 급여합: '||S);
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








