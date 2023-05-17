--숫자함수
--ROUND() 반올림
SELECT ROUND(45.523, 2), ROUND(45.523), ROUND(45.523, -1) FROM DUAL;

--TRUNC()절삭
SELECT TRUNC(45.523, 2), TRUNC(45.523), TRUNC(45.523, -1) FROM DUAL;


--CEIL 무조건올림, FLOOR 무조건 내림
SELECT CEIL(3.14), FLOOR(3.14) FROM DUAL;



--MOD() - 나머지
SELECT 5 /3 몫, MOD(5,3) 나머지 FROM DUAL; --몫, 나머지

-------------------------------------------------------------
--날짜함수
SELECT SYSDATE FROM DUAL; --년/월/일
SELECT SYSTIMESTAMP FROM DUAL; --시분초 밀리세컨을 포함한 상세한 시간타입

--날짜의 연산 = 기준이 일수가 됩니다
SELECT SYSDATE - 15 FROM DUAL;
SELECT SYSDATE - 10 FROM DUAL;
SELECT SYSDATE - HIRE_DATE FROM EMPLOYEES;
SELECT (SYSDATE - HIRE_DATE) / 7 AS WEEK FROM EMPLOYEES;
SELECT (SYSDATE - HIRE_DATE) / 365 AS YEAR FROM EMPLOYEES;
SELECT TRUNC((SYSDATE - HIRE_DATE) / 365 ) * 12 AS MONTH FROM EMPLOYEES;

--날짜의 반올림, 절삭
SELECT ROUND(SYSDATE) FROM DUAL;
SELECT ROUND(SYSDATE, 'DAY') FROM DUAL; --해당 주의 일요일로
SELECT ROUND(SYSDATE, 'MONTH') FROM DUAL; --월에대한 반올림
SELECT ROUND(SYSDATE, 'YEAR') FROM DUAL; --년에대한 반올림

SELECT TRUNC(SYSDATE) FROM DUAL;
SELECT TRUNC(SYSDATE, 'DAY') FROM DUAL; --해당주의 일요일
SELECT TRUNC(SYSDATE, 'MONTH') FROM DUAL; --월에대한 절삭
SELECT TRUNC(SYSDATE, 'YEAR') FROM DUAL; --년에대한 절삭