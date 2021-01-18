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
		<td><a href="<c:url value="/memberUpdate" />">회원정보 변경</a></td> <td>내 채팅목록</td> <td>주문내역</td> <td>내 게시물</td>
	</tr>
	<tr>
		<td>회원탈퇴</td> <td>내 판매글</td> <td>마일리지</td> <td>내 댓글</td>
	</tr>
	<tr>
		<td>배송지 관리</td> <td>거래후기</td> <td>상품 후기</td> <td></td>
	</tr>
	<tr>
		<td>고객센터</td> <td>찜리스트</td> <td>찜리스트</td> <td></td>
	</tr>
</table>

</div>
<jsp:include page="/resources/include/footer.jsp"/>