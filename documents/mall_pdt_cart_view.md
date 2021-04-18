### 파트별 상세 설명
- [README.md](https://github.com/ssuktteok/daangnmungcat#readme)
- [회원 및 프로필 / 마이페이지](https://github.com/ssuktteok/daangnmungcat/blob/master/documents/member_view.md)
- [중고거래](https://github.com/ssuktteok/daangnmungcat/blob/master/documents/joongo_view.md)
- [1:1 채팅 및 리뷰](https://github.com/ssuktteok/daangnmungcat/blob/master/documents/chat_review_view.md)
- [쇼핑몰 상품 및 장바구니](https://github.com/ssuktteok/daangnmungcat/blob/master/documents/mall_pdt_cart_view.md)
- [쇼핑몰 주문](https://github.com/ssuktteok/daangnmungcat/blob/master/documents/order_view.md)
- [마일리지 및 공지사항](https://github.com/ssuktteok/daangnmungcat/blob/master/documents/mileage_notice_view.md)

----
<br>

# 쇼핑몰 상품 View

## 상품

<img src="https://user-images.githubusercontent.com/75772990/114679656-563cdc00-9d47-11eb-8a0c-8b021d5eebcd.png" width="600px">

<br><br>

## 카테고리

<img src="https://user-images.githubusercontent.com/75772990/114680552-47a2f480-9d48-11eb-9c20-e1311941a8cc.png" width="400px">

<br><br>

## 상품 관리

<img src="https://user-images.githubusercontent.com/75772990/114680631-58536a80-9d48-11eb-82d3-29ea38f16beb.png" width="600px">

<br>
<br>

<img src="https://user-images.githubusercontent.com/75772990/114681687-5a69f900-9d49-11eb-89f2-550120126b7d.png" width="400px">

<br><br>

## 장바구니

<img src="https://user-images.githubusercontent.com/75772990/114674691-76b66780-9d42-11eb-9416-e783b8d95f6a.png" width="600px">

<br>

비회원이 장바구니를 담으면 basket_id가 쿠키로 발급 됨. (보관 기간: 7일)  
basket_id가 존재할 때 로그인 시 비회원 장바구니가 해당 회원의 장바구니에 더해짐.

유료배송 상품은 부피가 큰 상품에 붙는 개별 배송이 필요한 것으로 가정했기 때문에  
무료+조건부 무료배송 / 유료배송 상품끼리 따로 배송비를 계산해 산출함.