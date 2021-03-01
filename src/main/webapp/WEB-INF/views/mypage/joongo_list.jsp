<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/resources/include/header.jsp" %>

<div id="subContent">
	<h2 id="subTitle">${loginUser.nickname}님의 중고 리스트</h2>
	<div id="pageCont" class="s-inner">
		<div class="list_top">
			<div>
				<c:if test="${not empty loginUser}">
					<a href="<%=request.getContextPath()%>/joongoSale/addList">글쓰기</a>
				</c:if>	
			</div>
		</div>
		<div>
			<ul class="product_list s-inner">
				<c:forEach items="${list}" var="list">
				<li><a href="<%=request.getContextPath()%>/joongoSale/detailList?id=${list.id}">
					<div class="img"><img src="<%=request.getContextPath() %>/resources/${list.thumImg}"></div>
					<div class="txt">
						<p class="location">${list.dongne1.name} ${list.dongne2.name}</p>
						<p class="subject">${list.title}</p>
						<p class="price">
							<span>${list.saleState.label}</span>
							<span>
								<c:if test="${list.price eq 0 }" >무료 나눔</c:if>
								<c:if test="${list.price ne 0 }"> ${list.price }원</c:if>
							</span>
						</p>
						<ul>
							<li class="heart">${list.heartCount}</li>
							<li class="chat">${list.chatCount}</li>
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
				<p><a href="/mypage/joongo/list${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></p>
		    </c:if> 
			<ul>
			
			  <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
			    <li><a href="/mypage/joongo/list${pageMaker.makeQuery(idx)}">${idx}</a></li>
			  </c:forEach>
			</ul>
			
			  <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
			    <p><a href=/mypage/joongo/list${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></p>
			  </c:if> 
		</div>
		
	</div>
</div>


<jsp:include page="/resources/include/footer.jsp"/>