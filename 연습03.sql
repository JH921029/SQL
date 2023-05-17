--문자열함수
--LOWER(), INITCAP(), UPPER()

SELECT LOWER('HELLO'),INITCAP('HELLO'),UPPER('HELLO') FROM DUAL;--DUAL은 가상 테이블
SELECT LOWER(FIRST_NAME), INITCAP(FIRST_NAME), UPPER(FIRST_NAME) FROM EMPLOYEES;
--함수는 WHERE절에도 적용됩니다.
SELECT FIRST_NAME FROM EMPLOYEES WHERE UPPER(FIRST_NAME) = 'STEVEN';

--LENGTH() - 길이, INSTR() - 문자찾기
SELECT FIRST_NAME, LENGTH(FIRST_NAME), INSTR(FIRST_NAME, 'e') FROM EMPLOYEES;

--SUBSTR() - 문자열자르기, CONCAT() - 문자열합치기
SELECT FIRST_NAME, SUBSTR(FIRST_NAME, 1, 3) FROM EMPLOYEES;--1번째에서 3글자를 자름
SELECT FIRST_NAME, CONCAT(FIRST_NAME, LAST_NAME), FIRST_NAME || LAST_NAME FROM EMPLOYEES;

--LPAD() - 완쪽 채우기, RPAD() - 오른쪽 채우기
SELECT LPAD('HELLO', 10, '*') FROM DUAL; --10칸 잡고, 왼쪽부터 채움
SELECT LPAD(SALARY, 10, '*') FROM EMPLOYEES;
SELECT RPAD(SALARY, 10, '*') FROM EMPLOYEES;--10칸 잡고, 오른쪽부터 채움

--LTRIM() - 왼쪽제거, RTRIM() - 오른쪽제거, TRIM() - 양쪽제거
SELECT LTRIM('    HELLO') FROM DUAL;
SELECT LTRIM(FIRST_NAME, 'A') FROM EMPLOYEES; --왼쪽에 처음 발견되는 문자 A제거
SELECT RTRIM('   HELLO  ') AS RESULT FROM DUAL;
SELECT TRIM('    HELLO   ') AS RESULT FROM DUAL; --양쪽 공백 제거

--REPLACE() - 문자열변경
SELECT REPLACE('HELLO WORLD', 'HELLOL', 'BYE') FROM DUAL;
SELECT REPLACE('HELLO WORLD ~! ',' ','') FROM DUAL; --HEELO WORLD ~!에서 공백을 지움

--중첩
SELECT REPLACE( REPLACE('HELLO WORLD ~!', 'HELLO', 'BYE'), ' ', '')AS RESULT FROM DUAL;

------------------------------------------------------------------------------------------------------------
--연습문제

--문제 1.
--EMPLOYEES 테이블 에서 이름, 입사일자 컬럼으로 변경해서 이름순으로 오름차순 출력 합니다.
--조건 1) 이름 컬럼은 first_name, last_name을 붙여서 출력합니다.
--조건 2) 입사일자 컬럼은 xx/xx/xx로 저장되어 있습니다. xxxxxx형태로 변경해서 출력합니다.
SELECT FIRST_NAME || LAST_NAME 이름, REPLACE(HIRE_DATE, '/', '') 입사일자 FROM EMPLOYEES ORDER BY 이름 ;

SELECT * FROM EMPLOYEES;

--문제 2.
--EMPLOYEES 테이블 에서 phone_numbe컬럼은 ###.###.####형태로 저장되어 있다
--여기서 처음 세 자리 숫자 대신 서울 지역변호 (02)를 붙여 전화 번호를 출력하도록 쿼리를 작성하세요
SELECT '(02)' || SUBSTR(PHONE_NUMBER, INSTR(PHONE_NUMBER,'.'), LENGTH(PHONE_NUMBER)) FROM EMPLOYEES;

--문제 3. 
--EMPLOYEES 테이블에서 JOB_ID가 it_prog인 사원의 이름(first_name)과 급여(salary)를 출력하세요.
--조건 1) 비교하기 위한 값은 소문자로 입력해야 합니다.(힌트 : lower 이용)
--조건 2) 이름은 앞 3문자까지 출력하고 나머지는 *로 출력합니다. 
--이 열의 열 별칭은 name입니다.(힌트 : rpad와 substr 또는 substr 그리고 length 이용)
--조건 3) 급여는 전체 10자리로 출력하되 나머지 자리는 *로 출력합니다. 
--이 열의 열 별칭은 salary입니다.(힌트 : lpad 이용)
SELECT RPAD(SUBSTR(FIRST_NAME, 1, 3), LENGTH(FIRST_NAME) , '*') NAME,
       LPAD(SALARY, 10, '*') 
       FROM EMPLOYEES WHERE LOWER(JOB_ID) = 'it_prog';





