<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<script>
	function validate() {
	    if (document.loginForm.id.value == "" && document.loginForm.password.value == "") {
	        alert("아이디와 비밀번호를 입력해주세요");
	        document.loginForm.id.focus();
	        return false;
	    }
	    if (document.loginForm.id.value == "") {
	        alert("아이디를 입력해주세요");
	        document.loginForm.id.focus();
	        return false;
	    }
	    if (document.loginForm.password.value == "") {
			alert("비밀번호를 입력해주세요");
			document.loginForm.password.focus();
	        return false;
	    }
	}
</script>
<div id="subContent">
	<div id="pageCont" class="s-inner">
		<h2 id="subTitle">로그인</h2>
		<div class="login-wrapper">
			<form name="loginForm" method="post" action="/doLogin">
				<input class="input_row" type="text" name="id" placeholder="아이디" required>
				<input class="input_row" type="password" name="password" placeholder="비밀번호" required>
				<c:if test="${sessionScope['SPRING_SECURITY_LAST_EXCEPTION'] ne null}">
					${sessionScope['SPRING_SECURITY_LAST_EXCEPTION'] }
					<p class="login_fail_msg">${sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].message}</p>
					<c:remove var="SPRING_SECURITY_LAST_EXCEPTION" scope="session"/>
				</c:if>
				<input class="login_btn" type="submit" value="로그인" onclick="validate()">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			</form>
			<div class="link_row">
				<a class="link_items" href="">아이디 찾기</a><span class="bar" aria-hidden="true"></span><a class="link_items" href="">비밀번호 찾기</a><span class="bar" aria-hidden="true"></span><a class="link_items" href="/sign/contract">회원가입</a>
			</div>
		</div>
	</div>
</div>


<%@ include file="/WEB-INF/views/include/footer.jsp" %>