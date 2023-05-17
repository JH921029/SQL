--1. ��� ����� �����ȣ, �̸�, �Ի���, �޿��� ����ϼ���.
SELECT * FROM EMPLOYEES;
SELECT EMPLOYEE_ID �����ȣ, (FIRST_NAME || LAST_NAME) �̸�, HIRE_DATE �Ի���, SALARY �޿� FROM EMPLOYEES;

--2. ��� ����� �̸��� ���� �ٿ� ����ϼ���. �� ��Ī�� name���� �ϼ���.
SELECT FIRST_NAME || LAST_NAME name FROM EMPLOYEES;

--3. 50�� �μ� ����� ��� ������ ����ϼ���.
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID=50;

--4. 50�� �μ� ����� �̸�, �μ���ȣ, �������̵� ����ϼ���.
SELECT FIRST_NAME || LAST_NAME, MANAGER_ID , EMPLOYEE_ID FROM EMPLOYEES WHERE DEPARTMENT_ID=50;

--5. ��� ����� �̸�, �޿� �׸��� 300�޷� �λ�� �޿��� ����ϼ���.
SELECT FIRST_NAME || LAST_NAME, SALARY, SALARY+300 FROM EMPLOYEES;

--6. �޿��� 10000���� ū ����� �̸��� �޿��� ����ϼ���.
SELECT FIRST_NAME || LAST_NAME, SALARY FROM EMPLOYEES WHERE SALARY >10000;

--7. ���ʽ��� �޴� ����� �̸��� ����, ���ʽ����� ����ϼ���.
SELECT FIRST_NAME || LAST_NAME, JOB_ID, COMMISSION_PCT FROM EMPLOYEES WHERE commission_pct IS NOT NULL;

--8. 2003�⵵ �Ի��� ����� �̸��� �Ի��� �׸��� �޿��� ����ϼ���.(BETWEEN ������ ���)
SELECT * FROM EMPLOYEES WHERE HIRE_DATE BETWEEN '03/01/01' AND '03/12/31' ;

--9. 2003�⵵ �Ի��� ����� �̸��� �Ի��� �׸��� �޿��� ����ϼ���.(LIKE ������ ���)
SELECT * FROM EMPLOYEES WHERE HIRE_DATE LIKE '03%';

--10. ��� ����� �̸��� �޿��� �޿��� ���� ������� ���� ��������� ����ϼ���.
SELECT FIRST_NAME, SALARY FROM EMPLOYEES ORDER BY SALARY DESC;

--11. �� ���Ǹ� 60�� �μ��� ����� ���ؼ��� �����ϼ���. (�÷�: department_id)
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 60 ORDER BY SALARY DESC;

--12. �������̵� IT_PROG �̰ų�, SA_MAN�� ����� �̸��� �������̵� ����ϼ���.
SELECT FIRST_NAME || LAST_NAME, JOB_ID FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG' OR JOB_ID = 'SA_MAN';

--13. Steven King ����� ������ ��Steven King ����� �޿��� 24000�޷� �Դϴ١� �������� ����ϼ���.
SELECT FIRST_NAME || LAST_NAME || '����� �޿���' || SALARY || '�޷� �Դϴ�' "StevenKing ����� ����" FROM EMPLOYEES WHERE EMPLOYEE_ID = 100;

--14. �Ŵ���(MAN) ������ �ش��ϴ� ����� �̸��� �������̵� ����ϼ���. (�÷�:job_id)
SELECT * FROM EMPLOYEES WHERE JOB_ID LIKE '%MAN';

--15. �Ŵ���(MAN) ������ �ش��ϴ� ����� �̸��� �������̵� �������̵� ������� ����ϼ���.
SELECT FIRST_NAME || LAST_NAME, JOB_ID FROM EMPLOYEES WHERE JOB_ID LIKE '%MAN' ORDER BY JOB_ID DESC;

