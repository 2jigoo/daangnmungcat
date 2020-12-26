<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복체크</title>
<script src="<c:url value="/resources/js/jquery-1.12.4.min.js" />" type="text/javascript" ></script>
<script>

function re_check() {
	var reid = $('#re_id').val();
	var url = new URL(window.location.href);
	var id = url.searchParams.get("id");
	var pathname = url.pathname; // /daangnmungcat/idCheck
	$.get(pathname+"/"+reid, function(json){
		console.log(json);
		window.location.href = pathname + "?id=" + reid + "&status=" + json;
	});
	
}

function confirm(){
	var url = new URL(window.location.href);
	var id = url.searchParams.get("id");
	opener.document.getElementById('id_confirm').value = id;
	opener.document.getElementById('id').value = id;
	this.close();	
}


</script>
</head>
<body>
    <div style="margin-top: 20px">  
  	<% String status = request.getParameter("status"); %>
  	<% if(status.equals("1")){ %>
  		이미 사용중인 아이디입니다.
  		<input type="text" id="re_id">
  		<input type="button" value="중복확인" onclick="re_check()">
  	<% } else { %>
  		사용가능한 아이디입니다.
  		<input type="button" value="확인" onclick="confirm()">
  	<% }%>
  	
    </div>
    
</body>
</html>