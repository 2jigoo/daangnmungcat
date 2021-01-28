<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
<script>
$(function(){
	var contextPath = "<%=request.getContextPath()%>";
	
	$(".delete_btn").click(function(){
		if (confirm("정말 삭제하시겠습니까??") == true){
		} else{
		    return false;
		}
	})
});
</script>

<div class="card shadow mb-4">
	<div class="card-header py-2">
		<h6 class=" font-weight-bold text-primary" style="font-size: 1.3em;">
			<div class="mt-2 float-left">중고 리스트</div>
		</h6>
	</div>
	<!-- card-body -->
	<div class="card-body">
		<table class="adm_table_style1">
			<colgroup>
				<col width="10%">
				<col width="29.5%">
				<col width="29.5%">
				<col width="11%">
				<col width="10%">
				<col width="10%">
			</colgroup>
			<thead>
				<tr>
					<th rowspan="2">이미지</th>
					<th>동네</th>
					<th>카테고리</th>
					<th>가격</th>
					<th rowspan="2">아이디</th>
					<th rowspan="2">관리</th>
				</tr>
				<tr>
					<th colspan="2">제목(상품명)</th>
					<th>판매상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="list">
				<tr>
					<td rowspan="2">
						<c:if test="${empty list.thumImg}">
						<img src="<%=request.getContextPath() %>/resources/images/no_image.jpg">
						</c:if>
						<c:if test="${not empty list.thumImg}">
						<img src="<%=request.getContextPath() %>/resources/${list.thumImg}">
						</c:if>
					</td>
					<td>${list.dongne1.name} ${list.dongne2.name}</td>
					<td>
						<c:if test="${list.dogCate eq 'y'}">
							멍&nbsp;
						</c:if>
						<c:if test="${list.catCate eq 'y'}">
							냥 
						</c:if>
					</td>
					<td class="tc"><fmt:formatNumber value="${list.price}"/> 원</td>
					<td rowspan="2"  class="tc">${list.member.id}</td>
					<td rowspan="2">
						<a href="/joongoSale/detailList?id=${list.id}">보기</a>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						${list.title}
						<ul class="adm_joongo_ico">
							<li class="heart">${list.heartCount}</li>
							<li class="chat">${list.chatCount}</li>
						</ul>
					</td>
					<td class="tc">${list.saleState.label }</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<div class="board_page">
		    <c:if test="${pageMaker.prev}">
		    	<c:choose>
		    		<c:when test="${not empty dongne2Name}">
		    			<p><a href="/admin/joongo/list/${dongne1Name}/${dongne2Name}${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></p>
		    		</c:when>
		    		<c:when test="${not empty dongne1Name}">
		    			<p><a href="/admin/joongo/list/${dongne1Name}${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></p>
		    		</c:when>
		    		<c:otherwise>
				    	<p><a href="/admin/joongo/list${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></p>
		    		</c:otherwise>
		    	</c:choose>
		    </c:if> 
			<ul>
			
			  <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
			   <c:choose>
			  		<c:when test="${not empty dongne2Name}">
			  			<li><a href="/admin/joongo/list/${dongne1Name}/${dongne2Name}${pageMaker.makeQuery(idx)}">${idx}</a></li>
			  		</c:when>
			  		<c:when test="${not empty dongne1Name}">
			  			<li><a href="/admin/joongo/list/${dongne1Name}${pageMaker.makeQuery(idx)}">${idx}</a></li>
			  		</c:when>
			  		<c:otherwise>
			    	<li><a href="/admin/joongo/list${pageMaker.makeQuery(idx)}">${idx}</a></li>
			  		</c:otherwise>
			 		</c:choose>
			  </c:forEach>
			</ul>
			
			  <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
			   <c:choose>
			  		<c:when test="${not empty dongne2Name}">
			  			<p><a href="/admin/joongo/list/${dongne1Name}/${dongne2Name}${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></p>
			  		</c:when>
			  		<c:when test="${not empty dongne1Name}">
			  			<p><a href="/admin/joongo/list/${dongne1Name}${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></p>
			  		</c:when>
			  		<c:otherwise>
			    		<p><a href="/admin/joongo/list${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></p>
			  		</c:otherwise>
			 		</c:choose>
			  </c:if> 
		</div>
	</div>
</div>


<%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>