# 당근멍캣 프로젝트
<div>
<img src="https://img.shields.io/badge/java-007396?style=for-the-badge&logo=java&logoColor=white">
<img src="http://img.shields.io/badge/Spring_&_Spring_Secuirty-6DB33F?style=for-the-badge&logo=Spring&logoColor=white">
<img src="http://img.shields.io/badge/Oracle_DBMS-F80000?style=for-the-badge&logo=Oracle&logoColor=white">
<img src="https://img.shields.io/badge/MyBatis-060606?style=for-the-badge">
<img src="https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=HTML5&logoColor=white">
<img src="https://img.shields.io/badge/css3-1572B6?style=for-the-badge&logo=css3&logoColor=white">
<img src="https://img.shields.io/badge/javascript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black">
<img src="https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jQuery&logoColor=white">
</div>
<br>

**http://daangnmungcat.herokuapp.com/**


#### 당근마켓 클론 및 쇼핑몰 프로젝트

- 거래지역을 현재 위치 또는 특정 지역으로 설정 후, 반려동물 용품을 중고 거래할 수 있는 서비스
- 반려동물 용품 쇼핑몰 서비스

<br>

#### 팀원
- [2jigoo](https://github.com/2jigoo) - 스프링 시큐리티, 채팅, 장바구니, 공지사항, 프로필
- [xoxohjkim](https://github.com/xoxohjkim) - 회원, 주문(카카오페이), 배송지 설정, 마이페이지
- [22seungIs](https://github.com/22seungIs) - 중고거래글, 마일리지
- [5sujung](https://github.com/5sujung) - 내동네, 중고거래 댓글, 리뷰, 쇼핑몰 상품관리

<br>

**배포**
- Web 서버 : Heroku
- DB 서버 : Ubuntu Oracle 11g (오라클 무료 인스턴스 이용)

<br>

>*별도 이미지 서버를 이용하지 않았기 때문에 이미지가 엑박일 수 있습니다.*

<br>

#### 관리자 계정

`test / test1234`

#### 사용자 계정

`chattest1 / test1234`, `chattest2 / test1234`

</br>

# 요구사항

## 회원
1. 휴대폰 번호로 본인 인증
2. 비밀번호 BCrypt 암호화
3. 사용자 프로필
4. 마이페이지

<br>

## 중고

### 1. 지역 설정

**Google Maps**를 이용해 GPS 정보 수집 후 현재 위치의 시/구를 '내 동네'로 설정한다.  
택배 거래를 위해 다른 지역을 설정할 수도 있다.
　

### 2. 판매글 작성 및 수정, 삭제
'내 동네' 또는 특정 지역에 대해 게시글 작성  
대표 이미지, 상품 이미지 다수 추가 가능

### 3. 게시글 판매상태 변경
- 판매중
- 예약중
- 판매완료
>1:1 채팅 또는 게시글 조회에서 변경 가능.  
1:1 채팅에서 판매완료 처리시 구매자가 지정 되고 거래평점, 거래후기 남길 수 있음


### 4. 1:1 채팅

**Stomp 프로토콜**을 이용한 채팅  
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
무통장 결제 / **카카오페이 결제**  
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
- [README.md](https://github.com/2jigoo/daangnmungcat#readme)
- [회원 및 프로필 / 마이페이지](https://github.com/2jigoo/daangnmungcat/blob/master/documents/member_view.md)
- [중고거래](https://github.com/2jigoo/daangnmungcat/blob/master/documents/joongo_view.md)
- [1:1 채팅 및 리뷰](https://github.com/2jigoo/daangnmungcat/blob/master/documents/chat_review_view.md)
- [쇼핑몰 상품 및 장바구니](https://github.com/2jigoo/daangnmungcat/blob/master/documents/mall_pdt_cart_view.md)
- [쇼핑몰 주문](https://github.com/2jigoo/daangnmungcat/blob/master/documents/order_view.md)
- [마일리지 및 공지사항](https://github.com/2jigoo/daangnmungcat/blob/master/documents/mileage_notice_view.md)


