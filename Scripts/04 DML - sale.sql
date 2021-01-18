-- 중고 거래 등록 상품
SELECT * FROM JOONGO_SALE;

INSERT INTO JOONGO_SALE VALUES(sale_seq.nextval, 'chattest1', 'n', 'y', '자전거 판매합니다.', '자전거를 판매하는 내용입니다.', 100, 1, 1, NULL, 1, sysdate, sysdate, 0, 0, 0);
INSERT INTO JOONGO_SALE VALUES(sale_seq.nextval, 'chattest1', 'n', 'y', '자전거 판매합니다.', '자전거를 판매하는 내용입니다.', 100, 1, 1, NULL, 1, sysdate, sysdate, 0, 0,0);
INSERT INTO JOONGO_SALE VALUES(sale_seq.nextval, 'chattest1', 'n', 'y', '자전거 판매합니다.', '자전거를 판매하는 내용입니다.', 100, 1, 3, NULL, 1, sysdate, sysdate, 0, 0,0);
INSERT INTO JOONGO_SALE VALUES(sale_seq.nextval, 'chattest1', 'n', 'y', '자전거 판매합니다.', '자전거를 판매하는 내용입니다.', 100, 1, 5, NULL, 1, sysdate, sysdate, 0, 0,0);
INSERT INTO JOONGO_SALE VALUES(sale_seq.nextval, 'chattest1', 'n', 'y', '자전거 판매합니다.', '자전거를 판매하는 내용입니다.', 100, 2, 30, NULL, 1, sysdate, sysdate, 0, 0, 0);
INSERT INTO JOONGO_SALE VALUES(sale_seq.nextval, 'chattest1', 'n', 'y', '자전거 판매합니다.', '자전거를 판매하는 내용입니다.', 100, 2, 31, NULL, 1, sysdate, sysdate, 0, 0, 0);
INSERT INTO JOONGO_SALE VALUES(sale_seq.nextval, 'chattest1', 'n', 'y', '자전거 판매합니다.', '자전거를 판매하는 내용입니다.', 100, 3, 46, NULL, 1, sysdate, sysdate, 0, 0, 0);
INSERT INTO JOONGO_SALE VALUES(sale_seq.nextval, 'chattest1', 'n', 'y', '자전거 판매합니다.', '자전거를 판매하는 내용입니다.', 100, 4, 55, NULL, 1, sysdate, sysdate, 0, 0, 0);
INSERT INTO JOONGO_SALE VALUES(sale_seq.nextval, 'chattest1', 'n', 'y', '자전거 판매합니다.', '자전거를 판매하는 내용입니다.', 100, 4, 59, NULL, 1, sysdate, sysdate, 0, 0,0);
INSERT INTO JOONGO_SALE VALUES(sale_seq.nextval, 'chattest1', 'n', 'y', '자전거 판매합니다.', '자전거를 판매하는 내용입니다.', 100, 5, 60, NULL, 1, sysdate, sysdate, 0, 0, 0);

DROP VIEW SALE_VIEW ;

--상세보기 뷰
CREATE OR REPLACE VIEW sale_view
AS SELECT s.id AS id, m.id AS MEM_ID, dv.D1NAME as dongne1_name, dv.D2NAME as dongne2_name, grade, profile_pic, 
	DOG_CATE, CAT_CATE, TITLE, CONTENT,PRICE, s.REGDATE AS regdate, 
	REDATE, SALE_STATE, BUY_MEM_ID, HITS , CHAT_COUNT , HEART_COUNT
	FROM JOONGO_SALE s 
	JOIN DONGNE_VIEW dv on s.DONGNE2_ID = dv.D2ID
	JOIN MEMBER m ON s.MEM_ID = m.id;

