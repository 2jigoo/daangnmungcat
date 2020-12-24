SELECT * FROM MEMBER;

	id VARCHAR2(20) NOT NULL PRIMARY key, /* 회원아이디 */
	pwd VARCHAR2(255) NOT NULL, /* 비밀번호 */
	name VARCHAR2(36) NOT NULL, /* 이름 */
	nickname VARCHAR2(36) NOT NULL, /* 닉네임 */
	email VARCHAR2(50) NOT NULL, /* 이메일 */
	phone VARCHAR2(20) NOT NULL, /* 연락처 */
	dongne1 number(12) NOT NULL, /* 시 */
	dongne2 number(12) NOT NULL, /* 군구 */
	grade NUMBER(1) NOT NULL, /* 등급 */
	profile_pic VARCHAR2(255), /* 프로필사진 */
	profile_text VARCHAR2(600),/* 프로필소개 */
	regdate DATE DEFAULT sysdate /* 가입일 */


INSERT INTO MEMBER VALUES('admin', '1234', '관리자', '관리자', 'admin@admin.co.kr', '010-1234-1234',1, 1, 1, NULL, NULL, sysdate);

SELECT * FROM MEMBER;

SELECT 1 FROM MEMBER WHERE id = 'admin' and pwd = '1234';
SELECT NVL(null, 2) FROM MEMBER WHERE id = 'admin';

SELECT * FROM dongne_view;
SELECT * FROM member_view;

CREATE OR REPLACE VIEW member_view AS
SELECT m.id, m.pwd, m.name, m.nickname, m.email, m.phone, a.name AS dongne1 , b.name AS dongne2 , m.grade, m.profile_pic, m.profile_text, m.regdate 
FROM MEMBER m LEFT OUTER JOIN dongne1 a ON m.dongne1 = a.ID LEFT OUTER JOIN dongne2 b ON m.dongne2 = b.id;


COMMIT;

SELECT * FROM MEMBER;
SELECT 1 FROM MEMBER WHERE id = 'test' AND pwd = 1234;