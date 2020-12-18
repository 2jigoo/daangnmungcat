<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	console.log(${path})
</script>
</head>
<body>
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
</body>
</html>