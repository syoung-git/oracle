
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM JOBS;

-- 특정컬럼만 조회하기
-- 문자와 날짜는 왼쪽에, 숫자를 오늘쪽에 표시
SELECT FIRST_NAME, HIRE_DATE, EMAIL, SALARY 
FROM EMPLOYEES;
-- 컬럼명 자리에서는 숫자 또는 날짜 연산 가능

SELECT FIRST_NAME, SALARY, SALARY + SALARY*0.1 FROM EMPLOYEES;

--PK는 EMPLOYEE_ID, FK - DEPARTMENT_ID
SELECT * FROM EMPLOYEES;

--엘리어스(별칭)
SELECT FIRST_NAME AS 별칭 , SALARY 급여, SALARY+SALARY*0.1 "최종급여" FROM EMPLOYEES;

SELECT FIRST_NAME || ' ' || LAST_NAME || '''S SALARY IS $' || SALARY
        AS "Employee Details"
        FROM EMPLOYEES;

--문자열 연결은 ||
--홑 안에서 홑 쓰고 쓰고 싶다면 ''
SELECT 'HELLO' || ' WORLD' FROM EMPLOYEES;
SELECT FIRST_NAME || '''님의 급여는' || SALARY || '$입니다' AS 급여 FROM EMPLOYEES;

--DISTINCT (중복제거) 키워드 -SELECT 다음에 붙임
SELECT DEPARTMENT ID FROM EMLPOYEES;
SELECT DISTINCT DEPARTMENT_ID FROM EMPLOYEES;

--ROWNUM(조회된 순서), ROWID(레코드가 저장된 위치)
SELECT EMPLOYEE_ID, FIRST_NAME, ROWID, ROWNUM FROM EMPLOYEES;

