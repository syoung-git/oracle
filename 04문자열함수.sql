--���ڿ� �Լ�
SELECT LOWER('H') FROM DUAL; --SQUL�� ������ �����ϱ� ���� ���� ���̺�

SELECT LOWER(FIRST_NAME),UPPER(FIRST_NAME), INITCAP(FIRST_NAME) FROM EMPLOYEES;

--LENGTH ���ڿ� ����
--INSTR ���ڿ� ã��
SELECT FIRST_NAME, LENGTH(FIRST_NAME) FROM EMPLOYEES;
SELECT FIRST_NAME, INSTR(FIRST_NAME, 'a') FROM EMPLOYEES; --a�� �ִ� ��ġ ��ȯ/ ������ 0��ȯ
--SUBSTR ���ڿ� �ڸ���
SELECT FIRST_NAME, SUBSTR(FIRST_NAME, 3), SUBSTR(FIRST_NAME, 3, 2) FROM EMPLOYEES; --3�̸� ����, 3��° ��ġ���� 2�� �ڸ�
 --CONCAT ���ڿ� ��ġ��
 SELECT FIRST_NAME || LAST_NAME, CONCAT(FIRST_NAME, LAST_NAME) FROM EMPLOYEES;
 
 --LPAD, RPAD : ������ �����ϰ�, Ư�����ڷ� ä��
 SELECT LPAD('ABC', 10, '*') FROM DUAL;--ABC�� 10ĭ ���, ������ �κ� ���ʺ��� *ä��
SELECT LPAD(FIRST_NAME, 10, '*'), RPAD(FIRST_NAME, 10, '-') FROM EMPLOYEES;
 
--LTRIM, RTRIM, TRIM : ������� �Ǵ� ���ڻ���
SELECT TRIM(' HELLO WORLD  '), LTRIM(' HELLO WORLD  '), RTRIM(' HELLO WORLD  ') FROM DUAL;
SELECT LTRIM('HELLOWORLD', 'HE') FROM DUAL;

--REPLACE ���ڿ� ����
SELECT REPLACE('���� �뱸 ���� �λ� ���', ' ', '->') FROM DUAL; --������ ->�� ����
SELECT REPLACE('���� �뱸 ���� �λ� ���', ' ', '') FROM DUAL; --�������

------------------------------------------------------
--���� 1.
--EMPLOYEES ���̺� ���� �̸�, �Ի����� �÷����� �����ؼ� �̸������� �������� ��� �մϴ�.
--���� 1) �̸� �÷��� first_name, last_name�� �ٿ��� ����մϴ�.
--���� 2) �Ի����� �÷��� xx/xx/xx�� ����Ǿ� �ֽ��ϴ�. xxxxxx���·� �����ؼ� ����մϴ�.
--

SELECT CONCAT(FIRST_NAME, LAST_NAME) AS �̸�, REPLACE(HIRE_DATE,'/','') AS �Ի�����
FROM EMPLOYEES 
ORDER BY FIRST_NAME ASC;

--
--���� 2.
--EMPLOYEES ���̺� ���� phone_number�÷��� ###.###.####���·� ����Ǿ� �ִ�
--���⼭ ó�� �� �ڸ� ���� ��� ���� ������ȣ (02)�� �ٿ� ��ȭ ��ȣ�� ����ϵ��� ������ �ۼ��ϼ���
--
SELECT PHONE_NUMBER FROM EMPLOYEES;
SELECT LPAD((SUBSTR(PHONE_NUMBER,4)),LENGTH(PHONE_NUMBER)-1,'02') FROM EMPLOYEES;
SELECT RPAD(SUBSTR(FIRST_NAME,1,3), LENGTH(FIRST_NAME), '*') AS �̸�, 
        SALARY
FROM EMPLOYESS WHERE LOWER (JOB_ID)='it _prog';

--
--���� 3. EMPLOYEES ���̺��� JOB_ID�� it_prog�� ����� �̸�(first_name)�� �޿�(salary)�� ����ϼ���.
--���� 1) ���ϱ� ���� ���� �ҹ��ڷ� �Է��ؾ� �մϴ�.(��Ʈ : lower �̿�)
--���� 2) �̸��� �� 3���ڱ��� ����ϰ� �������� *�� ����մϴ�. 
--�� ���� �� ��Ī�� name�Դϴ�.(��Ʈ : rpad�� substr �Ǵ� substr �׸��� length �̿�)
--���� 3) �޿��� ��ü 10�ڸ��� ����ϵ� ������ �ڸ��� *�� ����մϴ�. 
--�� ���� �� ��Ī�� salary�Դϴ�.(��Ʈ : lpad �̿�)

SELECT RPAD((SUBSTR(FIRST_NAME,0,3)),LENGTH(FIRST_NAME),'*') AS NAME, LPAD(SALARY,10,'*') AS SALARY FROM EMPLOYEES WHERE LOWER(JOB_ID)='it_prog';











