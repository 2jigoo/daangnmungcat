# 당근멍캣 프로젝트
**http://daangnmungcat.herokuapp.com/**

**당근마켓 클론 및 쇼핑몰 프로젝트**

- 거래지역을 현재 위치 또는 특정 지역으로 설정 후, 반려동물 용품을 중고 거래할 수 있는 서비스
- 반려동물 용품 쇼핑몰 서비스


<br>

**배포**
- Web 서버 : Heroku
- DB 서버 : Ubuntu Oracle 11g (오라클 무료 인스턴스 이용)

<br>

**관리자**

`test / test1234`

**사용자**

`chattest1 / test1234`, `chattest2 / test1234`

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

>GPS 정보 수집 동의 후 현재 위치의 시/구를 '내 동네'로 설정한다.  
택배 거래를 위해 다른 지역을 설정할 수도 있다.
　

### 2. 판매글 작성 및 수정, 삭제
'내 동네' 또는 특정 지역에 대해 게시글 작성  
대표 이미지, 상품 이미지 다수 추가 가능

### 3. 게시글 판매상태 변경
- 판매중
- 예약중
- 판매완료
>1:1 대화 또는 게시글 조회에서 변경 가능.  
1:1 대화에서 판매완료 처리시 구매자가 지정 되고 거래평점, 거래후기 남길 수 있음


### 4. 1:1 대화

Stomp 프로토콜을 이용한 채팅  
읽음 여부 확인, 이미지 파일 전송 가능. 구매자 지정과 함께 판매완료 처리.


### 5. 계층형 댓글

대댓글시 @사용자 태그

### 6. 찜

<br>

## 쇼핑몰

### 1. 카테고리 관리

### 2. 상품 관리

재고수량 변경, 판매상태 변경, 배송비 유형 선택

### 3. 장바구니

회원 및 비회원 모두 사용 가능.  
비회원 장바구니 상품이 존재할 때 로그인 시 해당 계정으로 추가 됨.

### 4. 주문
무통장 결제 / 카카오페이 결제  
주문 시 재고 차감 및 마일리지 사용 가능. 취소 시 재고 및 마일리지 복구  
배송지 관리

### 5. 마일리지
가입 및 쇼핑몰 주문건 구매확정 시 지급  
일괄/개별 지급. 상품 구매시 사용가능.

<br>

## 공지사항
관리자 권한의 아이디로 글 작성 가능

<br>

# ERD
![당근멍캣 erd](https://user-images.githubusercontent.com/75772990/114294263-55ead980-9ad8-11eb-9b54-949b4b1f04de.jpg)

<br>
<br>

-------------------

<br>

## 파트별 상세 설명
- [README.md](https://github.com/ssuktteok/daangnmungcat#readme)
- [회원 및 프로필 / 마이페이지](https://github.com/ssuktteok/daangnmungcat/blob/master/documents/member_view.md)
- [중고거래](https://github.com/ssuktteok/daangnmungcat/blob/master/documents/joongo_view.md)
- [1:1 채팅 및 리뷰](https://github.com/ssuktteok/daangnmungcat/blob/master/documents/chat_review_view.md)
- [쇼핑몰 상품 및 장바구니](https://github.com/ssuktteok/daangnmungcat/blob/master/documents/mall_pdt_cart_view.md)
- [쇼핑몰 주문](https://github.com/ssuktteok/daangnmungcat/blob/master/documents/order_view.md)
- [마일리지 및 공지사항](https://github.com/ssuktteok/daangnmungcat/blob/master/documents/mileage_notice_view.md)

