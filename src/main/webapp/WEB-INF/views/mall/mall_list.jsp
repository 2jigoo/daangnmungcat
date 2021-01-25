<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>
<script>
$(function(){
	var contextPath = "<%=request.getContextPath()%>";
});
</script>
<div id="subContent">
	<h2 id="subTitle">${name}</h2>
<div>
			<ul class="product_list s-inner">
				<c:forEach items="${list}" var="list">
				<li><a href="<%=request.getContextPath()%>/mall/product/${list.id}">
					<div class="img"><img src="<c:url value="${list.image1}" />"></div>
					<div class="txt">
						<p class="subject">${list.name}</p>
						<p class="price">${list.price}</p>
						<ul>
							<li class="">${list.deliveryKind}</li>
						</ul>
					</div>
				</a></li>
				</c:forEach>
				<c:if test="${empty list}">
					<li class="no_date">등록된 글이 없습니다.</li>
				</c:if>
			</ul>
		</div>
</div>


<jsp:include page="/resources/include/footer.jsp"/>