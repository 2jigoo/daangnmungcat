SELECT * FROM MEMBER;
--id VARCHAR2(20) NOT NULL PRIMARY key, /* 회원아이디 */
--	pwd VARCHAR2(255) NOT NULL, /* 비밀번호 */
--	name VARCHAR2(36) NOT NULL, /* 이름 */
--	nickname VARCHAR2(36) NOT NULL, /* 닉네임 */
--	email VARCHAR2(50) NOT NULL, /* 이메일 */
--	phone VARCHAR2(20) NOT NULL, /* 연락처 */
--	mydongne VARCHAR2(30) NOT NULL, /* 내동네 */
--	grade NUMBER(1) NOT NULL, /* 등급 */
--	profile_pic VARCHAR2(255), /* 프로필사진 */
--	profile_text VARCHAR2(600),/* 프로필소개 */
--	regdate DATE DEFAULT sysdate /* 가입일 */

INSERT INTO MEMBER VALUES('admin', '1234', '관리자', '관리자', 'admin@admin.co.kr', '010-1234-1234', '대구광역시 서구', 1, NULL, NULL, sysdate);
INSERT INTO MEMBER VALUES('test', '1234', '테스트', '테스트닉', 'test@test.co.kr', '010-5656-5656', '대구광역시 서구', 1, NULL, NULL, sysdate);

SELECT * FROM MEMBER;

SELECT 1 FROM MEMBER WHERE id = 'admin' and pwd = '1234';
SELECT 1 FROM dual;