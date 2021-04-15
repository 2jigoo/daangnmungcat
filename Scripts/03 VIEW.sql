
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
AS
SELECT
	s.id AS id,
	sm.id AS MEM_ID,
	sm.nickname AS MEM_NICKNAME,
	dv.D1NAME as dongne1_name,
	dv.D2NAME as dongne2_name,
	sm.grade AS mem_grade,
	sm.profile_pic AS mem_profile_pic, 
	DOG_CATE, CAT_CATE, TITLE, CONTENT, PRICE, s.REGDATE AS regdate, SALE_STATE,
	BUY_MEM_ID,
	bm.nickname AS BUY_MEM_NICkNAME,
	HITS, HEART_COUNT, THUM_NAME 
	FROM JOONGO_SALE s 
	JOIN DONGNE_VIEW dv on s.DONGNE2_ID = dv.D2ID
	LEFT JOIN (SELECT * FROM JOONGO_IMAGE WHERE THUM_NAME IS NOT NULL) ji ON s.ID = ji.SALE_ID
	LEFT OUTER JOIN MEMBER sm ON s.MEM_ID = sm.id
	LEFT OUTER JOIN MEMBER bm ON s.BUY_MEM_ID = bm.id;
	

CREATE OR REPLACE VIEW CHAT_LIST_VIEW 
AS
SELECT
	C.id			AS id,
	C.sale_id		AS sale_id,
	S.MEM_ID 		AS sale_mem_id,
	S.BUY_MEM_ID 	AS sale_buy_mem_id,
	SM.nickname		AS sale_mem_nickname,
	SM.grade		AS sale_mem_grade,
	S.title			AS sale_title,
	S.dongne2_id	AS sale_dongne2_id,
	S.sale_state	AS sale_sale_state,
	C.buy_mem_id	AS buy_mem_id,
	BM.nickname		AS buy_mem_nickname,
	C.regdate		AS regdate,
	C.latest_date	AS latest_date,
	ji.thum_name	AS sale_thum_name
FROM JOONGO_CHAT C
	LEFT OUTER JOIN JOONGO_SALE S ON (C.SALE_ID = S.ID)
	LEFT OUTER JOIN MEMBER SM ON (S.MEM_ID = SM.id)
	LEFT OUTER JOIN MEMBER BM ON (C.BUY_MEM_ID = BM.id)
	LEFT OUTER JOIN (SELECT sale_id, thum_name FROM JOONGO_IMAGE WHERE THUM_NAME IS NOT null) ji ON s.id = ji.SALE_ID;


CREATE OR REPLACE VIEW mall_pdt_view AS
SELECT p.ID, d.NAME, c.NAME AS cat_cate_name, p.NAME AS pname, p.PRICE, p.CONTENT, p.SALE_YN, p.STOCK, p.IMAGE1, p.IMAGE2, p.IMAGE3, p.DELIVERY_KIND, p.DELIVERY_CONDITION, p.DELIVERY_PRICE, p.REGDATE 
FROM MALL_PDT p LEFT OUTER JOIN mall_dog_cate d ON d.ID = p.DOG_CATE LEFT OUTER JOIN MALL_CAT_CATE c ON c.ID = p.CAT_CATE;


CREATE OR REPLACE VIEW sale_review_view AS
SELECT
	r.ID,
	r.SALE_ID,
	s.MEM_ID AS SALE_MEM_ID,
	s.TITLE AS SALE_TITLE,
	sm.NICKNAME AS SALE_MEM_NICKNAME,
	s.BUY_MEM_ID AS BUY_MEM_ID,
	bm.NICKNAME AS BUY_MEM_NICKNAME,
	r.WRITER AS WRITER_ID,
	wm.NICKNAME AS WRITER_NICKNAME,
	wm.PROFILE_PIC AS WRITER_PROFILE_PIC,
	wm.DONGNE1 AS WRITER_DONGNE1_NAME,
	wm.DONGNE2 AS WRITER_DONGNE2_NAME,
	r.RATING,
	r.CONTENT,
	r.REGDATE
 FROM JOONGO_REVIEW r
  	LEFT OUTER JOIN JOONGO_SALE s ON r.SALE_ID = s.ID
 	LEFT OUTER JOIN MEMBER_VIEW sm ON s.MEM_ID = sm.ID
 	LEFT OUTER JOIN MEMBER_VIEW bm ON s.BUY_MEM_ID = bm.ID
 	LEFT OUTER JOIN MEMBER_VIEW wm ON r.WRITER = wm.ID;
