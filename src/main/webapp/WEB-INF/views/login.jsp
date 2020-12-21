<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/resources/include/header.jsp" %>
<style>
.login-wrapper {text-align:center; padding:50px;}
</style>


<form method="post" action="login">
<div class="login-wrapper">
	<div class="id">
		<label>id</label>
		<input type="text" name="id">
	</div>
	<div class="pw">
		<label>pw</label>
		<input type="password" name="pwd">
	</div>
	<div class="btn">
		<input type="submit" value="로그인">
	</div>
	<!-- csrf 토큰 hidden -->
	csrf 토큰<br>
	<input type="text" name="${_csrf.parameterName}" value="${_csrf.token}" />
</div>

</form>




<jsp:include page="/resources/include/footer.jsp"/>