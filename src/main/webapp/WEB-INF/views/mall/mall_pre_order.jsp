<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/resources/include/header.jsp" %>

<script>
$(document).ready(function(){
	var contextPath = "<%=request.getContextPath()%>";
 	
});
</script>

총금액: ${total} <br>
수량 : ${qtt} <br> 
정보: ${pdt } <br>

<c:if test="${list ne null}">
	<c:forEach var="cart" items="${list }">
		{cart.id} {cart.product.id} {cart.product.price} {cart.quantity}
	</c:forEach>
</c:if>
<jsp:include page="/resources/include/footer.jsp"/>
	