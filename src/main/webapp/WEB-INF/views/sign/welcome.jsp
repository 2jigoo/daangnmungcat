<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>
<style>
.wrapper {width:800px; margin:0 auto; text-align:center; padding:50px}
</style>
<div class="wrapper">
회원가입이 완료되었습니다.
	<div>
 	 	<input type="button" class="button" value="메인으로" onclick="location.href='/daangnmungcat/'"> 
 	 	<input type="button" class="button" value="로그인" onclick="location.href='/daangnmungcat/login'"> 
	</div>
</div>
<jsp:include page="/resources/include/footer.jsp"/>