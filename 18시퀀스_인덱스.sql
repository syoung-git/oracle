--시퀀스(순차적으로 증가하는 값)
--주로 PK에 적용될 수 있다

SELECT * FROM USER_SEQUENCES;

--시퀀스 생성 (외우래~)
CREATE SEQUENCE DEPTS_SEQ
    INCREMENT BY 1 --얼마씩 증가할거냐
    START WITH 1 --어디부터 시작할거냐
    MAXVALUE 10 --어디까지 증가할거냐
    NOCACHE --캐시에 시퀀스를 두지 않음
    NOCYCLE; --최대값에 도달했을 때 재사용X

--적용
DROP TABLE DEPTS;
CREATE TABLE DEPTS (
    DEPT_NO NUMBER(2) PRIMARY KEY,
    DEPT_NAME VARCHAR(30)
);

--시퀀스 사용방법
SELECT DEPTS_SEQ.CURRVAL FROM DUAL; --현재 시퀀스 확인(NEXTVAL가 선행 되어야 함)
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL; --현재 시퀀스 증가값만큼 증가

--시퀀스 적용
INSERT INTO DEPTS VALUES (DEPTS_SEQ.NEXTVAL, 'EXAMPLE');
SELECT * FROM DEPTS;
--시퀀스 수정
ALTER SEQUENCE DEPTS_SEQ MAXVALUE 1000;
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 10;

--시퀀스가 이미 사용되고 있다면, DROP하면 안됨
--만약 시퀀스를 초기화 해야 한다면?
--시퀀스의 증ㅇ가값을 음수로 만들어서 초기화인 것처럼 쓸 수는 있다.
SELECT DEPTS_SEQ.CURRVAL FROM DUAL;

--1. 시퀀스 증가를 -음수로 바꿈
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY -69;
--2. 현재시퀀스 전진
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL;
--3. 다시 증가값을 1로 변경
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 1;

-------------------------------------------------------
--시퀀스 응용 (나중에 테이블을 설계할 때, 데이터가 엄청 많다면 시퀀스의 사용 고려)
--문자열 PK(연도값-일련번호)

CREATE TABLE DEPTS2(
    DEPT_NO VARCHAR2(20) PRIMARY KEY,
    DEPT_NAME VARCHAR2(20)
);

INSERT INTO DEPTS2 VALUES(TO_CHAR(SYSDATE, 'YYYY-MM-')||LPAD(DEPTS_SEQ.NEXTVAL,6,0), 'EXAMPLE');
SELECT * FROM DEPTS2;
--시퀀스 삭제
DROP SEQUENCE 시퀀스명;
----------------------------------------------------------------------
--INDEX
--INDEX는 PK, UNIQUE에 자동으로 생성되고, 조회를 빠르게 하는 HINT역할을 한다.
--INDEX종류는 고유인덱스, 비고유인덱스가 있음
--UNIQUE한 컬럼에는 UNIQUE인덱스(고유) 인덱스가 쓰임.
--일반컬럼에는 비고유 인덱스를 지정할 수 있다.
--INDEX는 조회를 빠르게 한다. BUT DML구문이 많이 사용되는 컬럼은 오히려 성능저하를 발생할 수도 있음


--인덱스 생성
CREATE TABLE EMPS_IT AS (SELECT * FROM EMPLOYEES);

--인덱스가 없을 때 조회
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Nancy';
--비고유 인덱스 생성
CREATE INDEX EMPLS_IT_IX ON EMPS_IT (FIRST_NAME);

--인덱스 생성 후 FIRST_NAME으로 다시 조회
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Nancy';

--인덱스 삭제 (인덱스는 삭제해도 테이블에 영향 X)
DROP INDEX EMPLS_IT_IX;

--결한 인덱스 (여러개 컬럼을 동시에 인덱스로 지정)
CREATE INDEX EMPS_IT_IX ON EMPS_IT (FIRST_NAME, LAST_NAME);

SELECT * FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy'; --힌트를 얻음
SELECT * FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy' AND LAST_NAME = 'Greenberg';--힌트얻음
SELECT * FROM EMPLOYEES WHERE LAST_NAME = 'Greenberg';--힌트얻음

--고유인덱스
--CREATE UNIQUE INDEX 인덱스명 ~;



