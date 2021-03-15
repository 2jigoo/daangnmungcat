<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
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
					<div class="img">
						<c:if test="${empty list.image1}">
						<img src="<%=request.getContextPath() %>/resources/images/no_image.jpg">
						</c:if>
						<c:if test="${not empty list.image1}">
						<img src="<c:url value="/resources${list.image1}" />">
						</c:if>
					</div>
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
		<div class="board_page">
		    <c:if test="${pageMaker.prev}">
		    	<c:choose>
		    	<c:when test="${not empty cateId}">
			    	<p><a href="<%=request.getContextPath()%>/mall/product/list/${kind}/${cateId}${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></p>
		    	</c:when>
		    	<c:otherwise>
		    		<p><a href="<%=request.getContextPath()%>/mall/product/list/${kind}${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></p>
		    	</c:otherwise>
		    	</c:choose>
		    </c:if> 
			<ul>
			
			  <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
		    	<c:choose>
		    	<c:when test="${not empty cateId}">
				  	<li><a href="<%=request.getContextPath()%>/mall/product/list/${kind}/${cateId}${pageMaker.makeQuery(idx)}">${idx}</a></li>
		    	</c:when>
		    	<c:otherwise>
				  	<li><a href="<%=request.getContextPath()%>/mall/product/list/${kind}${pageMaker.makeQuery(idx)}">${idx}</a></li>
			  	</c:otherwise>
			  	</c:choose>
			  </c:forEach>
			</ul>
			
			  <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
		    	<c:choose>
		    	<c:when test="${not empty cateId}">
				    <p><a href="<%=request.getContextPath()%>/mall/product/list/${kind}/${cateId}${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></p>
		    	</c:when>
		    	<c:otherwise>
				    <p><a href="<%=request.getContextPath()%>/mall/product/list/${kind}${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></p>
			    </c:otherwise>
			    </c:choose>
			  </c:if> 
		</div>
</div>


<%@ include file="/WEB-INF/views/include/footer.jsp" %>