SELECT * FROM JOONGO_CHAT jc;
SELECT a.*, rownum FROM (SELECT jcm.* FROM JOONGO_CHAT_MSG jcm ORDER BY regdate DESC) a WHERE rownum = 1;

-- joongo_chat: id, sale_id, sale_mem_id, buy_mem_id, regdate, latest_date
-- joongo_chat_msg: id, chat_id, mem_id, content, regdate, read_yn, image

-- select join
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

SELECT * FROM CHAT_LIST_VIEW clv ORDER BY regdate desc;

INSERT INTO MEMBER(id, pwd, name, nickname, email, phone, grade, dongne1, dongne2, PROFILE_PIC, PROFILE_TEXT, regdate, BIRTHDAY)
VALUES('chattest1', '1234', '채팅요정', '유정', 'chat01@test.co.kr', '010-1234-4321', 'W', 3,  44, NULL, NULL, sysdate, TO_DATE('1994-01-12', 'yyyy-mm-dd'));
INSERT INTO MEMBER(id, pwd, name, nickname, email, phone, grade, dongne1, dongne2, PROFILE_PIC, PROFILE_TEXT, regdate, BIRTHDAY)
VALUES('chattest2', '1234', '채팅유저', '채유전', 'chat02@test.co.kr', '010-1234-4999', 'W', 3,  44, NULL, NULL, sysdate, TO_DATE('1994-08-12', 'yyyy-mm-dd'));

INSERT INTO JOONGO_SALE(id, mem_id, dog_cate, cat_cate, title, content, price, DONGNE1_ID, DONGNE2_ID, BUY_MEM_id, SALE_STATE, regdate, redate, hits)
VALUES(1/*sale_seq.nextval*/, 'chattest1', 'n', 'y', '고양이 그려드립니다ㅋ', '허접한 그림입니다', 100, 3, 44, NULL, 1, sysdate, sysdate, 0);


-- sale: id, mem_id, dog_cate, cat_cate, title, content, price, dongne1_id, dongne2_id, buy_mem_id, sale_state, regdate, regdate, hits;
SELECT * FROM joongo_sale;

SELECT *
FROM all_constraints
WHERE table_name = 'JOONGO_CHAT_MSG';

INSERT INTO JOONGO_CHAT(id, sale_id, SALE_MEM_ID, BUY_MEM_ID, regdate, LATEST_DATE )
values(chat_seq.nextval, 1, 'chattest1', 'chattest2', sysdate, sysdate);

INSERT INTO JOONGO_CHAT_MSG VALUES(chat_msg_seq.nextval, 1, 'chattest2', '안녕하세요ㅎㅎㅎ', sysdate, 'n', null);
INSERT INTO JOONGO_CHAT_MSG VALUES(chat_msg_seq.nextval, 1, 'chattest2', '그림 그려주세요ㅋ', sysdate + 1/60/24*1 , 'n', null);
INSERT INTO JOONGO_CHAT_MSG VALUES(chat_msg_seq.nextval, 1, 'chattest2', '그림 그려주세요ㅋㅋ', sysdate  + 1/60/24*2, 'n', null);
INSERT INTO JOONGO_CHAT_MSG VALUES(chat_msg_seq.nextval, 1, 'chattest2', '그림 그려주세요ㅋㅋㅋ', sysdate  + 1/60/24*3, 'n', null);
INSERT INTO JOONGO_CHAT_MSG VALUES(chat_msg_seq.nextval, 1, 'chattest1', '즐ㅋ', sysdate + 1/60/24*4 , 'n', null);
INSERT INTO JOONGO_CHAT_MSG VALUES(chat_msg_seq.nextval, 1, 'chattest2', ';;;', sysdate + 1/60/24*5, 'n', null);

SELECT * FROM CHAT_LIST_VIEW;
SELECT * FROM joongo_sale;
SELECT * FROM JOONGO_CHAT jc;
SELECT * FROM JOONGO_CHAT_MSG jcm;

SELECT * FROM chat_list_view
where (sale_mem_id = 'chattest1' or buy_mem_id = 'chattest1') AND sale_id = '1'
ORDER BY latest_date DESC;


SELECT * FROM JOONGO_CHAT_MSG jcm;
SELECT * FROM "MEMBER" m2 ;
SELECT * FROM DONGNE2 d2 ;

SELECT
	d1.id AS dongne1_id,
	d1.name AS dongne1_name,
	d2.id AS dongne2_id,
	d2.name AS dongne2_name
FROM dongne1 d1
	LEFT OUTER JOIN dongne2 d2 ON (d1.ID = d2.dongne1_id)
WHERE d2.name = '달서구';


SELECT id, LEVEL, LPAD(' ', 3*(LEVEL - 1)) || MEM_ID AS CONNECTBY, SALE_ID, ORIGIN_ID, TAG_MEM_ID, CONTENT, REGDATE 
  FROM JOONGO_COMMENT jc 
  WHERE SALE_ID = 1
 START WITH origin_id IS NULL
 CONNECT BY PRIOR id = ORIGIN_ID;


INSERT INTO JOONGO_COMMENT(id, sale_id, mem_id, ORIGIN_ID, tag_mem_id, content, regdate)
values(1, 1, 'chattest1', NULL, NULL, '1-첫번째 댓글 (1)', sysdate);
INSERT INTO JOONGO_COMMENT(id, sale_id, mem_id, ORIGIN_ID, tag_mem_id, content, regdate)
values(2, 1, 'chattest2', NULL, NULL, '1-두번째 댓글 (2)', sysdate + 1/60/24 * 5);
INSERT INTO JOONGO_COMMENT(id, sale_id, mem_id, ORIGIN_ID, tag_mem_id, content, regdate)
values(3, 1, 'chattest1', 2, null, '1-두번째 댓글의 첫번째 자식 (3)', sysdate + 1/60/24 * 6);
INSERT INTO JOONGO_COMMENT(id, sale_id, mem_id, ORIGIN_ID, tag_mem_id, content, regdate)
values(4, 2, 'chattest2', null, null, '2-첫번째 댓글(4)', sysdate + 1/60/24 * 7);
INSERT INTO JOONGO_COMMENT(id, sale_id, mem_id, ORIGIN_ID, tag_mem_id, content, regdate)
values(5, 2, 'chattest1', 4, NULL, '2-첫번째 댓글의 첫번째자식 (5)', sysdate + 1/60/24 * 8);
INSERT INTO JOONGO_COMMENT(id, sale_id, mem_id, ORIGIN_ID, tag_mem_id, content, regdate)
values(6, 1, 'chattest2', 2, 'chattest1', '1-두번째 댓글의 두번째자식 (6)', sysdate + 1/60/24 * 9);
INSERT INTO JOONGO_COMMENT(id, sale_id, mem_id, ORIGIN_ID, tag_mem_id, content, regdate)
values(7, 1, 'chattest2', 1, NULL, '1-첫번째 댓글의 첫번째자식 (7)', sysdate + 1/60/24 * 10);
INSERT INTO JOONGO_COMMENT(id, sale_id, mem_id, ORIGIN_ID, tag_mem_id, content, regdate)
values(8, 1, 'chattest1', 1, 'chattest2', '1-첫번째 댓글의 두번째자식 (8)', sysdate + 1/60/24 * 11);

SELECT rn, c.id, chat_id, mem_id, nickname AS mem_nickname, content, c.regdate, read_yn, image
FROM
(
	SELECT *
	FROM
	(
		SELECT rownum AS rn, a.*
		FROM
		(
			SELECT *
			FROM JOONGO_CHAT_MSG jcm
			ORDER BY id desc
		) a
	) ORDER BY id
) c LEFT OUTER JOIN MEMBER m ON (c.mem_id = m.id)
WHERE rn >= 1 and rn <= 10
ORDER BY rn desc;

SELECT a.*
FROM 
	(
		SELECT
			rownum AS rn,
			m.id, pwd, m.name, nickname, email, phone,
			m.DONGNE1 AS dongne1_id,
			d1.name AS dongne1_name,
			m.dongne2 AS dongne2_id,
			d2.name AS dongne2_name,
			grade, profile_pic, profile_text, regdate, birthday,
			zipcode, address1, address2, mileage, use_yn
		FROM MEMBER m
			LEFT OUTER JOIN dongne1 d1 ON (m.dongne1 = d1.id)
			LEFT OUTER JOIN dongne2 d2 ON (m.dongne2 = d2.ID)
		WHERE
			m.name LIKE '%유%'
		ORDER BY regdate
	) a
WHERE rn BETWEEN 1 AND 10;

SELECT * FROM JOONGO_IMAGE ji ;

ALTER TABLE joongo_image
ADD thum_name varchar2(255);

SELECT a.*
	FROM (SELECT rownum AS rnum, b.*
  		FROM (
  			SELECT
  				DISTINCT js.ID,
  				MEM_ID,
  				DOG_CATE,
  				CAT_CATE,
  				TITLE,
  				CONTENT,
  				PRICE,
  				d1.ID AS DONGNE1ID,
  				d1.NAME AS DONGNE1NAME,
  				d2.ID AS DONGNE2ID,
  				d2.NAME AS DONGNE2NAME,
  				BUY_MEM_ID,
  				SALE_STATE,
  				REGDATE,
  				REDATE,
  				HITS,
  				CHAT_COUNT,
  				HEART_COUNT,
  				thum_name
			FROM JOONGO_SALE js
				LEFT JOIN DONGNE1 d1 ON js.DONGNE1_ID = d1.ID
				LEFT JOIN DONGNE2 d2 ON js.DONGNE2_ID = d2.ID
				LEFT JOIN JOONGO_IMAGE ji ON ji.SALE_ID = js.ID
				ORDER BY js.id DESC)
			b) a
	WHERE a.rnum BETWEEN 1 AND 20
	ORDER BY a.rnum;

SELECT * FROM JOONGO_sale;
SELECT * FROM JOONGO_IMAGE ji;

SELECT * FROM MALL_DELIVERY md ;

SELECT * FROM MALL_ORDER ;
SELECT * FROM MALL_ORDER_DETAIL mod2 ;

SELECT
	CASE
		WHEN trunc(mc.regdate) + 7 <= trunc(sysdate) THEN '7일 지남'
		ELSE to_char(regdate, 'MM-DD')
	END regdate
FROM MALL_CART mc ;


DELETE FROM MALL_PAYMENT mp ;
DELETE FROM MALL_ORDER_DETAIL mod2 ;
DELETE FROM mall_order;
DELETE FROM MALL_MILEAGE mm ;

