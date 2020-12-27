SELECT * FROM MEMBER;

INSERT INTO MEMBER VALUES('admin', '1234', '관리자', '관리자', 'admin@admin.co.kr', '010-1234-1234',1, 1, 1, NULL, NULL, sysdate);

SELECT * FROM MEMBER;

SELECT 1 FROM MEMBER WHERE id = 'admin' and pwd = '1234';
SELECT NVL(null, 2) FROM MEMBER WHERE id = 'admin';

SELECT * FROM dongne_view;
SELECT * FROM member_view;

CREATE OR REPLACE VIEW member_view AS
SELECT m.id, m.pwd, m.name, m.nickname, m.email, m.phone, a.name AS dongne1 , b.name AS dongne2 , m.grade, m.profile_pic, m.profile_text, m.regdate 
FROM MEMBER m LEFT OUTER JOIN dongne1 a ON m.dongne1 = a.ID LEFT OUTER JOIN dongne2 b ON m.dongne2 = b.id;

SELECT * FROM MEMBER;
DELETE FROM MEMBER WHERE id='test2';
SELECT count(*) FROM MEMBER WHERE id = 'test' AND pwd = 1234;

SELECT count(*) FROM MEMBER WHERE id = 'admin';
SELECT count(*) FROM MEMBER WHERE EMAIL = 'admin@admin.co.kr';

INSERT INTO MEMBER(id, pwd, name, NICKNAME, EMAIL, PHONE, DONGNE1, DONGNE2, GRADE, PROFILE_PIC, PROFILE_TEXT) VALUES('test', '1234', 'test', 'test', 'test@admin.co.kr', '010-5656-1234',1, 1, 1, NULL, NULL);