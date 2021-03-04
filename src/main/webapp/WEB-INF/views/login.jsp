<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<style>
.login-wrapper {text-align:center; padding:50px;}
</style>
<script>

</script>
<form method="post" action="/doLogin">
	<div class="login-wrapper">
		<c:if test="${loginFailMsg ne null }">
			<p style="color:red; font-weight:bold;"> ${loginFailMsg }</p>
		</c:if>
		
		<spring:message code="memmsg.a"/>

		<div class="id">
			<label for="id">id</label>
			<input type="text" name="id">
		</div>
		<div class="pw">
			<label for="password">pw</label>
			<input type="password" name="password">
		</div>
		<div class="btn">
			<input type="submit" value="로그인">
		</div>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</div>
</form>


<%@ include file="/WEB-INF/views/include/footer.jsp" %>