<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ include file="/resources/include/header.jsp" %>


<script type="text/javascript">
	console.log(${path})
</script>
<form method="post" action="login">
login <br>
<label>id</label>
<input type="text" name="id">
<label>pw</label>
<input type="password" name="pwd">
<input type="submit" value="로그인">
<!-- csrf 토큰 hidden -->
<br>
csrf 토큰<br>
<input type="text" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>




<jsp:include page="/resources/include/footer.jsp"/>