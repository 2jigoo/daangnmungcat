<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ include file="/WEB-INF/views/include/header.jsp" %>
<script type="text/javascript">

//메시지 전달
$(document).ready(function(){
	
var message = '${msg}';
var returnUrl = '${url}'; 
alert(message);
document.location.href = returnUrl; 
});
</script>
<body></body>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>