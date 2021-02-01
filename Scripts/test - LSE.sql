-----시작!

DROP VIEW SALE_VIEW;

SELECT * FROM JOONGO_SALE;

CREATE VIEW sale_view AS SELECT s.id AS id, m.id AS MEM_ID, dv.D1NAME as dongne1_name, dv.D2NAME as dongne2_name, grade, profile_pic, 
	DOG_CATE, CAT_CATE, TITLE, CONTENT,PRICE, s.REGDATE AS regdate, 
	REDATE, SALE_STATE, BUY_MEM_ID, HITS , CHAT_COUNT , HEART_COUNT
	FROM JOONGO_SALE s 
	JOIN DONGNE_VIEW dv on s.DONGNE2_ID = dv.D2ID
	JOIN MEMBER m ON s.MEM_ID = m.id;

--상세보기 쿼리
SELECT s.id AS id, m.id AS MEM_ID, PROFILE_PIC, dv.D1NAME as dongne1_name, dv.D2NAME as dongne2_name, grade, profile_pic, 
	DOG_CATE, CAT_CATE, TITLE, CONTENT,PRICE, s.REGDATE AS regdate, 
	REDATE, SALE_STATE, BUY_MEM_ID, HITS , CHAT_COUNT , HEART_COUNT 
	FROM JOONGO_SALE s 
	JOIN DONGNE_VIEW dv on s.DONGNE2_ID = dv.D2ID
	JOIN MEMBER m ON s.MEM_ID = m.id
WHERE s.id = 2;

SELECT s.id as id, m.id AS MEM_ID, DONGNE1_ID , DONGNE2_ID , grade, profile_pic, 
	DOG_CㄴATE, CAT_CATE, TITLE, CONTENT,PRICE, s.REGDATE AS regdate, 
	REDATE, SALE_STATE, BUY_MEM_ID, HITS , CHAT_COUNT , HEART_COUNT 
	FROM JOONGO_SALE s 
	JOIN MEMBER m ON s.MEM_ID = m.id;

--지수가 작성한 가짜 데이터 샘플
insert into JOONGO_SALE(ID,MEM_ID,DOG_CATE,cat_cate,title, content, price, DONGNE1_ID,DONGNE2_ID,REGDATE,SALE_STATE, hits )
values(sale_seq.nextval,'chattest2','y','n','제목','내용',5000,2,27,sysdate, 1, 0);
insert into JOONGO_SALE(ID,MEM_ID,DOG_CATE,cat_cate,title, content, price, DONGNE1_ID,DONGNE2_ID,REGDATE,SALE_STATE, hits )
values(sale_seq.nextval,'chattest1','y','n','제목1','내용2',5000,2,27,sysdate, 1, 0);
insert into JOONGO_SALE(ID,MEM_ID,DOG_CATE,cat_cate,title, content, price, DONGNE1_ID,DONGNE2_ID,REGDATE,SALE_STATE, hits )
values(sale_seq.nextval,'chattest1','y','n','제목2','내용3',5000,2,27,sysdate, 1, 0);

SELECT * FROM joongo_Sale WHERE MEM_ID = 'chattest2';

SELECT id, title, PRICE , dv.D1NAME AS DONGNE1_ID , dv.D2NAME AS DONGNE2_ID , HEART_COUNT , CHAT_COUNT FROM JOONGO_SALE s JOIN DONGNE_VIEW dv  ON  DV.D2ID  = s.DONGNE2_ID
where MEM_ID = 'a'; 

SELECT id, title, PRICE , DONGNE1_NAME , DONGNE2_NAME, HEART_COUNT , CHAT_COUNT FROM SALE_VIEW 
WHERE MEM_ID = 'chattest1' AND NOT  id = 26;

--조회수
UPDATE JOONGO_SALE SET HITS = hits + 1 WHERE id = 2;


INSERT INTO JOONGO_SALE (id, DOG_CATE , CAT_CATE , TITLE , CONTENT , PRICE, DONGNE1_ID , DONGNE2_ID , SALE_STATE, REGDATE, HITS, CHAT_COUNT ,HEART_COUNT)
values(sale_seq.nextval, ?,?,?,?,?,?,?,?,?,sysdate,0,0,0);

---------------------------
SELECT * FROM JOONGO_SALE;
select * FROM member;
SELECT * FROM DONGNE1;
SELECT * FROM MALL_PDT;
SELECT * FROM SALE_VIEW ;
SELECT * FROM dongne_view;
SELECT * FROM JOONGO_IMAGE;


select * from user_sequences;


INSERT INTO JOONGO_SALE (ID, MEM_ID, DOG_CATE , CAT_CATE , TITLE , CONTENT , PRICE, DONGNE1_ID , DONGNE2_ID , SALE_STATE, REGDATE, HITS, CHAT_COUNT ,HEART_COUNT)
values(sale_seq.nextval, 'chattest1', 'y', 'n', '제목입니다.' , '내용입니다.',  100 , 3, 44 ,'1',sysdate,0,0,0);




SELECT  d1.id AS DONGNE1ID, d1.NAME AS DONGNE1NAME, d2.ID AS DONGNE2ID, d2.NAME AS DONGNE2NAME
FROM DONGNE1 d1 JOIN DONGNE2 d2  ON d1.id = d2.DONGNE1_ID WHERE d1.NAME = '서울특별시';


SELECT js.ID, MEM_ID, DOG_CATE, CAT_CATE, TITLE, CONTENT, PRICE, d1.ID AS DONGNE1ID, d1.NAME AS DONGNE1NAME, d2.ID AS DONGNE2ID, d2.NAME AS DONGNE2NAME, BUY_MEM_ID, SALE_STATE, REGDATE, REDATE, HITS, CHAT_COUNT, HEART_COUNT 
  FROM JOONGO_SALE js LEFT JOIN DONGNE1 d1 ON js.DONGNE1_ID = d1.ID LEFT JOIN DONGNE2 d2 ON js.DONGNE2_ID = d2.ID ORDER BY js.id desc

  	SELECT  d1.id AS DONGNE1ID, d1.NAME AS DONGNE1NAME, d2.ID AS DONGNE2ID, d2.NAME AS DONGNE2NAME
	FROM DONGNE1 d1 JOIN DONGNE2 d2 ON d1.id = d2.DONGNE1_ID WHERE d1.name = '서울특별시' AND d2.NAME = '성동구'; 
  
  
  	SELECT  d1.id AS DONGNE1ID, d1.NAME AS DONGNE1NAME, d2.ID AS DONGNE2ID, d2.NAME AS DONGNE2NAME
	FROM DONGNE1 d1 JOIN DONGNE2 d2  ON d1.id = d2.DONGNE1_ID WHERE d1.NAME = #{dongne1} AND d2.NAME = #{dongne2}
  
  SELECT * FROM JOONGO_SALE;
 	UPDATE JOONGO_SALE SET HEART_COUNT = HEART_COUNT +1, is_heart = 'n' WHERE id=#{} AND MEM_ID =#{};
 	UPDATE JOONGO_SALE SET is_heart = 'y', HEART_COUNT=HEART_COUNT+1 WHERE id=1 AND MEM_ID ='chattest1';

 UPDATE JOONGO_SALE  SET is_heart = 'n', heart_count=heart_count -1	WHERE id=1 AND mem_id = 'chattest1';
 

select id, pwd, name, nickname, email, phone, dongne1, dongne2, grade, profile_pic, profile_text, regdate from MEMBER;
----------------찜
SELECT * FROM JOONGO_HEART;
SELECT * FROM JOONGO_SALE ;
SELECT * FROM MEMBER;
SELECT id, mem_id, sale_id, regdate FROM JOONGO_HEART;
SELECT * FROM JOONGO_SALE WHERE MEM_ID = 'chattest1';
SELECT count(*) FROM JOONGO_HEART WHERE sale_id = 2 AND  MEM_ID ='chattest2';
INSERT INTO JOONGO_HEART values(heart_seq.nextval, 'chattest1', 3, sysdate);

 SELECT count(*) FROM JOONGO_HEART where mem_id = 'chattest2' and sale_id=1;



SELECT * FROM SALE_VIEW ORDER BY regdate desc;

----- 
SELECT rownum, id, MEM_ID, DONGNE1_NAME ,DONGNE2_NAME , grade, PROFILE_PIC , DOG_CATE ,CAT_CATE ,TITLE ,CONTENT ,PRICE ,REGDATE ,REDATE , 
SALE_STATE ,BUY_MEM_ID ,HITS , CHAT_COUNT,HEART_COUNT 
FROM (SELECT * from SALE_VIEW ORDER BY regdate DESC )WHERE ROWNUM < 9 AND MEM_ID = 'chattest1';

SELECT max(ID) FROM JOONGO_SALE ;
SELECT MAX(id)+1 FROM JOONGO_SALE; 

SELECT * FROM JOONGO_IMAGE ;
SELECT * FROM JOONGO_SALE WHERE id = 1;

INSERT INTO JOONGO_IMAGE (id, SALE_ID, IMAGE_NAME )values(sale_img_seq.nextval, 1, '1');

select sale_seq.nextval from dual;
SELECT * FROM JOONGO_SALE;



SELECT a.*
  FROM (SELECT rownum AS rnum, b.*
  		FROM (SELECT DISTINCT js.ID, MEM_ID, DOG_CATE, CAT_CATE, TITLE, CONTENT, PRICE, d1.ID AS DONGNE1ID, d1.NAME AS DONGNE1NAME, d2.ID AS DONGNE2ID, d2.NAME AS DONGNE2NAME, BUY_MEM_ID, SALE_STATE, REGDATE, REDATE, HITS, CHAT_COUNT, HEART_COUNT, thum_name
FROM JOONGO_SALE js LEFT JOIN DONGNE1 d1 ON js.DONGNE1_ID = d1.ID LEFT JOIN DONGNE2 d2 ON js.DONGNE2_ID = d2.ID INNER JOIN JOONGO_IMAGE ji ON  ji.SALE_ID = js.ID ORDER BY js.id DESC) b) a
 WHERE a.rnum BETWEEN #{rowStart} AND #{rowEnd}
 ORDER BY a.rnum

SELECT * FROM MEMBER;
SELECT * FROM JOONGO_IMAGE ji ;
 	
SELECT  DISTINCT js.ID, MEM_ID, DOG_CATE, CAT_CATE, TITLE, CONTENT, PRICE, d1.ID AS DONGNE1ID, d1.NAME AS DONGNE1NAME, d2.ID AS DONGNE2ID, d2.NAME AS DONGNE2NAME, BUY_MEM_ID, SALE_STATE, REGDATE, REDATE, HITS, CHAT_COUNT, HEART_COUNT, thum_name
FROM JOONGO_SALE js LEFT JOIN DONGNE1 d1 ON js.DONGNE1_ID = d1.ID LEFT JOIN DONGNE2 d2 ON js.DONGNE2_ID = d2.ID LEFT JOIN JOONGO_IMAGE ji ON  ji.SALE_ID = js.ID ORDER BY js.id DESC;
  
 /*SELECT IMAGE_NAME FROM JOONGO_IMAGE ji WHERE  SALE_ID = 44 AND ROWNUM = 1;  */


SELECT DISTINCT s.id AS id, m.id AS MEM_ID, dv.D1NAME as dongne1_name, dv.D2NAME as dongne2_name, grade, profile_pic, 
	DOG_CATE, CAT_CATE, TITLE, CONTENT,PRICE, s.REGDATE AS regdate, 
	REDATE, SALE_STATE, BUY_MEM_ID, HITS , CHAT_COUNT, HEART_COUNT , THUM_NAME 
	FROM JOONGO_SALE s 
	JOIN DONGNE_VIEW dv on s.DONGNE2_ID = dv.D2ID
	LEFT JOIN JOONGO_IMAGE ji ON s.ID = ji.SALE_ID 
	JOIN MEMBER m ON s.MEM_ID = m.id


	

SELECT * FROM SALE_VIEW ;
SELECT * FROM JOONGO_IMAGE ji  ;
SELECT * FROM JOONGO_REVIEW ;

INSERT INTO joongo_review values(#{id},)


--
SELECT sum(mm.mileage) FROM MALL_MILEAGE mm JOIN "MEMBER" m ON m.id = mm.mem_id WHERE mem_id = 'chattest1'; 
SELECT * FROM MEMBER;

UPDATE MEMBER SET MILEAGE = 1000 WHERE id ='chattest1';

SELECT * FROM MEMBER;

SELECT* FROM MEMBER_VIEW;
SELECT * FROM MALL_MILEAGE;



INSERT INTO MALL_MILEAGE (id, mem_id, mileage, content, regdate)values(mall_mileage_seq.nextval, 'chattest1', 1000, '회원가입', sysdate);
INSERT INTO MALL_MILEAGE (id, mem_id, mileage, content, regdate)values(mall_mileage_seq.nextval, 'chattest1', -500, '테스트', sysdate);

SELECT m.id, m.pwd, m.name, m.nickname, m.email, m.phone, m.GRADE, g.NAME AS grade_name, a.name AS dongne1 , b.name AS dongne2, 
m.profile_pic, m.profile_text, m.regdate, m.ZIPCODE, m.ADDRESS1, m.ADDRESS2, m.USE_YN FROM MEMBER m 
LEFT OUTER JOIN dongne1 a ON m.dongne1 = a.ID
LEFT OUTER JOIN dongne2 b ON m.dongne2 = b.id 
LEFT OUTER JOIN grade g ON m.GRADE = g.CODE

SELECT m.id, m.pwd, m.name, m.nickname, m.email, m.phone, m.GRADE, g.NAME AS grade_name, a.name AS dongne1 , b.name AS dongne2, 
m.profile_pic, m.profile_text, m.regdate, m.ZIPCODE, m.ADDRESS1, m.ADDRESS2, m.USE_YN, sum(mm.MILEAGE)AS MILEAGE FROM MEMBER m 
LEFT OUTER JOIN dongne1 a ON m.dongne1 = a.ID
LEFT OUTER JOIN dongne2 b ON m.dongne2 = b.id 
LEFT OUTER JOIN grade g ON m.GRADE = g.CODE
LEFT OUTER JOIN MALL_MILEAGE mm ON mm.mem_id = m.ID;


SELECT * FROM MEMBER;

	SELECT DISTINCT s.id AS id, m.id AS MEM_ID, dv.D1NAME as dongne1_name, dv.D2NAME as dongne2_name, grade, profile_pic, 
	DOG_CATE, CAT_CATE, TITLE, CONTENT,PRICE, s.REGDATE AS regdate, 
	REDATE, SALE_STATE, BUY_MEM_ID, HITS , CHAT_COUNT, HEART_COUNT , THUM_NAME 
	FROM JOONGO_SALE s 
	JOIN DONGNE_VIEW dv on s.DONGNE2_ID = dv.D2ID
	LEFT JOIN (
		SELECT *
		FROM JOONGO_IMAGE
		WHERE THUM_NAME IS NOT null
	) ji ON s.ID = ji.SALE_ID
	JOIN MEMBER m ON s.MEM_ID = m.id;



SELECT * FROM MEMBER;
SELECT * FROM grade;
SELECT * FROM MALL_MILEAGE;

SELECT mv.*, FROM MEMBER_VIEW mv;


SELECT m.id, m.pwd, m.name, m.nickname, m.email, m.phone, m.GRADE, g.NAME AS grade_name, a.name AS dongne1 , b.name AS dongne2, 
m.profile_pic, m.profile_text, m.regdate, m.ZIPCODE, m.ADDRESS1, m.ADDRESS2, m.USE_YN, NVL((SELECT sum(mileage) FROM mall_MILEAGE
GROUP BY mem_id HAVING mem_id = m.id), 0) AS MILEAGE FROM MEMBER m 
LEFT OUTER JOIN dongne1 a ON m.dongne1 = a.ID
LEFT OUTER JOIN dongne2 b ON m.dongne2 = b.id 
LEFT OUTER JOIN grade g ON m.GRADE = g.CODE


	SELECT
		m.id, pwd, m.name, nickname, email, phone, grade,
		DONGNE1 AS dongne1_id,
		d1.name AS dongne1_name,
		dongne2 AS dongne2_id,
		d2.name AS dongne2_name,
		grade, profile_pic, profile_text, regdate, birthday,
		zipcode, address1, address2, use_yn, 
		NVL((SELECT sum(mileage) FROM mall_MILEAGE GROUP BY mem_id HAVING mem_id = m.id), 0) AS MILEAGE
	FROM MEMBER m
		LEFT OUTER JOIN dongne1 d1 ON (m.dongne1 = d1.id)
		LEFT OUTER JOIN dongne2 d2 ON (m.dongne2 = d2.ID);

	
UPDATE MILEAGE SET mileage = 30000 WHERE id = 'chattest1';
INSERT INTO MALL_MILEAGE 
SELECT * FROM MALL_MILEAGE;

SELECT * FROM MEMBER;

SELECT * FROM MALL_ORDER ;

SELECT MILEAGE FROM MEMBER WHERE id= 'chattest';
UPDATE MALL_MILEAGE SET MILEAGE = 2000 WHERE mem_id = 'chattest1';
SELECT sum(mil) FROM MALL_MILEAGE WHERE mem_id = 'chattest';

SELECT ID, OD_ID, MEM_ID, sum(MILEAGE) AS mileage, CONTENT, REGDATE FROM MALL_MILEAGE WHERE mem_id = 'chattest1';