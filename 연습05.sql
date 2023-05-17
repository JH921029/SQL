--형변환 함수
--지동형변환
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = '30'; --자동형변환
SELECT SYSDATE - 5, SYSDATE - '5' FROM EMPLOYEES; --자동형변환

--강제형변환
--TO_CHAR(날짜, 날짜포맷)
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS') FROM DUAL; --문자
SELECT TO_CHAR(SYSDATE, 'YY/MM/DD HH24/MI/SS') FROM DUAL; --문자
SELECT TO_CHAR(SYSDATE, 'YYYY"년 "MM"월 "DD"일"') FROM DUAL; --포맷문자가 아닌경우 ""로 묶어줍니다.
SELECT TO_CHAR(HIRE_DATE, 'YYYY-MM-DD' ) FROM EMPLOYEES;

--TO_CHAR(숫자, 숫자포맷)
SELECT TO_CHAR(200000, 'L999,999,999') FROM DUAL;
SELECT TO_CHAR(200000.162, '999,999.99') FROM DUAL;--소수점자리 표현
SELECT TO_CHAR(SALARY * 1300, 'L999,999,999') FROM EMPLOYEES;
SELECT TO_CHAR(SALARY * 1300, 'L0999,999,999') FROM EMPLOYEES;

--TO_NUMBER(문자, 숫자포맷)
SELECT '3.14' + 2000 FROM DUAL;--자동형변환
SELECT TO_NUMER('3.14') + 2000 FROM DUAL;--명시적형변환
SELECT TO_NUMBER('$3,300', '$999,999') + 2000 FROM DUAL; --명시적형변환

--TO_DATE(문자, 날짜포맷)
SELECT SYSDATE - TO_DATE('2023-05-16', 'YYYY-MM-DD') FROM DUAL;
SELECT SYSDATE - TO_DATE('2023/05/16 11:31:23', 'YYYY/MM/DD HH:MI:SS') FROM DUAL;

--아래 값을 YYYY년MM월DD일 형태로 출력
--20050105
SELECT TO_CHAR(TO_DATE ('20050105', 'YYYYMMDD'),'YYYY"년"MM"월"DD"일"') FROM DUAL;

--아래 값과 현재 날짜와의 차이를 구하세요
--2005년01월05일
SELECT SYSDATE - TO_DATE ('2005년01월05일', 'YYYY"년"MM"월"DD"일"') FROM DUAL;--모형에 그대로 맞춰주세요


----------------------------------------------------------------------------------------------------------------------

--NULL값에 대한 반환
--NVL(컬럼, NULL일경우 처리)
SELECT NVL(NULL, 0) FROM DUAL;
SELECT FIRST_NAME, COMMISSION_PCT FROM EMPLOYEES; --NULL연산시 => NULL
SELECT FIRST_NAME, NVL(COMMISSION_PCT, 0) *100 FROM EMPLOYEES;

--NVL2(컬럼, NULL이 아닌경우 처리, NULL인 경우 처리)
SELECT NVL2(NULL, '널이아닙니다', '널입니다') FROM DUAL;
SELECT FIRST_NAME,
       SALARY,
       NVL2(COMMISSION_PCT, SALARY+(SALARY*COMMISSION_PCT), SALARY) 
FROM EMPLOYEES;--총 연봉이 얼마인가

--DECODE() - ELSE IF문을 대체하는 함수
SELECT DECODE('C', 'A', 'A입니다.',
                   'B', 'B입니다.',
                   'C', 'C입니다.',
                    'ABC가 아닙니다') FROM DUAL;
                    
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


--COALESCE(A,B) -NVL이랑 유사(NULL일 경우에 0으로 치환)
SELECT COALESCE(COMMISSION_PCT, 0) FROM EMPLOYEES;







-------------------------------------------------------------------------------
SELECT EMPLOYEE_ID 사원번호,
       FIRST_NAME || LAST_NAME 사원명, 
       HIRE_DATE 입사일자, 
       TRUNC((SYSDATE - HIRE_DATE)/365) 근속연수 
       FROM EMPLOYEES 
WHERE TRUNC((SYSDATE - HIRE_DATE)/365) >= 10 
ORDER BY 근속연수 DESC;


SELECT * FROM EMPLOYEES;
SELECT FIRST_NAME, 
       MANAGER_ID,
       DECODE(MANAGER_ID, 100, '사원',
                          120, '주임',
                          121, '대리',
                          122, '과장',
                          '임원') AS 직급
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50;