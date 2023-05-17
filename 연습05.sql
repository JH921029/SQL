--����ȯ �Լ�
--��������ȯ
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = '30'; --�ڵ�����ȯ
SELECT SYSDATE - 5, SYSDATE - '5' FROM EMPLOYEES; --�ڵ�����ȯ

--��������ȯ
--TO_CHAR(��¥, ��¥����)
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS') FROM DUAL; --����
SELECT TO_CHAR(SYSDATE, 'YY/MM/DD HH24/MI/SS') FROM DUAL; --����
SELECT TO_CHAR(SYSDATE, 'YYYY"�� "MM"�� "DD"��"') FROM DUAL; --���˹��ڰ� �ƴѰ�� ""�� �����ݴϴ�.
SELECT TO_CHAR(HIRE_DATE, 'YYYY-MM-DD' ) FROM EMPLOYEES;

--TO_CHAR(����, ��������)
SELECT TO_CHAR(200000, 'L999,999,999') FROM DUAL;
SELECT TO_CHAR(200000.162, '999,999.99') FROM DUAL;--�Ҽ����ڸ� ǥ��
SELECT TO_CHAR(SALARY * 1300, 'L999,999,999') FROM EMPLOYEES;
SELECT TO_CHAR(SALARY * 1300, 'L0999,999,999') FROM EMPLOYEES;

--TO_NUMBER(����, ��������)
SELECT '3.14' + 2000 FROM DUAL;--�ڵ�����ȯ
SELECT TO_NUMER('3.14') + 2000 FROM DUAL;--���������ȯ
SELECT TO_NUMBER('$3,300', '$999,999') + 2000 FROM DUAL; --���������ȯ

--TO_DATE(����, ��¥����)
SELECT SYSDATE - TO_DATE('2023-05-16', 'YYYY-MM-DD') FROM DUAL;
SELECT SYSDATE - TO_DATE('2023/05/16 11:31:23', 'YYYY/MM/DD HH:MI:SS') FROM DUAL;

--�Ʒ� ���� YYYY��MM��DD�� ���·� ���
--20050105
SELECT TO_CHAR(TO_DATE ('20050105', 'YYYYMMDD'),'YYYY"��"MM"��"DD"��"') FROM DUAL;

--�Ʒ� ���� ���� ��¥���� ���̸� ���ϼ���
--2005��01��05��
SELECT SYSDATE - TO_DATE ('2005��01��05��', 'YYYY"��"MM"��"DD"��"') FROM DUAL;--������ �״�� �����ּ���


----------------------------------------------------------------------------------------------------------------------

--NULL���� ���� ��ȯ
--NVL(�÷�, NULL�ϰ�� ó��)
SELECT NVL(NULL, 0) FROM DUAL;
SELECT FIRST_NAME, COMMISSION_PCT FROM EMPLOYEES; --NULL����� => NULL
SELECT FIRST_NAME, NVL(COMMISSION_PCT, 0) *100 FROM EMPLOYEES;

--NVL2(�÷�, NULL�� �ƴѰ�� ó��, NULL�� ��� ó��)
SELECT NVL2(NULL, '���̾ƴմϴ�', '���Դϴ�') FROM DUAL;
SELECT FIRST_NAME,
       SALARY,
       NVL2(COMMISSION_PCT, SALARY+(SALARY*COMMISSION_PCT), SALARY) 
FROM EMPLOYEES;--�� ������ ���ΰ�

--DECODE() - ELSE IF���� ��ü�ϴ� �Լ�
SELECT DECODE('C', 'A', 'A�Դϴ�.',
                   'B', 'B�Դϴ�.',
                   'C', 'C�Դϴ�.',
                    'ABC�� �ƴմϴ�') FROM DUAL;
                    
SELECT DECODE('JIB_ID','IP_PROG', SALARY * 0.3, 
                       'FI_MGR', SALARY * 0.2, 
                        SALARY) 
FROM EMPLOYEES;
--CASE WHEN THEN ELSE
SELECT JOB_ID,
        CASE JOB_ID WHEN 'INT_PROG' THEN SALARY * 0.3
                    WHEN 'FI_MGR' THEN SALARY * 0.2
                    ELSE SALARY
    END
FROM EMPLOYEES;     

--2ND
SELECT JOB_ID,
        CASE WHEN JOB_ID = 'IT_PROG' THEN SALARY * 0.3
            WHEN JOB_ID = 'FI_MGR' THEN SALARY * 0.2
            ELSE SALARY
        END
FROM EMPLOYEES;


--COALESCE(A,B) -NVL�̶� ����(NULL�� ��쿡 0���� ġȯ)
SELECT COALESCE(COMMISSION_PCT, 0) FROM EMPLOYEES;







-------------------------------------------------------------------------------
SELECT EMPLOYEE_ID �����ȣ,
       FIRST_NAME || LAST_NAME �����, 
       HIRE_DATE �Ի�����, 
       TRUNC((SYSDATE - HIRE_DATE)/365) �ټӿ��� 
       FROM EMPLOYEES 
WHERE TRUNC((SYSDATE - HIRE_DATE)/365) >= 10 
ORDER BY �ټӿ��� DESC;


SELECT * FROM EMPLOYEES;
SELECT FIRST_NAME, 
       MANAGER_ID,
       DECODE(MANAGER_ID, 100, '���',
                          120, '����',
                          121, '�븮',
                          122, '����',
                          '�ӿ�') AS ����
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50;