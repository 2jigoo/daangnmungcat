
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

SELECT thum_name FROM JOONGO_IMAGE ji WHERE ji.THUM_NAME IS NOT null