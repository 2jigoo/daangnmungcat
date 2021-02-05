/*1. 10분 간격으로 실행
	SYSDATE + 1/24/6
2. 현재 시간으로 부터 하루 뒤 다음 날 현재 시간에 실행 (매일)
	SYSDATE + 1 
3. 매일 새벽 5시
	TRUNC(SYSDATE) + 1 + 5 / 24
4. 매일 밤 10시
	TRUNC(SYSDATE)  + 20 / 24
5. 1분 간격
	SYSDATE + 1/24/60*/
DROP PROCEDURE DELETE_CART_PROC;

CREATE OR REPLACE PROCEDURE DELETE_CART_PROC
   IS
      BEGIN
       -- 예약 날짜 지나감 -> 미방문
	  	DELETE FROM MALL_CART mc WHERE trunc(regdate) + 7 <= trunc(sysdate);
      END;
     
     
-- job 생성
DECLARE
   X NUMBER;
BEGIN
   SYS.DBMS_JOB.SUBMIT
   (
   JOB => X
   , WHAT => 'DELETE_CART_PROC;'
   , NEXT_DATE => SYSDATE
   , INTERVAL => 'TRUNC(SYSDATE) + 1'
   , NO_PARSE => TRUE
   );
END;


-- 등록된 job 확인
SELECT * FROM USER_JOBS;
SELECT JOB FROM USER_JOBS WHERE WHAT = 'DELETE_CART_PROC;';

-- 마지막 실행시간, 다음 실행시간, 실행시간, 활성화 비활성화 여부, 실패 횟수, 실핼항 Object
SELECT JOB, LAST_DATE, NEXT_DATE, TOTAL_TIME, BROKEN, FAILURES, WHAT FROM USER_JOBS;

GRANT EXECUTE on SYS.DBMS_JOB to DAANGNUSER WITH GRANT OPTION;

-- JOB을 강제 실행
BEGIN
   DBMS_JOB.RUN(35);
   COMMIT;
END;

-- 등록되어 있는 JOB 삭제
BEGIN
   DBMS_JOB.REMOVE(35);
   COMMIT;
END;

-- 작업 비활성화 
BEGIN
   DBMS_JOB.BROKEN(35, false);
   COMMIT;
END;






/* SCHEDULER */
-- 스케쥴러에 잡 생성

/*
BEGIN
    DBMS_SCHEDULER.CREATE_JOB
    (
    JOB_NAME => 'JOB_DELETE_CART_A_WEEK',
    JOB_TYPE => 'STORED_PROCEDURE',
    JOB_ACTION => 'DELETE_CART_A_WEEK', -->프로시저명
    REPEAT_INTERVAL => 'TRUNC(SYSDATE) + 1', -- 매일 자정
    COMMENTS => '매일 자정, 등록된지 7일이 지난 장바구니 상품 삭제'
    );
 END;    

SELECT * FROM USER_SCHEDULER_JOBS;

-- 시작
BEGIN
    DBMS_SCHEDULER.ENABLE ('JOB_DELETE_CART_A_WEEK');
END;

SELECT * FROM USER_SCHEDULER_JOB_LOG;

-- 스케쥴러 잡 삭제
BEGIN
        DBMS_SCHEDULER.DROP_JOB(
           JOB_NAME   => 'JOB_DELETE_CART_A_WEEK',
           FORCE      => false);
END ;
*/
