--���� 1.
---EMPLOYEES ���̺��, DEPARTMENTS ���̺��� DEPARTMENT_ID�� ����Ǿ� �ֽ��ϴ�.
---EMPLOYEES, DEPARTMENTS ���̺��� ������� �̿��ؼ�
--���� INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER ���� �ϼ���. (�޶����� ���� ���� Ȯ��)
SELECT * FROM EMPLOYEES E JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
SELECT * FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
SELECT * FROM EMPLOYEES E RIGHT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
SELECT * FROM EMPLOYEES E FULL JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

--���� 2.
---EMPLOYEES, DEPARTMENTS ���̺��� INNER JOIN�ϼ���
--����)employee_id�� 200�� ����� �̸�, department_id�� ����ϼ���
--����)�̸� �÷��� first_name�� last_name�� ���ļ� ����մϴ�
SELECT FIRST_NAME || LAST_NAME, E.DEPARTMENT_ID
FROM EMPLOYEES E JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE Employee_ID >= 200;

--���� 3.
---EMPLOYEES, JOBS���̺��� INNER JOIN�ϼ���
--����) ��� ����� �̸��� �������̵�, ���� Ÿ��Ʋ�� ����ϰ�, �̸� �������� �������� ����
--HINT) � �÷����� ���� ����� �ִ��� Ȯ��
SELECT E.FIRST_NAME || E.LAST_NAME NAME, E.JOB_ID, J.JOB_TITLE 
FROM EMPLOYEES E JOIN JOBS J ON E.JOB_ID = J.JOB_ID
ORDER BY NAME;

--���� 4.
----JOBS���̺�� JOB_HISTORY���̺��� LEFT_OUTER JOIN �ϼ���.
SELECT * FROM JOBS LEFT JOIN JOB_HISTORY ON jobs.job_id = job_history.job_id;

--���� 5.
----Steven King�� �μ����� ����ϼ���.
SELECT E.FIRST_NAME || E.LAST_NAME NAME, J.JOB_TITLE 
FROM EMPLOYEES E JOIN JOBS J ON E.JOB_ID = J.JOB_ID
WHERE E.EMPLOYEE_ID = '100';

SELECT FIRST_NAME, DEPARTMENT_NAME
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE FIRST_NAME = 'Steven' AND LAST_NAME = 'King';

--���� 6.
----EMPLOYEES ���̺�� DEPARTMENTS ���̺��� Cartesian Product(Cross join)ó���ϼ���
SELECT * FROM EMPLOYEES E CROSS JOIN DEPARTMENTS D;

--���� 7.
----EMPLOYEES ���̺�� DEPARTMENTS ���̺��� �μ���ȣ�� �����ϰ� SA_MAN ������� �����ȣ, �̸�, 
--�޿�, �μ���, �ٹ����� ����ϼ���. (Alias�� ���)
SELECT D.DEPARTMENT_ID, E.EMPLOYEE_ID, E.FIRST_NAME || E.LAST_NAME, E.SALARY, D.DEPARTMENT_NAME, D.LOCATION_ID, L.CITY || L.STREET_ADDRESS
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                 LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
WHERE JOB_ID = 'SA_MAN';

SELECT * FROM LOCATIONS;
--���� 8.
---- employees, jobs ���̺��� ���� �����ϰ� job_title�� 'Stock Manager', 'Stock Clerk'�� ���� ������
--����ϼ���.
SELECT E.*,
       J.JOB_TITLE
FROM EMPLOYEES E LEFT JOIN JOBS J ON E.JOB_ID = J.JOB_ID
WHERE JOB_TITLE IN ('Stock Manager', 'Stock Clerk');

--���� 9.
---- departments ���̺��� ������ ���� �μ��� ã�� ����ϼ���. LEFT OUTER JOIN ���
SELECT * FROM DEPARTMENTS
WHERE MANAGER_ID IS NULL;

SELECT * 
FROM DEPARTMENTS D LEFT JOIN EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
WHERE EMPLOYEE_ID IS NULL;

--���� 10. 
---join�� �̿��ؼ� ����� �̸��� �� ����� �Ŵ��� �̸��� ����ϼ���
--��Ʈ) EMPLOYEES ���̺�� EMPLOYEES ���̺��� �����ϼ���.
SELECT  E1.FIRST_NAME AS �����,
       E2.FIRST_NAME AS �����
FROM EMPLOYEES E1 LEFT JOIN EMPLOYEES E2 ON E1.MANAGER_ID = E2.EMPLOYEE_ID;

--���� 11. 
----6. EMPLOYEES ���̺��� left join�Ͽ� ������(�Ŵ���)��, �Ŵ����� �̸�, �Ŵ����� �޿� ���� ����ϼ���
----�Ŵ��� ���̵� ���� ����� �����ϰ� �޿��� �������� ����ϼ���
SELECT E1.FIRST_NAME �����,
       E1.SALARY AS ����޿�,
       E2.EMPLOYEE_ID AS �Ŵ������̵�,
       E2.FIRST_NAME AS �Ŵ�����,
       E2.SALARY AS �Ŵ����޿�
FROM EMPLOYEES E1 LEFT JOIN EMPLOYEES E2 ON E1.MANAGER_ID = E2.EMPLOYEE_ID
WHERE E1.MANAGER_ID IS NOT NULL
ORDER BY E1.SALARY DESC;
