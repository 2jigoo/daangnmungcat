SELECT * FROM MEMBER;
INSERT INTO MEMBER(ID,PWD,NAME,NICKNAME,EMAIL,PHONE ,DONGNE1,DONGNE2, BIRTHDAY,ZIPCODE,ADDRESS1,ADDRESS2) 
VALUES('test', '1234', '관리자', '관리자', 'admin@admin.co.kr', '010-1234-1234',1, 1, '1991-12-19', NULL, NULL, NULL);

SELECT * FROM dongne_view;
SELECT * FROM member_view;

CREATE OR REPLACE VIEW member_view AS
SELECT m.id, m.pwd, m.name, m.nickname, m.email, m.phone, a.name AS dongne1 , b.name AS dongne2 , m.grade, g.NAME AS grade_name, m.profile_pic, m.profile_text, m.regdate 
FROM MEMBER m LEFT OUTER JOIN dongne1 a ON m.dongne1 = a.ID LEFT OUTER JOIN dongne2 b ON m.dongne2 = b.id LEFT OUTER JOIN grade g ON m.GRADE = g.CODE;

SELECT * FROM DONGNE_VIEW;
SELECT * FROM MEMBER;
DELETE FROM MEMBER WHERE id='test';
SELECT count(*) FROM MEMBER WHERE id = 'test' AND pwd = 1234;

SELECT count(*) FROM MEMBER WHERE id = 'admin';
SELECT count(*) FROM MEMBER WHERE EMAIL = 'admin@admin.co.kr';
SELECT count(*) FROM MEMBER WHERE phone = '010-5615-6004';

INSERT INTO MEMBER(id, pwd, name, NICKNAME, EMAIL, PHONE, DONGNE1, DONGNE2, PROFILE_PIC, PROFILE_TEXT) VALUES('test', '1234', 'test', 'test', 'test@admin.co.kr', '010-5656-1234',1, 1, NULL, NULL);

SELECT * FROM member;
SELECT * FROM MALL_PDT;
SELECT * FROM MALL_CAT_CATE;

UPDATE MEMBER SET ZIPCODE = 45414, ADDRESS1 = '경기 성남시 분당구 대왕판교로606번길 45', ADDRESS2 = 'ㄴㅇㄹㄴㅇㄹㄴㄹㄴㄹㄴㅇㄹㄴㅇ' where id = 'test';


UPDATE MEMBER SET ZIPCODE = #{}, ADDRESS1 = #{}, ADDRESS2 = #{} WHERE id = #{}	
INSERT INTO MALL_PDT VALUES(mall_pdt_seq.nextval, 1, NULL, '네츄럴코어', 13000, '네츄럴코어 사료입니다.', 'y', 100, NULL, NULL, NULL, 1, 50000, 3000, sysdate);
SELECT * FROM ORDER_address;
DELETE FROM order_Address;
INSERT INTO order_address VALUES(ORDER_ADDRESS_seq.nextval, 'test', '집','김혜진','010-5615-6004',  44541, '대구시평리동', '2층',NULL);
INSERT INTO order_address VALUES(ORDER_ADDRESS_seq.nextval, 'test', '집2', '김혜진','010-5615-6004', 44541, '대구시평리동', '2층',NULL);
INSERT INTO order_address(ORDER_ADDRESS_seq.nextval, MEM_ID, SUBJECT, NAME, PHONE, ZIPCODE, ADDRESS1, ADDRESS2, MEMO) VALUES ('test', '집2', '김혜진','010-5615-6004', 44541, '대구시평리동', '2층',NULL);
SELECT ID, MEM_ID, SUBJECT, NAME, PHONE, ZIPCODE, ADDRESS1, ADDRESS2, MEMO FROM ORDER_address WHERE mem_id = 'test';