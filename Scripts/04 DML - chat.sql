-- test용 유저

INSERT INTO MEMBER VALUES('chattest1', '1234', '채팅요정', '챗1', 'chat01@test.co.kr', '010-1234-4321', 44, 1, NULL, NULL, sysdate);
INSERT INTO MEMBER VALUES('chattest2', '1234', '채팅유저', '챗2', 'chat02@test.co.kr', '010-1234-4999', 3,  44, 1, NULL, NULL, sysdate);

-- test용 중고판매글
INSERT INTO JOONGO_SALE(id, mem_id, dog_cate, cat_cate, title, content, price, DONGNE1_ID, DONGNE2_ID, BUY_MEM_id, SALE_STATE, regdate, redate, hits)
VALUES(sale_seq.nextval, 'chattest1', 'n', 'y', '고양이 그려드립니다ㅋ', '허접한 그림입니다', 100, 3, 44, NULL, 1, sysdate, sysdate, 0);

-- joongo_chat: id, sale_id, sale_mem_id, buy_mem_id, regdate, latest_date
-- joongo_chat_msg: id, chat_id, mem_id, content, regdate, read_yn, image

-- sale: id, mem_id, dog_cate, cat_cate, title, content, price, dongne1_id, dongne2_id, buy_mem_id, sale_state, regdate, regdate, hits
