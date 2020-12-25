SELECT * FROM JOONGO_CHAT jc;
SELECT * FROM JOONGO_CHAT_MSG jcm;

-- joongo_chat: id, sale_id, sale_mem_id, buy_mem_id, regdate, latest_date
-- joongo_chat_msg: id, chat_id, mem_id, content, regdate, read_yn, image

SELECT jc.id, sale_id, sale_mem_id, sm.nickname, buy_mem_id, bm.nickname, jc.regdate, latest_date
FROM JOONGO_CHAT jc
	LEFT OUTER JOIN MEMBER sm ON (jc.SALE_MEM_ID = sm.id)
	LEFT OUTER JOIN MEMBER bm ON (jc.BUY_MEM_ID = bm.id);
	--LEFT OUTER JOIN JOONGO_CHAT_MSG jcm ON (jc.ID = jcm.CHAT_ID )


INSERT INTO MEMBER VALUES('chattest1', '1234', '채팅요정', 'chatUser01', 'chat01@test.co.kr', '010-1234-4321', 3,  44, 1, NULL, NULL, sysdate);
INSERT INTO MEMBER VALUES('chattest2', '1234', '채팅유저', 'chatUser02', 'chat02@test.co.kr', '010-1234-4999', 3,  44, 1, NULL, NULL, sysdate);


-- sale: id, mem_id, dog_cate, cat_cate, title, content, price, dongne1_id, dongne2_id, buy_mem_id, sale_state, regdate, regdate, hits;
SELECT * FROM joongo_sale;

INSERT INTO JOONGO_SALE(id, mem_id, dog_cate, cat_cate, title, content, price, DONGNE1_ID, DONGNE2_ID, BUY_MEM_id, SALE_STATE, regdate, redate, hits)
VALUES(sale_seq.nextval, 'chattest1', 'n', 'y', '고양이 그려드립니다ㅋ', '허접한 그림입니다', 100, 3, 44, NULL, 1, sysdate, sysdate, 0);
