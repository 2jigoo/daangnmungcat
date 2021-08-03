### 파트별 상세 설명
- [README.md](https://github.com/2jigoo/daangnmungcat#readme)
- [회원 및 프로필 / 마이페이지](https://github.com/2jigoo/daangnmungcat/blob/master/documents/member_view.md)
- [중고거래](https://github.com/2jigoo/daangnmungcat/blob/master/documents/joongo_view.md)
- [1:1 채팅 및 리뷰](https://github.com/2jigoo/daangnmungcat/blob/master/documents/chat_review_view.md)
- [쇼핑몰 상품 및 장바구니](https://github.com/2jigoo/daangnmungcat/blob/master/documents/mall_pdt_cart_view.md)
- [쇼핑몰 주문](https://github.com/2jigoo/daangnmungcat/blob/master/documents/order_view.md)
- [마일리지 및 공지사항](https://github.com/2jigoo/daangnmungcat/blob/master/documents/mileage_notice_view.md)

----
<br>


# 주문

## 주문 화면
- 장바구니에서 선택된 상품만 주문
- 조건별 배송비 계산 후 합계와 적립예정 마일리지 표시 
- 배송지 관리에서 나의 배송지 선택 / 추가,수정,삭제
- 보유 마일리지 입력에 따른 최종 결제 금액 계산(보유 마일리지 이상 입력 불가능)
- 무통장 / 카카오페이 선택
<img src="https://user-images.githubusercontent.com/75772939/128063697-c7567a8e-c387-4543-afd0-bed0fb6fa057.jpg" width="700px">
<br>
<br>
<br>

## 주문 완료 화면

- 카카오페이 - QR혹은 전화번호 입력 후 결제(테스트 cid 적용)

<img src="https://user-images.githubusercontent.com/75772990/114681691-5b028f80-9d49-11eb-8b5c-54f665ba0452.png" width="500px">
<br>
<br>
<br>

## 주문 내역
- 기본 한달 간 전체 주문 내역 조회
- 기간 별 주문 내역 검색
- 입금 대기상태일 시 주문취소 가능
- 관리자가 상태변경 및 운송장 입력 시 구매확정 버튼 생성 -> 마일리지 적립

<img src="https://user-images.githubusercontent.com/75772990/114679726-65238e80-9d47-11eb-9b49-a6018a851353.png" width="700px">
<br>
<br>
<br>

## 주문 상세
- 주문자 정보, 배송지 정보, 결제정보 확인

<img src="https://user-images.githubusercontent.com/75772939/128062360-d17f0c00-1f40-4dcf-9e19-6628cf79ad54.jpg" width="700px">

<br>
<br>
<br>

# 주문 관리

## 주문 목록
- 주문상태 / 결제수단 / 기타선택 / 주문일자 등으로 검색하여 조건에 맞는 주문서 조회
- 주문 취소 금액이 있을 시와 미수금 있을 시 해당 주문건 표시
- 주문자 / 배송지 정보 수정
<br>
<img src="https://user-images.githubusercontent.com/75772939/128065022-3fbe75d9-5664-448f-a07f-2a110db15ff9.jpg">


<br>
<br>
<br>

## 주문 상세
- 한 주문건 내 개별 상품 상태 변경 가능
- 운송장 번호 등록 시 사용자 마이페이지 주문 내역에 노출
<br>

<img src="https://user-images.githubusercontent.com/75772939/128065667-1a9a450b-9f7d-461f-8a2f-b527b46c135d.jpg">
<br>
<br>

#### 무통장
- 결제 금액 입력 후 수정 시 사용한 마일리지 제외 미수금 자동 계산되어 입력
- 배송비 / 포인트 사용 금액 수정 시 미수금 자동 계산
- 결제금액 입력 체크 시 최종 결제 금액 자동 입력
<br>

#### 카카오페이
- 부분취소 팝업 -> 취소할 금액 입력하여 결제 취소
