--INSERT, UPDATE, DELETE ���� �ۼ������� COMMIT�̶�� ������� ���� �ݿ� ó���� �մϴ�.
--INSERT

--���̺� ���� Ȯ��
DESC DEPARTMENTS;

INSERT INTO DEPARTMENTS VALUES(300, 'DEV', NULL, 1700); --��ü���� �ִ� ���
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME) VALUES(310, 'SYSTEM');--���������� �ִ� ���

SELECT * FROM DEPARTMENTS;
ROLLBACK;

--�纻���̺�(���̺� ������ ����)
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES WHERE 1 = 2);

INSERT INTO EMPS (SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');
INSERT INTO EMPS (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES (200, 
        (SELECT LAST_NAME FROM EMPLOYEES WHERE EMPLOYEE_ID = 200),
        (SELECT EMAIL FROM EMPLOYEES WHERE EMPLOYEE_ID = 200),
        SYSDATE,
        'TEST'
        );

SELECT * FROM EMPS;
DESC EMPS;
--------------------------------------------------------------------------------
SELECT  * 
FROM EMPS
WHERE EMPLOYEE_ID = 103;

UPDATE EMPS
SET HIRE_DATE = SYSDATE,
    LAST_NAME = 'HONG',
    SALARY = SALARY + 1000
WHERE EMPLOYEE_ID = 103;    
--EX2
UPDATE EMPS
SET COMMISSION_PCT = 0.1
WHERE JOB_ID IN ('IT_PROG', 'AS_MAN');

SELECT * FROM EMPS;

--EX3
--ID 200�� �޿��� 103���� �����ϰ� ����
UPDATE EMPS
SET SALARY = (SELECT SALARY FROM EMPS WHERE EMPLOYEE_ID = 103)
WHERE EMPLOYEE_ID = 200;

--EX4
UPDATE EMPS
SET (JOB_ID, SALARY, COMMISSION_PCT) = (SELECT JOB_ID, SALARY, COMMISSION_PCT FROM EMPS WHERE EMPLOYEE_ID = 103)
WHERE EMPLOYEE_ID = 200;

SELECT * FROM EMPS;
---------------------------------------------------------------------------------
CREATE TABLE DEPTS AS (SELECT * FROM DEPARTMENTS WHERE 1 = 1); --���̺� ���� + ������ ����

SELECT * FROM DEPTS;
SELECT * FROM EMPS;

--EX1 - ������  ���� �� PK�� �̿��մϴ�.
DELETE FROM EMPS WHERE EMPLOYEE_ID =200;

--EX2 - 
SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'IT';

DELETE FROM DEPTS WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'IT');

--EMPLOYEE�� 60�� �μ��� ����ϰ� �ֱ� ������ ���� �Ұ�
DELETE FROM DEPARTMENTS WHERE DEPARTMENT_ID = 60;

--MEGE��
--�� ���̺��� ���ؼ� �����Ͱ� ������ UPDATE, ������ INSERT
SELECT * FROM EMPLOYEES;
SELECT * FROM EMPS;

MERGE INTO EMPS E1
USING (SELECT * FROM EMPLOYEES WHERE JOB_ID IN ('IT_PROG', 'SA_MAN')) E2
ON (E1.EMPLOYEE_ID = E2.EMPLOYEE_ID)
WHEN MATCHED THEN
    UPDATE SET E1.HIRE_DATE = E2.HIRE_DATE,
               E1.SALARY = E2.SALARY,
               E1.COMMISSION_PCT = E2.COMMISSION_PCT
WHEN NOT MATCHED THEN
    INSERT VALUES(E2.EMPLOYEE_ID, 
                  E2.FIRST_NAME,
                  E2.LAST_NAME,
                  E2.EMAIL,
                  E2.PHONE_NUMBER,
                  E2.HIRE_DATE,
                  E2.JOB_ID,
                  E2.SALARY,
                  E2.COMMISSION_PCT,
                  E2.MANAGER_ID,
                  E2.DEPARTMENT_ID);
                  
--MERGE2
SELECT * FROM EMPS;

MERGE INTO EMPS E
USING DUAL
ON (E.EMPLOYEE_ID = 103)
WHEN MATCHED THEN
    UPDATE SET LAST_NAME = 'DEMO'
WHEN NOT MATCHED THEN
    INSERT(EMPLOYEE_ID,
           LAST_NAME,
           EMAIL,
           HIRE_DATE,
           JOB_ID) VALUES(1000,'DEMO', 'DEMO', SYSDATE, 'DEMO');
--           
DELETE FROM EMPS WHERE EMPLOYEE_ID = 103;
DESC EMPS;
--------------------------------------------------------------------------------
INSERT INTO DEPARTMENTS VALUES(300, 'DEV', NULL, 1700);

--����1
SELECT * FROM DEPTS;
INSERT INTO DEPTS VALUES(280, '����', NULL, 1800);
INSERT INTO DEPTS VALUES(290, 'ȸ���', NULL, 1800);
INSERT INTO DEPTS VALUES(300, '����', 301, 1800);
INSERT INTO DEPTS VALUES(310, '�λ�', 302, 1800);
INSERT INTO DEPTS VALUES(320, '����', 303, 1700);

--���� 2.
--DEPTS���̺��� �����͸� �����մϴ�
--1. department_name �� IT Support �� �������� department_name�� IT bank�� ����
--2. department_id�� 290�� �������� manager_id�� 301�� ����
--3. department_name�� IT Helpdesk�� �������� �μ����� IT Help�� , �Ŵ������̵� 303����, �������̵�
--1800���� �����ϼ���
--4. ����, �λ�, ������ �Ŵ������̵� 301�� �ѹ��� �����ϼ���.
SELECT * FROM DEPTS;

UPDATE DEPTS
SET DEPARTMENT_NAME = 'IT BAMK'
WHERE DEPARTMENT_ID = 210;

UPDATE DEPTS
SET MANAGER_ID = 301
WHERE DEPARTMENT_ID = 290;

UPDATE DEPTS
SET DEPARTMENT_NAME = 'IT Help',
    MANAGER_ID = 303,
    LOCATION_ID = 1800
WHERE DEPARTMENT_NAME = 'IT Helpdesk';

UPDATE DEPTS
SET MANAGER_ID = 301
WHERE DEPARTMENT_NAME IN ('����','�λ�','����');
--���� 3.
--������ ������ �׻� primary key�� �մϴ�, ���⼭ primary key�� department_id��� �����մϴ�.
--1. �μ��� �����θ� ���� �ϼ���
--2. �μ��� NOC�� �����ϼ���
SELECT * FROM DEPTS;
DELETE FROM DEPTS WHERE DEPARTMENT_ID = 320;
DELETE FROM DEPTS WHERE DEPARTMENT_ID = 220;


--����4
--1. Depts �纻���̺��� department_id �� 200���� ū �����͸� �����ϼ���.
--2. Depts �纻���̺��� manager_id�� null�� �ƴ� �������� manager_id�� ���� 100���� �����ϼ���.
--3. Depts ���̺��� Ÿ�� ���̺� �Դϴ�.
--4. Departments���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� Depts�� ���Ͽ�
--��ġ�ϴ� ��� Depts�� �μ���, �Ŵ���ID, ����ID�� ������Ʈ �ϰ�
--�������Ե� �����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���.
CREATE TABLE DEPTS2 AS (SELECT * FROM DEPTS WHERE 1 = 1); --�纻�����
SELECT * FROM DEPTS2;
SELECT * FROM DEPARTMENTS;

DELETE 
FROM DEPTS2
WHERE DEPARTMENT_ID > 200;

UPDATE DEPTS2
SET MANAGER_ID = 100
WHERE DEPARTMENT_ID < 120;


MERGE INTO DEPTS DEP
USING DEPARTMENTS D
ON(DEP.DEPARTMENT_ID = D.DEPARTMENT_ID)
WHEN MATCHED THEN
    UPDATE SET DEP.DEPARTMENT_NAME = D.DEPARTMENT_NAME,
               DEP.MANAGER_ID = D.MANAGER_ID,
               DEP.LOCATION_ID = D.LOCATION_ID
WHEN NOT MATCHED THEN
    INSERT VALUES (D.DEPARTMENT_ID,
                  D.DEPARTMENT_NAME,
                  D.MANAGER_ID,
                  D.LOCATION_ID);
