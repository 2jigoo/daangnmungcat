DROP TABLE MALL_PDT CASCADE CONSTRAINTS; /* 쇼핑몰_상품 */
DROP TABLE MALL_DOG_CATE CASCADE CONSTRAINTS; /* 쇼핑몰_멍 카테 */
DROP TABLE MALL_CAT_CATE CASCADE CONSTRAINTS; /* 쇼핑몰_냥 카테 */
DROP TABLE ORDER_address CASCADE CONSTRAINTS; /* 배송지관리 */
DROP TABLE MALL_DELIVERY CASCADE CONSTRAINTS; /* 배송비종류 */
DROP TABLE MALL_CART CASCADE CONSTRAINTS; /* 쇼핑몰_카트 */
DROP TABLE MALL_ORDER CASCADE CONSTRAINTS; /* 쇼핑몰_주문 */
DROP TABLE MALL_ORDER_DETAIL CASCADE CONSTRAINTS; /* 쇼핑몰_주문상세 */
DROP TABLE MALL_MILEAGE CASCADE CONSTRAINTS;/* 쇼핑몰_마일리지 */
DROP TABLE MALL_PAYMENT CASCADE CONSTRAINTS;/* 쇼핑몰_결제수단 */


/* 쇼핑몰_멍_카테고리 */
CREATE TABLE MALL_DOG_CATE (
	id NUMBER(12) NOT NULL, /* 멍카테고리아이디 */
	name VARCHAR2(36) NOT NULL /* 분류명 */
)SEGMENT CREATION IMMEDIATE;

CREATE UNIQUE INDEX PK_MALL_DOG_CATE ON MALL_DOG_CATE (id ASC);

ALTER TABLE MALL_DOG_CATE
	ADD CONSTRAINT PK_MALL_DOG_CATE PRIMARY KEY (id);


/* 쇼핑몰_냥_카테고리 */
CREATE TABLE MALL_CAT_CATE (
	id NUMBER(12) NOT NULL, /* 냥카테고리아이디 */
	name VARCHAR2(36) NOT NULL /* 분류명 */
)SEGMENT CREATION IMMEDIATE;

CREATE UNIQUE INDEX PK_MALL_CAT_CATE
	ON MALL_CAT_CATE (id ASC);

ALTER TABLE MALL_CAT_CATE
	ADD CONSTRAINT PK_MALL_CAT_CATE PRIMARY KEY (id);



/* 쇼핑몰_상품 */
CREATE TABLE MALL_PDT (
	id NUMBER(12) NOT NULL, /* 상품아이디 */
	dog_cate NUMBER(12), /* 멍카테고리아이디 */
	cat_cate NUMBER(12), /* 냥카테고리아이디 */
	name VARCHAR2(1500) NOT NULL, /* 상품명 */
	price NUMBER(10) NOT NULL, /* 가격 */
	content VARCHAR2(4000), /* 내용 */
	sale_yn VARCHAR2(1) NOT NULL, /* 판매여부 */
	stock NUMBER(12) NOT NULL, /* 재고 */
	image1 VARCHAR2(255), /* 상품이미지1 */
	image2 VARCHAR2(255), /* 상품이미지2 */
	image3 VARCHAR2(255), /* 상품이미지3 */
	delivery_kind VARCHAR2(1500) NOT NULL, /* 배송비 종류 */
	delivery_condition NUMBER(10), /* 조건 금액 */
	delivery_price NUMBER(10), /* 배송비 */
	regdate DATE DEFAULT SYSDATE /* 등록일시 */
)SEGMENT CREATION IMMEDIATE;

CREATE UNIQUE INDEX PK_MALL_PDT
	ON MALL_PDT (id ASC);

ALTER TABLE MALL_PDT
	ADD CONSTRAINT PK_MALL_PDT PRIMARY KEY (id);


ALTER TABLE MALL_PDT
	ADD CONSTRAINT FK_MALL_DOG_CATE_TO_MALL_PDT FOREIGN KEY (dog_cate ) REFERENCES MALL_DOG_CATE (id);

ALTER TABLE MALL_PDT
	ADD CONSTRAINT FK_MALL_CAT_CATE_TO_MALL_PDT FOREIGN KEY (cat_cate) REFERENCES MALL_CAT_CATE (id);
		

/* 배송지목록 */
CREATE TABLE ORDER_ADDRESS (
	id NUMBER(12) NOT NULL, /* 배송지번호 */
	mem_id VARCHAR2(20) NOT NULL, /* 회원아이디 */
	subject VARCHAR2(36) NOT NULL, /* 배송지명 */
	name VARCHAR2(36) NOT NULL, /* 받는사람 */
	phone VARCHAR2(20) NOT NULL, /* 전화번호 */
	zipcode NUMBER(5) NOT NULL, /* 우편번호 */
	address1 VARCHAR2(255) NOT NULL, /* 주소1 */
	address2 VARCHAR2(255) NOT NULL, /* 주소2 */
	memo VARCHAR2(1500) /* 메모 */
)SEGMENT CREATION IMMEDIATE;

ALTER TABLE ORDER_ADDRESS ADD CONSTRAINT PK_ORDER_ADDRESS PRIMARY KEY (id);	

ALTER TABLE ORDER_ADDRESS
	ADD CONSTRAINT FK_MEMBER_TO_ORDER_ADDRESS FOREIGN KEY (mem_id) REFERENCES MEMBER (id);

/* 쇼핑몰_배송비종류 */
CREATE TABLE MALL_DELIVERY (
	id NUMBER(12) NOT NULL, /* 배송비번호 */
	name VARCHAR2(1500) NOT NULL, /* 배송비유형이름 */
	price NUMBER(10) NOT NULL /* 배송비가격 */
)SEGMENT CREATION IMMEDIATE;

CREATE UNIQUE INDEX PK_MALL_DELIVERY
	ON MALL_DELIVERY (id ASC);

ALTER TABLE MALL_DELIVERY
	ADD CONSTRAINT PK_MALL_DELIVERY PRIMARY KEY (id);
	


/* 쇼핑몰_카트 */
CREATE TABLE MALL_CART (
	id			NUMBER(12) PRIMARY KEY, /* 장바구니 번호 */
	member_id VARCHAR2(20), /* 회원아이디 */
	product_id		NUMBER(12) NOT NULL, /* 상품아이디 */
	quantity	NUMBER(4), /* 수량 */
	regdate		 DATE, /* 등록일 */
	basket_id VARCHAR2(128)
)SEGMENT CREATION IMMEDIATE;

ALTER TABLE MALL_CART
	ADD CONSTRAINT FK_MEMBER_TO_MALL_CART FOREIGN KEY (member_id) REFERENCES MEMBER (id);

ALTER TABLE MALL_CART
	ADD CONSTRAINT FK_MALL_PDT_TO_MALL_CART FOREIGN KEY (product_id) REFERENCES MALL_PDT (id);
	

/* 쇼핑몰_주문 */
CREATE TABLE MALL_ORDER (
	id varchar2(20) NOT NULL, /* 주문서아이디 */
	mem_id VARCHAR2(20) NOT NULL, /* 회원아이디 */
	mem_name VARCHAR2(36) NOT NULL, /* 회원이름 */
	mem_email VARCHAR2(50) NOT NULL, /* 회원이메일 */
	mem_phone VARCHAR2(20) NOT NULL, /* 회원연락처 */
	address_name VARCHAR2(20) NOT NULL, /* 받는 사람 */
	zipcode NUMBER(5) NOT NULL, /* 우편번호 */
	address1 VARCHAR2(255) NOT NULL, /* 배송주소 */
	address2 VARCHAR2(255) NOT NULL, /* 배송상세주소 */
	address_phone1 VARCHAR2(20), /* 배송연락처1 */
	address_phone2 VARCHAR2(20) NOT NULL, /* 배송연락처2 */
	address_memo VARCHAR2(1500), /* 배송메모 */
	total_price NUMBER(10) NOT NULL, /* 총가격 */
	used_mileage NUMBER(10) NOT NULL, /* 마일리지사용금액 */
	final_price NUMBER(10) NOT NULL, /* 최종가격 */
	plus_mileage NUMBER(10) NOT NULL, /* 마일리지적립금액 */
	delivery_price NUMBER(10) NOT NULL, /* 배송비 */
	settle_case varchar2(20) NOT NULL, /* 지불 수단 */
	tracking_number varchar2(20), /*운송장 번호*/
	shipping_date DATE, /*배송날짜*/
	add_delivery_price NUMBER(10), /* 추가배송비 */
	pay_id varchar2(30), /* 결제번호 */
	pay_date DATE,
	regdate DATE DEFAULT SYSDATE, 
	return_price NUMBER(10), /* 반품/품절금액 */
	state VARCHAR2(20) NOT NULL, /* 주문상태 */
	misu NUMBER(10)/* 미수금 */
);

ALTER TABLE mall_order ADD pay_date DATE;

CREATE UNIQUE INDEX PK_MALL_ORDER
	ON MALL_ORDER (
		id ASC
	);

ALTER TABLE MALL_ORDER
	ADD
		CONSTRAINT PK_MALL_ORDER
		PRIMARY KEY (
			id
		);

/* 쇼핑몰_주문상세 */
CREATE TABLE MALL_ORDER_DETAIL (
	id NUMBER(12) NOT NULL, /* 새 컬럼 */
	order_id varchar2(20) NOT NULL, /* 주문서아이디 */
	mem_id VARCHAR2(20) NOT NULL,
	pdt_id NUMBER(12) NOT NULL, /* 상품아이디 */
	quantity NUMBER(4) NOT NULL, /* 수량 */
	price NUMBER(12) NOT NULL, /* 가격 */
	total_price NUMBER(12) NOT NULL,/* 총가격 */
	order_state VARCHAR2(30)
);

CREATE UNIQUE INDEX PK_MALL_ORDER_DETAIL
	ON MALL_ORDER_DETAIL (
		id ASC
	);

ALTER TABLE MALL_ORDER_DETAIL
	ADD
		CONSTRAINT PK_MALL_ORDER_DETAIL
		PRIMARY KEY (
			id
		);
	

/* 쇼핑몰_마일리지 */
CREATE TABLE MALL_MILEAGE (
	id NUMBER(12) NOT NULL, /* 새 컬럼 */
	od_id varchar2(20), /* 상세주문id */
	mem_id VARCHAR2(20) NOT NULL, /* 회원아이디 */
	mileage  NUMBER(12) NOT NULL, /* 적립및사용금액 */
	content VARCHAR2(1500) NOT NULL, /* 적립및사용 내용 */
	regdate DATE DEFAULT SYSDATE /* 적립일시 */
);

CREATE UNIQUE INDEX PK_MALL_MILEAGE
	ON MALL_MILEAGE (
		id ASC
	);

ALTER TABLE MALL_MILEAGE
	ADD
		CONSTRAINT PK_MALL_MILEAGE
		PRIMARY KEY (
			id
		);

/* 쇼핑몰_결제수단 */
CREATE TABLE MALL_PAYMENT (
	id varchar2(30) NOT NULL, /* 아이디 */
	mem_id VARCHAR2(20) NOT NULL, /* 회원아이디 */
	order_id varchar2(20) NOT NULL, /* 주문서아이디 */
	pay_price NUMBER(10) NOT NULL, /* 결제금액 */
	pay_date DATE DEFAULT SYSDATE, /* 결제일시 */
	pay_type VARCHAR2(1500) NOT NULL, /* 결제방법 */
	pay_quantity NUMBER(12) NOT NULL, /* 수량 */
	pay_state VARCHAR2(30) DEFAULT '결제완료'
);


CREATE UNIQUE INDEX PK_MALL_PAYMENT
	ON MALL_PAYMENT (
		id ASC
	);

ALTER TABLE MALL_PAYMENT
	ADD
		CONSTRAINT PK_MALL_PAYMENT
		PRIMARY KEY (
			id
		);
