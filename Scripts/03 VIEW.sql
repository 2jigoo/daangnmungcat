
CREATE OR REPLACE VIEW member_view AS
SELECT m.id, m.pwd, m.name, m.nickname, m.email, m.phone, m.GRADE, g.NAME AS grade_name, a.name AS dongne1 , b.name AS dongne2, 
m.profile_pic, m.profile_text, m.regdate, m.ZIPCODE, m.ADDRESS1, m.ADDRESS2, m.USE_YN FROM MEMBER m 
LEFT OUTER JOIN dongne1 a ON m.dongne1 = a.ID
LEFT OUTER JOIN dongne2 b ON m.dongne2 = b.id 
LEFT OUTER JOIN grade g ON m.GRADE = g.CODE;


CREATE OR REPLACE VIEW dongne_view AS
SELECT a.id AS D1ID, a.name AS D1NAME, b.name AS D2NAME , b.id AS D2ID FROM DONGNE1 a 
LEFT OUTER JOIN DONGNE2 b ON a.ID = b.DONGNE1_ID; 

SELECT * FROM JOONGO_IMAGE ji ;

CREATE OR REPLACE VIEW sale_view
AS SELECT DISTINCT s.id AS id, m.id AS MEM_ID, dv.D1NAME as dongne1_name, dv.D2NAME as dongne2_name, grade, profile_pic, 
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


CREATE OR REPLACE VIEW CHAT_LIST_VIEW 
AS
SELECT
	C.id			AS id,
	C.sale_id		AS sale_id,
	S.MEM_ID 		AS sale_mem_id,
	SM.nickname		AS sale_mem_nickname,
	SM.grade		AS sale_mem_grade,
	S.title			AS sale_title,
	S.dongne2_id	AS sale_dongne2_id,
	S.sale_state	AS sale_sale_state,
	C.buy_mem_id	AS buy_mem_id,
	BM.nickname		AS buy_mem_nickname,
	C.regdate		AS regdate,
	C.latest_date	AS latest_date
FROM JOONGO_CHAT C
	LEFT OUTER JOIN JOONGO_SALE S ON (C.SALE_ID = S.ID)
	LEFT OUTER JOIN MEMBER SM ON (S.MEM_ID = SM.id)
	LEFT OUTER JOIN MEMBER BM ON (C.BUY_MEM_ID = BM.id);


CREATE OR REPLACE VIEW mall_pdt_view AS
SELECT p.ID, d.NAME, c.NAME AS cat_cate_name, p.NAME AS pname, p.PRICE, p.CONTENT, p.SALE_YN, p.STOCK, p.IMAGE1, p.IMAGE2, p.IMAGE3, p.DELIVERY_KIND, p.DELIVERY_CONDITION, p.DELIVERY_PRICE, p.REGDATE 
FROM MALL_PDT p LEFT OUTER JOIN mall_dog_cate d ON d.ID = p.DOG_CATE LEFT OUTER JOIN MALL_CAT_CATE c ON c.ID = p.CAT_CATE;


SELECT thum_name FROM JOONGO_IMAGE ji WHERE ji.THUM_NAME IS NOT NULL;

CREATE OR REPLACE VIEW sale_review_view AS
SELECT jr.ID, jr.SALE_ID, js.MEM_ID AS SALE_MEM_ID, jr.BUY_MEM_ID, mv.NICKNAME AS BUY_MEM_NICKNAME, mv.PROFILE_PIC AS BUY_MEM_PROFILE_PIC, mv.DONGNE1 AS BUY_MEM_DONGNE1_NAME, mv.DONGNE2 AS BUY_MEM_DONGNE2_NAME, jr.RATING, jr.CONTENT, jr.REGDATE
 FROM JOONGO_REVIEW jr LEFT OUTER JOIN MEMBER_VIEW mv ON jr.BUY_MEM_ID = mv.ID LEFT OUTER JOIN JOONGO_SALE js ON jr.SALE_ID = js.ID;