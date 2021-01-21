SELECT * FROM MEMBER;
UPDATE MEMBER SET PROFILE_TEXT = '안녕하세요' WHERE id = 'test';
INSERT INTO MEMBER(ID,PWD,NAME,NICKNAME,EMAIL,PHONE ,DONGNE1,DONGNE2, BIRTHDAY,ZIPCODE,ADDRESS1,ADDRESS2) 
VALUES('test', '1234', '관리자', '관리자', 'admin@admin.co.kr', '010-1234-1234',1, 1, '1991-12-19', NULL, NULL, NULL);

UPDATE MEMBER SET phone = '010-5615-5004' WHERE id = 'test';
DELETE MEMBER WHERE id = 'admin';
SELECT * FROM MEMBER;
UPDATE MEMBER SET PROFILE_PIC = 'aksdkjsd' WHERE id = 'admin'

SELECT 1 FROM MEMBER WHERE id = 'admin' and pwd = '1234';
SELECT 1 FROM MEMBER WHERE id = 'test' and pwd = '1234';
SELECT NVL(null, 2) FROM MEMBER WHERE id = 'admin';

SELECT * FROM dongne_view;
SELECT * FROM member_view;

CREATE OR REPLACE VIEW member_view AS
SELECT m.id, m.pwd, m.name, m.nickname, m.email, m.phone, a.name AS dongne1 , b.name AS dongne2 , m.grade, g.NAME AS grade_name, m.profile_pic, m.profile_text, m.regdate 
FROM MEMBER m LEFT OUTER JOIN dongne1 a ON m.dongne1 = a.ID LEFT OUTER JOIN dongne2 b ON m.dongne2 = b.id LEFT OUTER JOIN grade g ON m.GRADE = g.CODE;

SELECT * FROM DONGNE_VIEW;
SELECT * FROM MEMBER_VIEW;
DELETE FROM MEMBER WHERE id='test';
SELECT count(*) FROM MEMBER WHERE id = 'test' AND pwd = 1234;

SELECT count(*) FROM MEMBER WHERE id = 'admin';
SELECT count(*) FROM MEMBER WHERE EMAIL = 'admin@admin.co.kr';
SELECT count(*) FROM MEMBER WHERE phone = '010-5615-6004';

INSERT INTO MEMBER(id, pwd, name, NICKNAME, EMAIL, PHONE, DONGNE1, DONGNE2, PROFILE_PIC, PROFILE_TEXT) VALUES('test', '1234', 'test', 'test', 'test@admin.co.kr', '010-5656-1234',1, 1, NULL, NULL);

SELECT * FROM member_view;
