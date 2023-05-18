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

--ALL �ּҰ� ���� �۰�, �ִ밪 ���� ŭ
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

--------------------------------------------------------------------------------
--��Į�� ��������
--JOIN�ÿ� Ư�� ���̺��� 1�÷��� ������ �� �� �����մϴ�. �ѹ��� ���÷���
SELECT FIRST_NAME, 
       EMAIL,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID)
FROM EMPLOYEES E
ORDER BY FIRST_NAME;

--���� �������
SELECT FIRST_NAME,
       EMAIL,
       DEPARTMENT_NAME
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER BY FIRST_NAME;


--�� �μ��� �Ŵ��� �̸��� ���
SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;

--JOIN
SELECT D.*,
       E.FIRST_NAME
FROM DEPARTMENTS D LEFT JOIN EMPLOYEES E ON D.MANAGER_ID = E.EMPLOYEE_ID;

--��Į��
SELECT D.*,
       (SELECT FIRST_NAME 
        FROM EMPLOYEES E 
        WHERE E.EMPLOYEE_ID = D.MANAGER_ID)
FROM DEPARTMENTS D;

--��Į�������� ������ ����
SELECT * FROM JOBS;
SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;

SELECT E.FIRST_NAME,
       E.JOB_ID,
       (SELECT JOB_TITLE FROM JOBS J WHERE J.JOB_ID = E.JOB_ID) AS JOB_TITLE,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) AS DEPARTMENT_NAME
FROM EMPLOYEES E;

--�� �μ��� ������� ���
SELECT DEPARTMENT_ID, COUNT(*) FROM EMPLOYEES GROUP BY DEPARTMENT_ID;

SELECT D.*,
       NVL((SELECT COUNT(*) FROM EMPLOYEES E WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID GROUP BY DEPARTMENT_ID),0)AS �����
FROM DEPARTMENTS D;


--------------------------------------------------------------------------------
--�ζ��� ��
--��¥�� ���̺� ����

--ROWNUM�� ��ȸ�� �����̱� ������ ORDER�� ���� ���Ǹ� ROWNUM�� ���̴� ������ �ִ�
SELECT FIRST_NAME,
       SALARY,
       ROWNUM
FROM (SELECT *
    FROM EMPLOYEES
    ORDER BY SALARY DESC);
    
--���� (����� ����)
SELECT ROWNUM,
       A.*
FROM (SELECT FIRST_NAME, 
             SALARY
      FROM EMPLOYEES
      ORDER BY SALARY
      ) A;--���� A
      
--ROWNUM�� ������ 1��°���� ��ȸ�� �����ϱ� ������ �׷����ϴ�. (BETWEEN 11 AND 20) �ȵ�
SELECT FIRST_NAME,
       SALARY,
       ROWNUM
FROM (SELECT *
      FROM EMPLOYEES
      ORDER BY SALARY DESC)
WHERE ROWNUM BETWEEN 1 AND 10;
      
--2��° �ζ��κ信�� ROWNUM�� RN���� �÷�ȭ
SELECT *
FROM (SELECT FIRST_NAME,
       SALARY,
       ROWNUM AS RN
    FROM(SELECT *
       FROM EMPLOYEES 
       ORDER BY SALARY DESC)
      )
WHERE RN >= 51 AND RN <= 60;


--�ζ��� ���� ����
--SELECT * TO_CHAR(REGDATE, 'YY-MM-DD') AS REGDATE,NAME
--FROM(SELECT 'ȫ�浿', SYSDATE AS REGDATE 
--    FROM DUAL
--    UNION ALL
--    SELECT '�̼���', SYSDATE FROM DUAL);

    
    
--�ζ��� ���� ����
--�μ��� �����
SELECT D.*,
       E.TOTAL
FROM DEPARTMENTS D
LEFT JOIN (SELECT DEPARTMENT_ID, 
                    COUNT(*) AS TOTAL
           FROM EMPLOYEES
           GROUP BY DEPARTMENT_ID) E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;

--����
--������(��Һ�) VS ������ �������� (IN, ANY, ALL)
--��Į������ (SELECT�� ���ϴ�) - LEFT JOIN�� ���� ������ �ϰ� �ѹ��� 1���� �÷��� ������ �� ���� ����
--�ζ��κ� (FROM�� ���� ��¥ ���̺�)




--���� 1.
---EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� �����͸� ��� �ϼ��� ( AVG(�÷�) ���)
---EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���
---EMPLOYEES ���̺��� job_id�� IT_PFOG�� ������� ��ձ޿����� ���� ������� �����͸� ����ϼ���



--���� 2.
---DEPARTMENTS���̺��� manager_id�� 100�� ����� department_id��
--EMPLOYEES���̺��� department_id�� ��ġ�ϴ� ��� ����� ������ �˻��ϼ���.


--���� 3.
---EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� ����ϼ���
---EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.

--���� 4.
---EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� �� ��ȣ, �̸��� ����ϼ���

--���� 5.
---EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� �� ��ȣ, ���id, �̸�, ��ȣ, 
--�Ի����� ����ϼ���.


--���� 6.
--employees���̺� departments���̺��� left �����ϼ���
--����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
--����) �������̵� ���� �������� ����

--���� 7.
--���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���


--���� 8.
--departments���̺� locations���̺��� left �����ϼ���
--����) �μ����̵�, �μ��̸�, �Ŵ������̵�, �����̼Ǿ��̵�, ��Ʈ��_��巹��, ����Ʈ �ڵ�, ��Ƽ �� ����մϴ�
--����) �μ����̵� ���� �������� ����


--���� 9.
--���� 8�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���


--���� 10.
--locations���̺� countries ���̺��� left �����ϼ���
--����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
--����) country_name���� �������� ����

--���� 11.
--���� 10�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���

