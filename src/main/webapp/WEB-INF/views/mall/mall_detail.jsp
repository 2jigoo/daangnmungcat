<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>
<script>
$(function(){
	var contextPath = "<%=request.getContextPath()%>";
});
</script>

${pdt}

<jsp:include page="/resources/include/footer.jsp"/>