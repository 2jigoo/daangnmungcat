<%@page import="daangnmungcat.dto.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>
<style>
.wrapper {margin:0 auto; padding:50px; text-align:center}
#mypage_table { width:800px; margin:0 auto; padding:20px}
#mypage_table tr:first-child th {font-weight:bold; height:50px;}
</style>
<script>
$(document).ready(function(){
});
</script>
<div class="wrapper">
	<h2 id="subTitle">마이페이지</h2>
<table id="mypage_table">
	<tr>
		<th>회원정보</th> <th>거래정보</th> <th>쇼핑정보</th> <th>커뮤니티</th>
	</tr>
	<tr>
		<td><a href="<c:url value="/mypage/pwd_confirm" />">회원정보 변경</a></td> <td>내 채팅목록</td> <td><a href="<c:url value="/mall/cart/list"/>">장바구니</a></td> <td>내 게시물</td>
	</tr>
	<tr>
		<td><a href="<c:url value="/mypage/mypage_pwd" />">비밀번호 변경</a></td> <td>내 판매글</td> <td><a href="<c:url value="/mypage/order_list" />">주문내역</a></td> <td>내 댓글</td>
	</tr>
	<tr>
		<td><a href="<c:url value="/mypage/shipping_main" />">배송지 관리</a></td> <td>내 댓글</td> <td>상품 후기</td> <td></td>
	</tr>
	<tr>
		<td><a href="<c:url value="/mypage/mypage_withdraw" />">회원 탈퇴</a></td> <td><a href="<c:url value="/joongo/heart/list"/>">찜 목록</a></td> <td>찜리스트</td> <td></td>
	</tr>
	<tr>
		<td></td> <td>거래후기</td> <td>마일리지</td> <td></td>
	</tr>

</table>
회원 등급 : ${loginUser.getGrade()}

</div>
<jsp:include page="/resources/include/footer.jsp"/>