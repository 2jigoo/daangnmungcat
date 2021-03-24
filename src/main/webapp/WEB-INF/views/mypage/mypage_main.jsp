<%@page import="daangnmungcat.dto.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
.wrapper {margin:0 auto; padding:70px; text-align:center}
.grade_div {width:100%; background-color:#f7f7f7; padding:60px; margin-top:30px;}
.mypage_grade {float:left;  margin-top:-10px;}
.mypage_mile {float:right; text-align:center; padding:30px; margin-top:-65px; font-size:14px;}
.mypage_num {font-size:20px; color:#ff7e15; font-weight:bold}
</style>
<script>
$(document).ready(function(){
});
</script>
<div id="subContent">
	<h2 id="subTitle">마이페이지</h2>
	<div id="pageCont" class="s-inner">
		<div class="mypage_main">
			<dl>
				<dt>회원정보</dt>
				<dd><a href="<c:url value="/mypage/pwd_confirm" />">회원정보 변경</a></dd>
				<dd><a href="<c:url value="/mypage/mypage_pwd" />">비밀번호 변경</a></dd>
				<dd><a href="<c:url value="/mypage/shipping_main" />">배송지 관리</a></dd>
				<dd><a href="<c:url value="/mypage/mypage_withdraw" />">회원 탈퇴</a></dd>
			</dl>
			<dl>
				<dt>거래정보</dt>
				<dd>내 채팅목록</dd>
				<dd><a href="/mypage/joongo/list?memId=${loginUser.id}">내 판매글</a></dd>
				<dd><a href="/mypage/joongo/comment?memId=${loginUser.id}">내 댓글</a></dd>
				<dd><a href="<c:url value="/mypage/joongo/heart/list"/>">찜 목록</a></dd>
				<dd><a href="/mypage/joongo/review/list?memId=${loginUser.id}">거래후기</a></dd>
			</dl>
			<dl>
				<dt>쇼핑정보</dt>
				<dd><a href="<c:url value="/mall/cart/list"/>">장바구니</a></dd>
				<dd><a href="<c:url value="/mypage/mypage_order_list" />">주문내역</a></dd>
				<dd><a href="<c:url value="/mypage/mypage_order_cancel_list" />">취소/환불내역</a></dd>
				<dd>상품 후기</dd>
				<dd>찜리스트</dd>
			</dl>
			<dl>
				<dt>커뮤니티</dt>
				<dd>내 게시물</dd>
				<dd>내 댓글</dd>
				<dd>마일리지</dd>
			</dl>
		</div>

	<div class="grade_div">
		<span class="mypage_grade"><span style="color:#ff7e15;font-weight:bold">${member.name}</span>
			님 회원등급은 <span style="font-weight:bold">${grade}</span> 입니다. </span>
		<span class="mypage_mile">
			마일리지 <br><br>
			<span class="mypage_num"><fmt:formatNumber value="${mile}"/></span>
		</span>
		<span class="mypage_mile">
			중고거래 <br><br>
			<a class="mypage_num" href="/mypage/joongo/list?memId=${loginUser.getId()}">${saleCnt}</a>
		</span>
	</div>
	
	
	</div>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>