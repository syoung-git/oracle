SELECT * FROM INFO;
SELECT * FROM AUTH;

--INNER JOIN : 붙을 수 없는 데이터는 나오지 않음
SELECT *
FROM INFO /*INNER*/ JOIN AUTH
ON INFO.AUTH_ID=AUTH.AUTH_ID;

SELECT INFO.ID,
        INFO.TITLE,
        INFO.CONTENT,
        INFO.AUTH_ID, --AUTH_ID는 양측에 다 있는 KEY, 테이블.컬럼명 기입해야 한다.
        AUTH.NAME
FROM INFO /*INNER*/ JOIN AUTH
ON INFO.AUTH_ID=AUTH.AUTH_ID;
--테이블 ALIAS
SELECT I.ID,
        I.TITLE,
        A.AUTH_ID,
        A.NAME,
        A.JOB
FROM INFO I
INNER JOIN AUTH A
ON I.AUTH_ID = A.AUTH_ID;

--연결할 키가 같다면 USING구문 사용 가능
SELECT *
FROM INFO I
INNER JOIN AUTH A
USING (AUTH_ID);

-----------------------------------------------------
--OUTER JOIN
--LEFT OUTER JOIN (OUTER 생략가능) : 왼쪽테이블이 기준이 돼서, 왼쪽 테이블은 다 나옴

SELECT * FROM INFO I LEFT OUTER JOIN AUTH A ON I.AUTH_ID=A.AUTH_ID;

--RIGHT OUTER JOIN : 오른쪽테이블이 기준이 돼서, 오른쪽테이블은 다 나옴
SELECT * FROM INFO I RIGHT OUTER JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;

--RIGHT조인의 테이블 자리만 바꾸면 LEFT JOIN
SELECT * FROM AUTH A RIGHT OUTER JOIN INFO I ON A.AUTH_ID = I.AUTH_ID;

--FULL OUTER JOIN : 양쪽 데이터 누락없이 다 나옴
SELECT * FROM INFO I FULL OUTER JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;

--CROSS JOIN(잘못된 조인의 형태; 실제 쓸 일은 없음)
SELECT * FROM INFO I CROSS JOIN AUTH A;

---------------------------------------------------------------
--SELF JOIN(하나의 테이블을 가지고 조인을 거는 것) : 조건 테이블 안에 연결 가능한 키가 필요함
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
--조인은 여러 번 할 수 있음
SELECT E.EMPLOYEE_ID,
        E.FIRST_NAME,
        D.DEPARTMENT_NAME,
        L.CITY
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
WHERE EMPLOYEE_ID >= 150;
--평범하게 생각하면 N테이블에 1테이블을 붙이는게 가장 많다

--1에 N을 붙임
SELECT * FROM DEPARTMENTS D LEFT JOIN EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;

------------------------------------------------------------

--오라클 LEFT OIN
SELECT *
FROM INFO I, AUTH A
WHERE I.AUTH_ID(+) - A.AUTH_ID;

--오라클 FULL OUTER JOIN 은 없음
--크로스 조인은 잘못된 조인(조인조건을 안적었을 때 나타남)
SELECT *
FROM INFO I, AUTH A;














