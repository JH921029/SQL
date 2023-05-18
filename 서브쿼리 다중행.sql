--서브쿼리
--SELECT문이 SELECT구문으로 들어가는 형태 : 스칼라 서브쿼리
--SELECT문이 FROM구문으로 들어가는 형태 : 인라인뷰
--SELECT문이 WHERE구문으로 들어가면 : 서브쿼리
--서브쿼리는 반드시 () 안에 적습니다.

--단일행 서브쿼리 - 리턴되는 행이 1개인 서브쿼리

SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy';

SELECT * FROM EMPLOYEES WHERE SALARY > 12008;

SELECT * 
FROM EMPLOYEES 
WHERE SALARY > (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy');

--EMPLOYEE_ID가 103번인 사람과 동일한 직군
SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103;

SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (
                SELECT JOB_ID 
                FROM EMPLOYEES 
                WHERE EMPLOYEE_ID = 103
                );
--주의할점, 단일행 이어야 합니다. 컬러값도 1개 여야합니다.
--ERR
SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103 OR EMPLOYEE_ID = 104);


--------------------------------------------------------------------------------
SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David';

--IN 동일한 값을 찾음 IN(4800, 6800, 9500)
SELECT *
FROM EMPLOYEES
WHERE SALARY IN (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

--ANY 최소값 보다 크고, 최대값 보다 작음
SELECT *
FROM EMPLOYEES
WHERE SALARY > ANY (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David'); --급여가 4800보다 큰 사람들

SELECT *
FROM EMPLOYEES
WHERE SALARY < ANY (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David'); --큽여가 9500보다 작은 사람들

--ALL 최소값 보다 작고, 최대값 보다 큼
SELECT *
FROM EMPLOYEES
WHERE SALARY > ALL (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David'); --급여가 9500보다 큰 사람들

SELECT *
FROM EMPLOYEES
WHERE SALARY < ALL (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David'); --급여가 4800보다 작은 사람들

--직업이 IT_PROG인 최소값보다 큰 급여를 받는 사람들
SELECT *
FROM EMPLOYEES
WHERE SALARY > ANY (SELECT SALARY FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');

--------------------------------------------------------------------------------
--스칼라 서브쿼리
--JOIN시에 특정 테이블의 1컬럼을 가지고 올 대 유리합니다. 한번에 한컬럼씩
SELECT FIRST_NAME, 
       EMAIL,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID)
FROM EMPLOYEES E
ORDER BY FIRST_NAME;

--위와 같은결과
SELECT FIRST_NAME,
       EMAIL,
       DEPARTMENT_NAME
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER BY FIRST_NAME;


--각 부서의 매니저 이름을 출력
SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;

--JOIN
SELECT D.*,
       E.FIRST_NAME
FROM DEPARTMENTS D LEFT JOIN EMPLOYEES E ON D.MANAGER_ID = E.EMPLOYEE_ID;

--스칼라
SELECT D.*,
       (SELECT FIRST_NAME 
        FROM EMPLOYEES E 
        WHERE E.EMPLOYEE_ID = D.MANAGER_ID)
FROM DEPARTMENTS D;

--스칼라쿼리는 여러번 가능
SELECT * FROM JOBS;
SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;

SELECT E.FIRST_NAME,
       E.JOB_ID,
       (SELECT JOB_TITLE FROM JOBS J WHERE J.JOB_ID = E.JOB_ID) AS JOB_TITLE,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) AS DEPARTMENT_NAME
FROM EMPLOYEES E;

--각 부서의 사원수를 출력
SELECT DEPARTMENT_ID, COUNT(*) FROM EMPLOYEES GROUP BY DEPARTMENT_ID;

SELECT D.*,
       NVL((SELECT COUNT(*) FROM EMPLOYEES E WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID GROUP BY DEPARTMENT_ID),0)AS 사원수
FROM DEPARTMENTS D;


--------------------------------------------------------------------------------
--인라인 뷰
--가짜의 테이블 형태

--ROWNUM은 조회된 순서이기 때문에 ORDER와 같이 사용되면 ROWNUM이 섞이는 문제가 있다
SELECT FIRST_NAME,
       SALARY,
       ROWNUM
FROM (SELECT *
    FROM EMPLOYEES
    ORDER BY SALARY DESC);
    
--문법 (엘리어스 가능)
SELECT ROWNUM,
       A.*
FROM (SELECT FIRST_NAME, 
             SALARY
      FROM EMPLOYEES
      ORDER BY SALARY
      ) A;--여기 A
      
--ROWNUM은 무조건 1번째부터 조회가 가능하기 때문에 그렇습니다. (BETWEEN 11 AND 20) 안됨
SELECT FIRST_NAME,
       SALARY,
       ROWNUM
FROM (SELECT *
      FROM EMPLOYEES
      ORDER BY SALARY DESC)
WHERE ROWNUM BETWEEN 1 AND 10;
      
--2번째 인라인뷰에서 ROWNUM을 RN으로 컬럼화
SELECT *
FROM (SELECT FIRST_NAME,
       SALARY,
       ROWNUM AS RN
    FROM(SELECT *
       FROM EMPLOYEES 
       ORDER BY SALARY DESC)
      )
WHERE RN >= 51 AND RN <= 60;


--인라인 뷰의 예시
--SELECT * TO_CHAR(REGDATE, 'YY-MM-DD') AS REGDATE,NAME
--FROM(SELECT '홍길동', SYSDATE AS REGDATE 
--    FROM DUAL
--    UNION ALL
--    SELECT '이순신', SYSDATE FROM DUAL);

    
    
--인라인 뷰의 응용
--부서별 사원수
SELECT D.*,
       E.TOTAL
FROM DEPARTMENTS D
LEFT JOIN (SELECT DEPARTMENT_ID, 
                    COUNT(*) AS TOTAL
           FROM EMPLOYEES
           GROUP BY DEPARTMENT_ID) E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;

--정리
--단일행(대소비교) VS 다중행 서브쿼리 (IN, ANY, ALL)
--스칼라쿼리 (SELECT에 들어갑니다) - LEFT JOIN과 같은 역할을 하고 한번에 1개의 컬럼을 가져올 때 쓰면 좋음
--인라인뷰 (FROM에 들어가는 가짜 테이블)




--문제 1.
---EMPLOYEES 테이블에서 모든 사원들의 평균급여보다 높은 사원들을 데이터를 출력 하세요 ( AVG(컬럼) 사용)
---EMPLOYEES 테이블에서 모든 사원들의 평균급여보다 높은 사원들을 수를 출력하세요
---EMPLOYEES 테이블에서 job_id가 IT_PFOG인 사원들의 평균급여보다 높은 사원들을 데이터를 출력하세요



--문제 2.
---DEPARTMENTS테이블에서 manager_id가 100인 사람의 department_id와
--EMPLOYEES테이블에서 department_id가 일치하는 모든 사원의 정보를 검색하세요.


--문제 3.
---EMPLOYEES테이블에서 “Pat”의 manager_id보다 높은 manager_id를 갖는 모든 사원의 데이터를 출력하세요
---EMPLOYEES테이블에서 “James”(2명)들의 manager_id와 갖는 모든 사원의 데이터를 출력하세요.

--문제 4.
---EMPLOYEES테이블 에서 first_name기준으로 내림차순 정렬하고, 41~50번째 데이터의 행 번호, 이름을 출력하세요

--문제 5.
---EMPLOYEES테이블에서 hire_date기준으로 오름차순 정렬하고, 31~40번째 데이터의 행 번호, 사원id, 이름, 번호, 
--입사일을 출력하세요.


--문제 6.
--employees테이블 departments테이블을 left 조인하세요
--조건) 직원아이디, 이름(성, 이름), 부서아이디, 부서명 만 출력합니다.
--조건) 직원아이디 기준 오름차순 정렬

--문제 7.
--문제 6의 결과를 (스칼라 쿼리)로 동일하게 조회하세요


--문제 8.
--departments테이블 locations테이블을 left 조인하세요
--조건) 부서아이디, 부서이름, 매니저아이디, 로케이션아이디, 스트릿_어드레스, 포스트 코드, 시티 만 출력합니다
--조건) 부서아이디 기준 오름차순 정렬


--문제 9.
--문제 8의 결과를 (스칼라 쿼리)로 동일하게 조회하세요


--문제 10.
--locations테이블 countries 테이블을 left 조인하세요
--조건) 로케이션아이디, 주소, 시티, country_id, country_name 만 출력합니다
--조건) country_name기준 오름차순 정렬

--문제 11.
--문제 10의 결과를 (스칼라 쿼리)로 동일하게 조회하세요

