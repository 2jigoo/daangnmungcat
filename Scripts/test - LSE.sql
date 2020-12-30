

INSERT INTO DONGNE1 VALUES (1, '세종시');
INSERT INTO DONGNE2 VALUES (01, 1 ,'세종동');

CREATE SEQUENCE joongo_sale_seq
START with  1001
INCREMENT by 1;



SELECT ID,MEM_ID,DOG_CATE,CAT_CATE,TITLE,CONTENT,PRICE,DONGNE1_ID,DONGNE2_ID,BUY_MEM_ID,SALE_STATE,REGDATE,REDATE,HITS,CHAT_COUNT,HEART_COUNT FROM JOONGO_SALE;

INSERT INTO joongo_sale (Id, MEM_ID, DOG_CATE, CAT_CATE, TITLE, CONTENT, PRICE, DONGNE1_ID,DONGNE2_ID,sale_state,regdate, HITS) 
VALUES (joongo_sale_seq.nextval, 'test', '0', '1', '사과 맛있어요', '저희 할머니께서 직접 농사지으셔서 ', 5000, 1, 01, 0, sysdate,0);




SELECT a.id, a.name, b.ID ,b.name FROM dongne1 a LEFT OUTER JOIN DONGNE2 b ON a.ID = b.DONGNE1_ID ORDER BY a.id, b.id;

CREATE OR REPLACE VIEW dongne_view AS
SELECT a.id AS d1id , a.name AS d1name, b.name AS d2name, b.id AS d2id FROM dongne1 a 
LEFT OUTER JOIN DONGNE2 b ON a.ID = b.DONGNE1_ID ORDER BY a.id, b.id;

---------------------------
SELECT * FROM JOONGO_SALE;
select * FROM member;
SELECT * FROM DONGNE1;
SELECT * FROM DONGNE2;
SELECT * FROM dongne_view;




SELECT s.id AS id, m.id AS MEM_ID, PROFILE_PIC, dv.D1NAME as dongne1_name, dv.D2NAME as dongne2_name, grade, profile_pic, 
	DOG_CATE, CAT_CATE, TITLE, CONTENT,PRICE, s.REGDATE AS regdate, 
	REDATE, SALE_STATE, BUY_MEM_ID, HITS , CHAT_COUNT , HEART_COUNT 
	FROM JOONGO_SALE s 
	JOIN DONGNE_VIEW dv on s.DONGNE2_ID = dv.D2ID
	JOIN MEMBER m ON s.MEM_ID = m.id
WHERE s.id = 2;

CREATE VIEW sale_view AS SELECT s.id AS id, m.id AS MEM_ID, dv.D1NAME as dongne1_name, dv.D2NAME as dongne2_name, grade, profile_pic, 
	DOG_CATE, CAT_CATE, TITLE, CONTENT,PRICE, s.REGDATE AS regdate, 
	REDATE, SALE_STATE, BUY_MEM_ID, HITS , CHAT_COUNT , HEART_COUNT 
	FROM JOONGO_SALE s 
	JOIN DONGNE_VIEW dv on s.DONGNE2_ID = dv.D2ID
	JOIN MEMBER m ON s.MEM_ID = m.id;

SELECT * FROM sale_view WHERE id =2;
DROP VIEW SALE_VIEW;

SELECT s.id as id, m.id AS MEM_ID, DONGNE1_ID , DONGNE2_ID , grade, profile_pic, 
	DOG_CATE, CAT_CATE, TITLE, CONTENT,PRICE, s.REGDATE AS regdate, 
	REDATE, SALE_STATE, BUY_MEM_ID, HITS , CHAT_COUNT , HEART_COUNT 
	FROM JOONGO_SALE s 
	JOIN MEMBER m ON s.MEM_ID = m.id;
	
SELECT * FROM JOONGO_SALE;
SELECT * FROM MEMBER;
SELECT * FROM DONGNE_VIEW dv 

insert into JOONGO_SALE(ID,MEM_ID,DOG_CATE,cat_cate,title, content, price, DONGNE1_ID,DONGNE2_ID,REGDATE,SALE_STATE, hits )
values(sale_seq.nextval,'chattest2','y','n','제목','내용',5000,2,27,sysdate, 1, 0);
insert into JOONGO_SALE(ID,MEM_ID,DOG_CATE,cat_cate,title, content, price, DONGNE1_ID,DONGNE2_ID,REGDATE,SALE_STATE, hits )
values(sale_seq.nextval,'chattest1','y','n','제목1','내용2',5000,2,27,sysdate, 1, 0);
insert into JOONGO_SALE(ID,MEM_ID,DOG_CATE,cat_cate,title, content, price, DONGNE1_ID,DONGNE2_ID,REGDATE,SALE_STATE, hits )
values(sale_seq.nextval,'chattest1','y','n','제목2','내용3',5000,2,27,sysdate, 1, 0);

SELECT * FROM joongo_Sale WHERE MEM_ID = 'chattest2';

SELECT id, title, PRICE , dv.D1NAME AS DONGNE1_ID , dv.D2NAME AS DONGNE2_ID , HEART_COUNT , CHAT_COUNT FROM JOONGO_SALE s JOIN DONGNE_VIEW dv  ON  DV.D2ID  = s.DONGNE2_ID
where MEM_ID = 'a'; 

SELECT * FROM SALE_VIEW ;
SELECT * FROM MEMBER;


SELECT id, title, PRICE , DONGNE1_NAME , DONGNE2_NAME, HEART_COUNT , CHAT_COUNT FROM SALE_VIEW 
WHERE MEM_ID = 'chattest1' AND NOT  id = 26;

