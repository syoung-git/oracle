--�������
SELECT * FROM ALL_USERS;
--���� ���� ���� Ȯ��
SELECT * FROM USER_SYS_PRIVS;

--���� ����
CREATE USER USER01 IDENTIFIED BY USER01; --���̵�:USER01 ���:USER01
--���Ѻο� (���ӱ���, ���̺� �� ������ ���ν��� ��������)
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE VIEW, CREATE PROCEDURE TO USER01; --USER01���� ���Ѻο�
--���̺� �����̽� (�����͸� �����ϴ� �������� ����) ����
ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
--�����Ѵ� ���� USER01 �⺻ ���̺����̽��� USERS�̰�, ���������� ����Ѵ� ON USERS���̺� �����̽���

--���� ȸ��
REVOKE CREATE SESSION FROM USER01; --���ӱ��� ȸ��
--���� ����
DROP USER USER01;
--------------------------------------------------------------------------------
--��(ROLE) : ������ �׷��� ���� ���� �ο�
CREATE USER USER01 IDENTIFIED BY USER01;

GRANT CONNECT, RESOURCE TO USER01;--CONNECT:���� ROLE, RESOURCE:���� ROLE, DBA: ������ ROLE

ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;







