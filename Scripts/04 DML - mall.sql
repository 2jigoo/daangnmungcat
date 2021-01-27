INSERT INTO MALL_DOG_CATE VALUES(mall_dog_cate_seq.nextval, '미지정');
INSERT INTO MALL_DOG_CATE VALUES(mall_dog_cate_seq.nextval, '사료');
INSERT INTO MALL_DOG_CATE VALUES(mall_dog_cate_seq.nextval, '배변패드');
INSERT INTO MALL_DOG_CATE VALUES(mall_dog_cate_seq.nextval, '간식');
INSERT INTO MALL_DOG_CATE VALUES(mall_dog_cate_seq.nextval, '장난감');
INSERT INTO MALL_DOG_CATE VALUES(mall_dog_cate_seq.nextval, '영양제');

INSERT INTO MALL_CAT_CATE VALUES(mall_cat_cate_seq.nextval, '미지정');
INSERT INTO MALL_CAT_CATE VALUES(mall_cat_cate_seq.nextval, '사료');
INSERT INTO MALL_CAT_CATE VALUES(mall_cat_cate_seq.nextval, '배변패드');
INSERT INTO MALL_CAT_CATE VALUES(mall_cat_cate_seq.nextval, '간식');
INSERT INTO MALL_CAT_CATE VALUES(mall_cat_cate_seq.nextval, '장난감');
INSERT INTO MALL_CAT_CATE VALUES(mall_cat_cate_seq.nextval, '영양제');


INSERT INTO MALL_PDT VALUES(mall_pdt_seq.nextval, 2, NULL, '네츄럴코어', 13000, '네츄럴코어 사료입니다.', 'Y', 100, NULL, NULL, NULL, '조건부 무료배송', 50000, 3000, sysdate);
INSERT INTO MALL_PDT VALUES(mall_pdt_seq.nextval, 2, NULL, '로얄캐닌', 23000, NULL, 'Y', 100, NULL, NULL, NULL, '무료배송', NULL, NULL, sysdate);
INSERT INTO MALL_PDT VALUES(mall_pdt_seq.nextval, NULL, 3, '모래 2kg', 33000, '모래입니다.', 'Y', 100, NULL, NULL, NULL, '조건부 무료배송', 50000, 3000, sysdate);
INSERT INTO MALL_PDT VALUES(mall_pdt_seq.nextval, 4, 4, '간식', 15000, '간식입니다.', 'Y', 100, NULL, NULL, NULL, '유료배송', NULL, 3000, sysdate);
INSERT INTO MALL_PDT VALUES(mall_pdt_seq.nextval, 6, 6, '영양제', 20000, '영양제입니다.', 'Y', 100, NULL, NULL, NULL, '조건부 무료배송', 50000, 3000, sysdate);