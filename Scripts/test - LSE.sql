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
-----시작!

--상세보기 쿼리
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
SELECT * FROM DONGNE2;
SELECT * FROM dongne_view;

INSERT INTO JOONGO_SALE (ID, MEM_ID, DOG_CATE , CAT_CATE , TITLE , CONTENT , PRICE, DONGNE1_ID , DONGNE2_ID , SALE_STATE, REGDATE, HITS, CHAT_COUNT ,HEART_COUNT)
values(sale_seq.nextval, 'chattest2', 'y', 'n', '제목입니다.' , '내용입니다.',  100 , 2, 27 ,'1',sysdate,0,0,0)










