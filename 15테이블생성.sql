--DDL문장 (트랜잭션 없음)
--CREATE, ALTER, DROP

DROP TABLE DEPTS;

CREATE TABLE DEPTS (
    DEPT_NO NUMBER(2), --숫자 2자리
    DEPT_NAME VARCHAR2(30), --30BYTE (한글 15글자, 숫자영어 30글자)
    DEPT_YN CHAR(1), --고정문자 1BYTE (VARCHAR2 대체가능)
    DEPT_DATE DATE,
    DEPT_BONUS NUMBER(10,2), --정수 10자리, 실수 2자리까지 저장
    DEPT_CONTENT LONG --2기가까지 저장되는 가변문자열(VARVHAR2보다 더 큰)
);

SELECT * FROM DEPTS;
DESC DEPTS;

INSERT INTO DEPTS VALUES (99,'HELLO','Y',SYSDATE,'3.14','LONG TEXT');
INSERT INTO DEPTS VALUES (100,'HELLO','Y',SYSDATE,'3.14','LONG TEXT~');--DEPT_NO초과
INSERT INTO DEPTS VALUES (1,'HELLO','가',SYSDATE,'3.14','LONG TEXT~');--DEPT_YN초과

------------------------------------------------------------------
--테이블 구조 변경 ALTER
--ADD, MODIFY, RENAME COLUMN, DROP COLUMN
DESC DEPTS;

ALTER TABLE DEPTS ADD DEPT_COUNT NUMBER(3); --마지막에 컬럼 추가

ALTER TABLE DEPTS RENAME COLUMN DEPT_COUNT TO EMP_COUNT; --컬럼명 변경

ALTER TABLE DEPTS MODIFY EMP_COUNT NUMBER(5);--컬럼의 크기를 수정
ALTER TABLE DEPTS MODIFY EMP_COUNT NUMBER(1);
ALTER TABLE DEPTS MODIFY DEPT_NAME VARCHAR2(1);--"cannot decrease column length because some value is too big"

ALTER TABLE DEPTS DROP COLUMN EMP_COUNT;--컬럼 삭제
-----------------------------------------------------------------------------------
--테이블 삭제
DROP TABLE DEPTS /*CASCADE 제약조건명*/; --테이블이 가지는 FK제약조건을 삭제하면서, 테이블 날려버림 (!!위험!!)
DROP TABLE DEPARTMENTS; --DEPARTMENT는 EMPLOYEES테이블과 참조관계를 가지고 있어서, 한 번에 삭제가 안됨.(제약조건이 지워지면 삭제가능)
--------------------------------------------------------------------------------------------




