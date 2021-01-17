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

SELECT * FROM CHAT_LIST_VIEW clv ;

INSERT INTO MEMBER VALUES('chattest1', '1234', '채팅요정', 'chatUser01', 'chat01@test.co.kr', '010-1234-4321', 3,  44, 1, NULL, NULL, sysdate);
INSERT INTO MEMBER VALUES('chattest2', '1234', '채팅유저', 'chatUser02', 'chat02@test.co.kr', '010-1234-4999', 3,  44, 1, NULL, NULL, sysdate);

INSERT INTO JOONGO_SALE(id, mem_id, dog_cate, cat_cate, title, content, price, DONGNE1_ID, DONGNE2_ID, BUY_MEM_id, SALE_STATE, regdate, redate, hits)
VALUES(sale_seq.nextval, 'chattest1', 'n', 'y', '고양이 그려드립니다ㅋ', '허접한 그림입니다', 100, 3, 44, NULL, 1, sysdate, sysdate, 0);


-- sale: id, mem_id, dog_cate, cat_cate, title, content, price, dongne1_id, dongne2_id, buy_mem_id, sale_state, regdate, regdate, hits;
SELECT * FROM joongo_sale;


SELECT *
FROM all_constraints
WHERE table_name = 'JOONGO_CHAT_MSG';

INSERT INTO JOONGO_CHAT(id, sale_id, SALE_MEM_ID, BUY_MEM_ID, regdate, LATEST_DATE )
values(chat_seq.nextval, 2, 'chattest1', 'chattest2', sysdate, sysdate);

INSERT INTO JOONGO_CHAT_MSG VALUES(chat_msg_seq.nextval, 1, 'chattest2', '안녕하세요ㅎㅎㅎ', sysdate, 'n', null);
INSERT INTO JOONGO_CHAT_MSG VALUES(chat_msg_seq.nextval, 1, 'chattest2', '그림 그려주세요ㅋ', sysdate + 1/60/24*1 , 'n', null);
INSERT INTO JOONGO_CHAT_MSG VALUES(chat_msg_seq.nextval, 1, 'chattest2', '그림 그려주세요ㅋㅋ', sysdate  + 1/60/24*2, 'n', null);
INSERT INTO JOONGO_CHAT_MSG VALUES(chat_msg_seq.nextval, 1, 'chattest2', '그림 그려주세요ㅋㅋㅋ', sysdate  + 1/60/24*3, 'n', null);
INSERT INTO JOONGO_CHAT_MSG VALUES(chat_msg_seq.nextval, 1, 'chattest1', '즐ㅋ', sysdate + 1/60/24*4 , 'n', null);
INSERT INTO JOONGO_CHAT_MSG VALUES(chat_msg_seq.nextval, 1, 'chattest2', ';;;', sysdate + 1/60/24*5, 'n', null);


SELECT * FROM CHAT_LIST_VIEW;
SELECT * FROM joongo_sale;
SELECT * FROM JOONGO_CHAT_MSG jcm;

SELECT * FROM chat_list_view
where sale_mem_id = 'chattest1' or buy_mem_id = 'chattest1'
ORDER BY latest_date DESC;


SELECT * FROM JOONGO_CHAT_MSG jcm;

SELECT * FROM DONGNE2 d2 ;

SELECT
	d1.id AS dongne1_id,
	d1.name AS dongne1_name,
	d2.id AS dongne2_id,
	d2.name AS dongne2_name
FROM dongne1 d1
	LEFT OUTER JOIN dongne2 d2 ON (d1.ID = d2.dongne1_id)
WHERE d2.name = '달서구';


SELECT * FROM JOONGO_COMMENT jc ;
DELETE FROM joongo_comment;


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
