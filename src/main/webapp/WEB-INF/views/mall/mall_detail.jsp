<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>
<style>
.wrapper {padding:50px;}
.detail_img {}
.detail_info {}
</style>
<script>
$(function(){
	var contextPath = "<%=request.getContextPath()%>";
});
</script>
<div class="wrapper">
	
	<div class="detail_img">
		<c:if test="${empty list.image1}">
			<img
				src="<%=request.getContextPath()%>/resources/images/no_image.jpg" style="height:22vw">
		</c:if>
		<c:if test="${not empty list.image1}">
			<img src="<c:url value="/resources${list.image1}" />">
		</c:if>
	</div>
	<div class="detail_info">
		<div>${pdt.name}</div>
		<div>가격: ${pdt.price}</div>
		<div>배송비: ${pdt.deliveryPrice}</div>
		<div>배송종류: ${pdt.deliveryKind} / ${pdt.deliveryCondition}원 이상</div>
		<div></div>
	</div>


</div>
<jsp:include page="/resources/include/footer.jsp"/>