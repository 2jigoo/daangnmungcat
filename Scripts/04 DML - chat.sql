-- test용 유저

INSERT INTO MEMBER (id,pwd,NAME,NICKNAME ,EMAIL ,PHONE ,DONGNE1 ,DONGNE2 ,PROFILE_PIC ,PROFILE_TEXT ,REGDATE )VALUES('chattest1', '1234', '채팅요정', '챗1', 'chat01@test.co.kr', '010-1234-4321', 44, 1, NULL, NULL, sysdate);
INSERT INTO MEMBER(id,pwd,NAME,NICKNAME ,EMAIL ,PHONE ,DONGNE1 ,DONGNE2 ,PROFILE_PIC ,PROFILE_TEXT ,REGDATE ) VALUES('chattest2', '1234', '채팅유저', '챗2', 'chat02@test.co.kr', '010-1234-4999', 3,  44,NULL, NULL, sysdate);


SELECT * FROM MEMBER;
-- test용 중고판매글
INSERT INTO JOONGO_SALE(id, mem_id, dog_cate, cat_cate, title, content, price, DONGNE1_ID, DONGNE2_ID, BUY_MEM_id, SALE_STATE, regdate, redate, hits)
VALUES(sale_seq.nextval, 'chattest1', 'n', 'y', '고양이 그려드립니다ㅋ', '허접한 그림입니다', 100, 3, 44, NULL, 1, sysdate, sysdate, 0);

-- joongo_chat: id, sale_id, sale_mem_id, buy_mem_id, regdate, latest_date
-- joongo_chat_msg: id, chat_id, mem_id, content, regdate, read_yn, image

-- sale: id, mem_id, dog_cate, cat_cate, title, content, price, dongne1_id, dongne2_id, buy_mem_id, sale_state, regdate, regdate, hits

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
	
INSERT INTO JOONGO_CHAT(id, sale_id, SALE_MEM_ID, BUY_MEM_ID, regdate, LATEST_DATE )
values(chat_seq.nextval, 1, 'chattest1', 'chattest2', sysdate, sysdate);
 
INSERT INTO JOONGO_CHAT_MSG VALUES(chat_msg_seq.nextval, 1, 'chattest2', '안녕하세요ㅎㅎㅎ', sysdate, 'n', null);
INSERT INTO JOONGO_CHAT_MSG VALUES(chat_msg_seq.nextval, 1, 'chattest2', '그림 그려주세요ㅋ', sysdate + 1/60/24*1 , 'n', null);
INSERT INTO JOONGO_CHAT_MSG VALUES(chat_msg_seq.nextval, 1, 'chattest2', '그림 그려주세요ㅋㅋ', sysdate  + 1/60/24*2, 'n', null);
INSERT INTO JOONGO_CHAT_MSG VALUES(chat_msg_seq.nextval, 1, 'chattest2', '그림 그려주세요ㅋㅋㅋ', sysdate  + 1/60/24*3, 'n', null);
INSERT INTO JOONGO_CHAT_MSG VALUES(chat_msg_seq.nextval, 1, 'chattest1', '즐ㅋ', sysdate + 1/60/24*4 , 'n', null);
INSERT INTO JOONGO_CHAT_MSG VALUES(chat_msg_seq.nextval, 1, 'chattest2', ';;;', sysdate + 1/60/24*5, 'n', null);