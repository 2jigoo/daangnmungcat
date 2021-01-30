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
			<div class="mt-2 float-left">댓글 리스트</div>
		</h6>
	</div>
	<!-- card-body -->
	<div class="card-body">
		<table class="adm_table_style1">
			<colgroup>
				<col width="80%">
				<col width="10%">
				<col width="10%">
			</colgroup>
			<thead>
				<tr>
					<th>댓글</th>
					<th>아이디</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="list">
				<tr>
					<td>${list.content}</td>
					<td class="tc">${list.member.id}</td>
					<td>
						<a href="/joongoSale/detailList?id=${list.sale.id}">보기</a>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<div class="board_page">
		    <c:if test="${pageMaker.prev}">
		    	<p><a href="<%=request.getContextPath()%>/admin/comment/list${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></p>
		    </c:if> 
			<ul>
			
			  <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
			  	<li><a href="<%=request.getContextPath()%>/admin/comment/list${pageMaker.makeQuery(idx)}">${idx}</a></li>
			  </c:forEach>
			</ul>
			
			  <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
			    <p><a href="<%=request.getContextPath()%>/admin/comment/list${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></p>
			  </c:if> 
		</div>
		
		
	</div>
</div>


<%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>