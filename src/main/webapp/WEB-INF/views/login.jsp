<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/resources/include/header.jsp" %>



<form method="post" action="login">
	<div class="input">
		<label>id</label>
		<input type="text" name="id">
	</div>
	<div class="input">
		<label>pw</label>
		<input type="password" name="pwd">
	</div>
	<div class="btn">
		<input type="submit" value="로그인">
	</div>
	<!-- csrf 토큰 hidden -->
	csrf 토큰<br>
	<input type="text" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>




<jsp:include page="/resources/include/footer.jsp"/>