<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header.jsp" %>


<div id="mVisual">
	<div class="img_box"></div>
</div>

<div class="mProduct">
	<p class="tit">중고</p>
	<ul class="product_list s-inner">
		<c:forEach items="${saleList }" var="saleList" end="7">
		<li><a href="<%=request.getContextPath()%>/joongoSale/detailList?id=${saleList.id}">
			<div class="img">
		 		<c:if test="${empty saleList.thumImg}">
					<img src="<%=request.getContextPath()%>/resources/images/no_image.jpg"></div>
				</c:if>
				<c:if test="${not empty saleList.thumImg}">
					<img src="<%=request.getContextPath() %>/resources/${saleList.thumImg}"></div>
				</c:if>
			<div class="txt">
				<p class="location">${saleList.dongne1.name} ${saleList.dongne2.name} · <span class="regdate" regdate="${saleList.regdate}"><javatime:format value="${saleList.regdate }"  pattern="yyyy-MM-dd HH:mm:ss"/></span></p>
				<p class="subject">${saleList.title}</p>
				<p class="price">
					<span>${saleList.saleState.label}</span>
					<span>
						<c:if test="${saleList.price eq 0 }" >무료 나눔</c:if>
						<c:if test="${saleList.price ne 0 }"> ${saleList.price }원</c:if>
					</span>
				</p>
				<ul>
					<li class="heart">${saleList.heartCount}</li>
					<li class="chat">${saleList.chatCount}</li>
				</ul>	
			</div>
		</a></li>
			<c:if test="${empty saleList}">
				<li class="no_date">등록된 글이 없습니다.</li>
			</c:if>
		</c:forEach>
	</ul>
</div>

<div class="mProduct bg01">
	<p class="tit">멍</p>
	<ul class="product_list s-inner">
		<c:forEach items="${dogList }" var="dogList" >
		<li><a
			href="<%=request.getContextPath()%>/mall/product/${dogList.id}">
				<div class="img">
					<c:if test="${empty dogList.image1}">
						<img
							src="<%=request.getContextPath()%>/resources/images/no_image.jpg">
					</c:if>
					<c:if test="${not empty dogList.image1}">
						<img src="<c:url value="/resources${dogList.image1}" />">
					</c:if>
				</div>
				<div class="txt">
					<p class="subject">${dogList.name}</p>
					<p class="price">${dogList.price}</p>
					<ul>
						<li class="">${dogList.deliveryKind}</li>
					</ul>
				</div>
		</a></li>
		</c:forEach>
		<c:if test="${empty dogList}">
			<li class="no_date">등록된 글이 없습니다.</li>
		</c:if>
	</ul>
</div>

<div class="mProduct">
	<p class="tit">냥</p>
	<ul class="product_list s-inner">
		<c:forEach items="${catList }" var="catList" >
		<li><a
			href="<%=request.getContextPath()%>/mall/product/${catList.id}">
				<div class="img">
					<c:if test="${empty catList.image1}">
						<img
							src="<%=request.getContextPath()%>/resources/images/no_image.jpg">
					</c:if>
					<c:if test="${not empty catList.image1}">
						<img src="<c:url value="/resources${catList.image1}" />">
					</c:if>
				</div>
				<div class="txt">
					<p class="subject">${catList.name}</p>
					<p class="price">${catList.price}</p>
					<ul>
						<li class="">${catList.deliveryKind}</li>
					</ul>
				</div>
		</a></li>
		</c:forEach>
		<c:if test="${empty catList}">
			<li class="no_date">등록된 글이 없습니다.</li>
		</c:if>
	</ul>
</div>


<%@ include file="/WEB-INF/views/include/footer.jsp" %>