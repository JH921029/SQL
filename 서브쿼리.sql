--��������
--SELECT���� SELECT�������� ���� ���� : ��Į�� ��������
--SELECT���� FROM�������� ���� ���� : �ζ��κ�
--SELECT���� WHERE�������� ���� : ��������
--���������� �ݵ�� () �ȿ� �����ϴ�.

--������ �������� - ���ϵǴ� ���� 1���� ��������

SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy';

SELECT * FROM EMPLOYEES WHERE SALARY > 12008;

SELECT * 
FROM EMPLOYEES 
WHERE SALARY > (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy');

--EMPLOYEE_ID�� 103���� ����� ������ ����
SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103;

SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (
                SELECT JOB_ID 
                FROM EMPLOYEES 
                WHERE EMPLOYEE_ID = 103
                );
--��������, ������ �̾�� �մϴ�. �÷����� 1�� �����մϴ�.
--ERR
SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103 OR EMPLOYEE_ID = 104);


--------------------------------------------------------------------------------
SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David';

--IN ������ ���� ã�� IN(4800, 6800, 9500)
SELECT *
FROM EMPLOYEES
WHERE SALARY IN (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

--ANY �ּҰ� ���� ũ��, �ִ밪 ���� ����
SELECT *
FROM EMPLOYEES
WHERE SALARY > ANY (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David'); --�޿��� 4800���� ū �����

SELECT *
FROM EMPLOYEES
WHERE SALARY < ANY (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David'); --Ů���� 9500���� ���� �����

--ALL �ʼҰ����� �۰�, �ִ밪���� ŭ
SELECT *
FROM EMPLOYEES
WHERE SALARY > ALL (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David'); --�޿��� 9500���� ū �����

SELECT *
FROM EMPLOYEES
WHERE SALARY < ALL (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David'); --�޿��� 4800���� ���� �����

--������ IT_PROG�� �ּҰ����� ū �޿��� �޴� �����
SELECT *
FROM EMPLOYEES
WHERE SALARY > ANY (SELECT SALARY FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');
