# 당근멍캣 프로젝트
**http://daangnmungcat.herokuapp.com/**

**당근마켓 클론 및 쇼핑몰 프로젝트**

- 거래지역을 현재 위치 또는 특정 지역으로 설정 후, 반려동물 용품을 중고 거래할 수 있는 서비스
- 반려동물 용품 쇼핑몰 서비스


<br>

**배포**
- Web 서버 : Heroku
- DB 서버 : Ubuntu Oracle 11g (오라클 무료 인스턴스 이용)

</br>

# 요구사항

## 회원
1. 휴대폰 번호로 본인 인증
2. 비밀번호 암호화
3. 사용자 프로필
4. 마이페이지

<br>

## 중고

### 1. 지역 설정

>GPS 수집 동의 후 현재 위치의 시/구를 '내 동네'로 설정한다.
택배 거래를 위해 다른 지역을 설정할 수도 있다.
　

### 2. 판매글 작성 및 수정, 삭제

### 3. 게시글 판매상태 변경
- 판매중
- 예약중
- 판매완료
>1:1 대화 또는 게시글 조회에서 변경 가능.
1:1 대화에서 판매완료 처리시 구매자가 지정 되고 거래평점, 거래후기 남길 수 있음


### 4. 1:1 대화

이미지 파일 전송. 판매완료 처리 기능 포함.


### 5. 계층형 댓글
### 6. 찜

<br>

## 쇼핑몰

### 1. 카테고리 관리

### 2. 상품 관리

### 3. 장바구니
회원 및 비회원 모두 사용 가능

### 4. 주문
무통장 결제, 카카오페이 결제. 주문 시 재고 차감, 취소 시 재고 및 마일리지 복구.

### 5. 마일리지
가입, 구매확정 시 지급. 개별 지급. 상품 구매시 사용가능.

<br>

## 공지사항
관리자 권한의 아이디로 글 작성 가능

<br>

# ERD
![당근멍캣 erd](https://user-images.githubusercontent.com/75772990/114294263-55ead980-9ad8-11eb-9b54-949b4b1f04de.jpg)

<br>
<br>

-------------------



# View

## 회원


## 중고
### [중고상품 목록]

![image](https://user-images.githubusercontent.com/75772990/114667875-fa6c5600-9d3a-11eb-906f-7117352c5d41.png)

### [중고판매글 상세보기]
![daangnmungcat herokuapp com_joongoSale_detailList_id=22](https://user-images.githubusercontent.com/75772990/114681689-5b028f80-9d49-11eb-8dfd-ca29ac622bdf.png)


-----------

## 1:1 대화

### [대화 목록]
![채팅 목록](https://user-images.githubusercontent.com/75772990/114677861-a9159400-9d45-11eb-94c8-55b72667adbf.png)

### [대화창 화면]
![image](https://user-images.githubusercontent.com/75772990/114674036-c5afcd00-9d41-11eb-8de7-e7e0d6dca9b7.png)

![image](https://user-images.githubusercontent.com/75772990/114678010-cc404380-9d45-11eb-8dc2-2c36d732d1cd.png)

![image](https://user-images.githubusercontent.com/75772990/114678071-d9f5c900-9d45-11eb-9d77-fde4da915cf0.png)

![image](https://user-images.githubusercontent.com/75772990/114678323-17f2ed00-9d46-11eb-9dd0-b38ace1fe9f4.png)


----------

## 리뷰

![image](https://user-images.githubusercontent.com/75772990/114678157-f5f96a80-9d45-11eb-93e6-283f67985496.png)

![image](https://user-images.githubusercontent.com/75772990/114680152-d3685100-9d47-11eb-9d28-2960ce77eeab.png)

----------

## 상품

![image](https://user-images.githubusercontent.com/75772990/114679656-563cdc00-9d47-11eb-8a0c-8b021d5eebcd.png)

------------

## 장바구니

![image](https://user-images.githubusercontent.com/75772990/114674691-76b66780-9d42-11eb-9416-e783b8d95f6a.png)

------------

## 주문

![daangnmungcat herokuapp com_mall_pre-order_list](https://user-images.githubusercontent.com/75772990/114681694-5b9b2600-9d49-11eb-8001-7886a4e0729e.png)

![daangnmungcat herokuapp com_mall_order_order_end](https://user-images.githubusercontent.com/75772990/114681691-5b028f80-9d49-11eb-8b5c-54f665ba0452.png)

![image](https://user-images.githubusercontent.com/75772990/114679726-65238e80-9d47-11eb-9b49-a6018a851353.png)

------------

## 프로필

![image](https://user-images.githubusercontent.com/75772990/114679605-458c6600-9d47-11eb-9fb4-bb73784764c6.png)

![daangnmungcat herokuapp com_profile_edit](https://user-images.githubusercontent.com/75772990/114681697-5c33bc80-9d49-11eb-92ba-6bde084f3f14.png)



## 마이페이지

![daangnmungcat herokuapp com_mypage_mypage_main](https://user-images.githubusercontent.com/75772990/114681696-5b9b2600-9d49-11eb-8a7a-ce2227491b2b.png)

-----------

## 공지사항
![image](https://user-images.githubusercontent.com/75772990/114668774-14f2ff00-9d3c-11eb-950e-f707e1b84651.png)

![image](https://user-images.githubusercontent.com/75772990/114668837-263c0b80-9d3c-11eb-83e8-411fa8fb22cc.png)



# 관리자 페이지

## 회원 관리

![image](https://user-images.githubusercontent.com/75772990/114680328-027ec280-9d48-11eb-8d86-c7bef3de13e3.png)


## 중고 관리

![image](https://user-images.githubusercontent.com/75772990/114680367-0f031b00-9d48-11eb-8541-e48deded59a0.png)

## 쇼핑몰 관리

### 카테고리
![image](https://user-images.githubusercontent.com/75772990/114680552-47a2f480-9d48-11eb-9c20-e1311941a8cc.png)

### 상품 관리
![image](https://user-images.githubusercontent.com/75772990/114680631-58536a80-9d48-11eb-82d3-29ea38f16beb.png)

![daangnmungcat herokuapp com_admin_product_write](https://user-images.githubusercontent.com/75772990/114681687-5a69f900-9d49-11eb-89f2-550120126b7d.png)

### 주문 관리

![daangnmungcat herokuapp com_admin_order_detail](https://user-images.githubusercontent.com/75772990/114681680-59d16280-9d49-11eb-8620-124120337878.png)
![daangnmungcat herokuapp com_admin_order_list](https://user-images.githubusercontent.com/75772990/114681683-59d16280-9d49-11eb-8fef-e2ec9a10c2a5.png)


### 마일리지

![image](https://user-images.githubusercontent.com/75772990/114681171-d879d000-9d48-11eb-86a0-fb5d0517c132.png)
![image](https://user-images.githubusercontent.com/75772990/114681281-f47d7180-9d48-11eb-847c-e8889ac5e15c.png)

## 공지사항 관리
![image](https://user-images.githubusercontent.com/75772990/114681407-1676f400-9d49-11eb-9ee1-a49dbe44aaa6.png)
![daangnmungcat herokuapp com_admin_notice_modify_id=21](https://user-images.githubusercontent.com/75772990/114681673-58a03580-9d49-11eb-80bb-6103225aa937.png)


