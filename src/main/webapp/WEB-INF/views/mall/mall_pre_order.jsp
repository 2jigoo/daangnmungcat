<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>

<script>
$(document).ready(function(){
	var contextPath = "<%=request.getContextPath()%>";
 	
});
</script>

총금액: ${total} <br>
수량 : ${qtt} <br> 
정보: ${pdt } <br>
<jsp:include page="/resources/include/footer.jsp"/>
	