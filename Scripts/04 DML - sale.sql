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
