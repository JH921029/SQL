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
SELECT *
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY)FROM EMPLOYEES);

SELECT COUNT(*)
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY)FROM EMPLOYEES);

SELECT *
FROM EMPLOYEES
WHERE SALARY >(SELECT AVG(SALARY) FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');
--���� 2.
---DEPARTMENTS���̺��� manager_id�� 100�� ����� department_id��
--EMPLOYEES���̺��� department_id�� ��ġ�ϴ� ��� ����� ������ �˻��ϼ���.
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID =(SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE MANAGER_ID = 100);

--���� 3.
---EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� ����ϼ���
---EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ������� ����� �����͸� ����ϼ���.

SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID > (SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Pat');

--������ IN�������
SELECT *
FROM EMPLOYEES WHERE MANAGER_ID IN(SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'James');


--���� 4.
---EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� �� ��ȣ, �̸��� ����ϼ���

SELECT *
FROM (
      SELECT E.*,
             ROWNUM AS RN
      FROM (SELECT * 
            FROM EMPLOYEES 
            ORDER BY FIRST_NAME DESC) E
      
      )
WHERE RN >40 AND RN <= 50;

--���� 5.
---EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� �� ��ȣ, ���id, �̸�, ��ȣ, �Ի����� ����ϼ���.

SELECT *
FROM(SELECT E.*,
     ROWNUM RN
     FROM (SELECT EMPLOYEE_ID, 
                  FIRST_NAME || ' ' || LAST_NAME AS NAME,
                  PHONE_NUMBER,
                  HIRE_DATE
           FROM EMPLOYEES
           ORDER BY HIRE_DATE) E
     )
WHERE RN BETWEEN 31 AND 40;



--���� 6.
--employees���̺� departments���̺��� left �����ϼ���
--����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
--����) �������̵� ���� �������� ����
SELECT EMPLOYEE_ID,
       FIRST_NAME || LAST_NAME AS NAME,
       D.DEPARTMENT_ID,
       DEPARTMENT_NAME
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID;

--���� 7.
--���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT EMPLOYEE_ID,
       FIRST_NAME || LAST_NAME AS NAME,
       DEPARTMENT_ID,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) AS DEPARTMENT_NAME
FROM EMPLOYEES E
ORDER BY EMPLOYEE_ID;
       


--���� 8.
--departments���̺� locations���̺��� left �����ϼ���
--����) �μ����̵�, �μ��̸�, �Ŵ������̵�, �����̼Ǿ��̵�, ��Ʈ��_��巹��, ����Ʈ �ڵ�, ��Ƽ �� ����մϴ�
--����) �μ����̵� ���� �������� ����
SELECT D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME,
       D.MANAGER_ID,
       D.LOCATION_ID,
       L.STREET_ADDRESS,
       L.POSTAL_CODE,
       L.CITY
FROM DEPARTMENTS D
LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
ORDER BY DEPARTMENT_ID;


--���� 9.
--���� 8�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT DEPARTMENT_ID,
       DEPARTMENT_NAME,
       MANAGER_ID,
       LOCATION_ID,
       (SELECT STREET_ADDRESS FROM LOCATIONS L WHERE L.LOCATION_ID = D.LOCATION_ID),
       (SELECT POSTAL_CODE FROM LOCATIONS L WHERE L.LOCATION_ID = D.LOCATION_ID),
       (SELECT CITY FROM LOCATIONS L WHERE L.LOCATION_ID = D.LOCATION_ID)
FROM DEPARTMENTS D
ORDER BY DEPARTMENT_ID;

--���� 10.
--locations���̺� countries ���̺��� left �����ϼ���
--����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
--����) country_name���� �������� ����
SELECT * FROM COUNTRIES;
SELECT * FROM LOCATIONS;

SELECT L.LOCATION_ID,
       L.STREET_ADDRESS,
       L.CITY,
       L.COUNTRY_ID,
       C.COUNTRY_NAME
FROM LOCATIONS L LEFT JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
ORDER BY COUNTRY_NAME;
--���� 11.
--���� 10�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT L.LOCATION_ID,
       L.STREET_ADDRESS,
       L.CITY,
       L.COUNTRY_ID,
       (SELECT COUNTRY_NAME FROM COUNTRIES C WHERE L.COUNTRY_ID = C.COUNTRY_ID )
FROM LOCATIONS L;

--���ΰ� ��������
--���� 12. 
--employees���̺�, departments���̺��� left���� hire_date�� �������� �������� 1-10��° �����͸� ����մϴ�
--����) rownum�� �����Ͽ� ��ȣ, �������̵�, �̸�, ��ȭ��ȣ, �Ի���, �μ����̵�, �μ��̸� �� ����մϴ�.
--����) hire_date�� �������� �������� ���� �Ǿ�� �մϴ�. rownum�� Ʋ������ �ȵ˴ϴ�.

SELECT *
FROM(SELECT ROWNUM RN,
                   A.*
     FROM(SELECT E.EMPLOYEE_ID,
                 E.FIRST_NAME,
                 E.PHONE_NUMBER,
                 E.HIRE_DATE,
                 E.DEPARTMENT_ID,
                 D.DEPARTMENT_NAME
          FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
          ORDER BY HIRE_DATE) A
    )
WHERE RN > 0 AND RN <= 10;

--���� 13. 
----EMPLOYEES �� DEPARTMENTS ���̺��� JOB_ID�� SA_MAN�� ����� ������ LAST_NAME, JOB_ID, 
--DEPARTMENT_ID,DEPARTMENT_NAME�� ����ϼ���

SELECT A.LAST_NAME,
       A.JOB_ID,
       D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME
FROM (SELECT * FROM EMPLOYEES WHERE JOB_ID = 'SA_MAN') A JOIN DEPARTMENTS D ON A.DEPARTMENT_ID = D.DEPARTMENT_ID;

--���� 14
----DEPARTMENT���̺��� �� �μ��� ID, NAME, MANAGER_ID�� �μ��� ���� �ο����� ����ϼ���.
----�ο��� ���� �������� �����ϼ���.
----����� ���� �μ��� ������� ���� �ʽ��ϴ�

SELECT *
FROM DEPARTMENTS D JOIN (SELECT E.DEPARTMENT_ID, COUNT(*) CNT
                         FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                         GROUP BY E.DEPARTMENT_ID) 
                    A ON D.DEPARTMENT_ID = A.DEPARTMENT_ID
                    ORDER BY CNT DESC ;


SELECT D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME,
       D.MANAGER_ID,
       E.�ο���
FROM DEPARTMENTS D
JOIN (SELECT DEPARTMENT_ID,
             COUNT(*) AS �ο���
      FROM EMPLOYEES
      GROUP BY DEPARTMENT_ID) E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER BY �ο��� DESC;


                    
--���� 15
----�μ��� ���� ���� ���ο�, �ּ�, �����ȣ, �μ��� ��� ������ ���ؼ� ����ϼ���
----�μ��� ����� ������ 0���� ����ϼ���

SELECT *
FROM (SELECT E.DEPARTMENT_ID, 
             D.LOCATION_ID,
             TRUNC(AVG(NVL(SALARY,0))) ��ձ޿�
      FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
      GROUP BY E.DEPARTMENT_ID, LOCATION_ID) A 
      LEFT JOIN LOCATIONS L ON A.LOCATION_ID = L.LOCATION_ID;
--------------------------------------------------------------------------------
SELECT D.*,
       NVL(E.SALARY, 0) AS SALARY,
       L.STREET_ADDRESS,
       L.POSTAL_CODE
FROM DEPARTMENTS D
LEFT JOIN (SELECT DEPARTMENT_ID,
                  TRUNC(AVG(SALARY)) AS SALARY
            FROM EMPLOYEES
            GROUP BY DEPARTMENT_ID) E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
LEFT JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID;



--���� 16
---���� 15����� ���� DEPARTMENT_ID�������� �������� �����ؼ� ROWNUM�� �ٿ� 1-10������ ������
--����ϼ���

SELECT *
FROM(SELECT ROWNUM RN,
           X.*
    FROM(SELECT D.*,
               NVL(E.SALARY, 0) AS SALARY,
               L.STREET_ADDRESS,
               L.POSTAL_CODE
        FROM DEPARTMENTS D
        LEFT JOIN (SELECT DEPARTMENT_ID,
                          TRUNC(AVG(SALARY)) AS SALARY
                    FROM EMPLOYEES
                    GROUP BY DEPARTMENT_ID) E
        ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
        LEFT JOIN LOCATIONS L
        ON D.LOCATION_ID = L.LOCATION_ID
        ORDER BY D.DEPARTMENT_ID DESC
        ) X
    )
WHERE RN >=10 AND RN <=20;
