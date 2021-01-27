<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>
<script>
$(function(){
	var contextPath = "<%=request.getContextPath()%>";
});
</script>

<div id="subContent">
	<div id="pageCont" class="s-inner">
		<div class="product_detail">
			<div class="detail_info">
				<div class="img_box">
					<c:if test="${empty pdt.image1}"><img src="<%=request.getContextPath() %>/resources/images/no_image.jpg"></c:if>
					<c:if test="${not empty pdt.image1}"><img src="<c:url value="/resources${pdt.image1}" />"></c:if>
				</div>
				<div class="txt_box">
					<p class="name">${pdt.name}</p>
					<p class="content">${pdt.content}</p>
					<dl>
						<dt>가격</dt>
						<dd><fmt:formatNumber value="${pdt.price}"/>원</dd>
						<dt>배송비 유형</dt>
						<dd>
							${pdt.deliveryKind}
							<c:if test="${pdt.deliveryKind eq '조건부 무료배송'}">
							<br><fmt:formatNumber value="${pdt.deliveryPrice}"/>원(<fmt:formatNumber value="${pdt.deliveryCondition}"/>원 이상 구매 시 무료배송)
							</c:if>
							<c:if test="${pdt.deliveryKind eq '유료배송'}">
							<br><fmt:formatNumber value="${pdt.deliveryPrice}"/>원
							</c:if>
						</dd>
					</dl>
					<div class="length">
						<p>수량</p>
						<div>
							<p class="down"><span class="text_hidden">감소</span></p>
							<input type="text" value="1">
							<p class="up"><span class="text_hidden">증가</span></p>
						</div>
					</div>
					<div class="totalPrice">
						<p>총 금액</p>
						<p><span><fmt:formatNumber value="${pdt.price}"/></span> 원</p>
					</div>
					<ul class="btn">
						<li><a href="#">장바구니</a></li>
						<li><a href="#">바로구매</a></li>
					</ul>
				</div>
			</div>
			<div class="detail_view">
				<c:if test="${not empty pdt.image2}"><img src="<c:url value="/resources${pdt.image2}" />"></c:if>
				<c:if test="${not empty pdt.image3}"><img src="<c:url value="/resources${pdt.image3}" />"></c:if>
			</div>
		</div>
	</div>
</div>


<jsp:include page="/resources/include/footer.jsp"/>