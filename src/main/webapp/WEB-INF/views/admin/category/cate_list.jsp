<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>

<script>
$(function(){
	$(".mall_cate_list .delete_btn").click(function(){
		if (confirm("정말 삭제하시겠습니까??") == true){
		} else{
		    return false;
		}
	})
	
})
</script>


<div class="card shadow mb-4">
	<div class="card-header py-2">
		<h6 class=" font-weight-bold text-primary" style="font-size: 1.3em;">
			<div class="mt-2 float-left">카테고리 리스트</div>
			<button id="addNew" class="btn btn-success btn-sm" onclick="location.href='/admin/category/write' " style="float: right;">카테고리 추가</button>
		</h6>
	</div>
	<!-- card-body -->
	<div class="card-body">
		<div class="mall_cate_list">
			<p class="tit">강아지</p>
			<table class="adm_table_style1">
				<colgroup>
					<col width="">
					<col width="10%">
				</colgroup>
				<thead>
					<tr>
						<th>분류명</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${dogCate}" var="list">
					<tr>
						<td>${list.name}</td>
						<td>
							<a href="<%=request.getContextPath()%>/admin/category/update?cateName=멍&id=${list.id}">수정</a>
						<a href="<%=request.getContextPath()%>/admin/category/delete?cateName=멍&id=${list.id}" class="delete_btn">삭제</a>
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<br>
			
			<p class="tit">고양이</p>
			<table class="adm_table_style1">
				<colgroup>
					<col width="">
					<col width="10%">
				</colgroup>
				<thead>
					<tr>
						<th>분류명</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${catCate}" var="list">
					<tr>
						<td>${list.name}</td>
						<td>
							<a href="<%=request.getContextPath()%>/admin/category/update?cateName=냥&id=${list.id}">수정</a>
						<a href="<%=request.getContextPath()%>/admin/category/delete?cateName=냥&id=${list.id}" class="delete_btn">삭제</a>
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			
		</div>
	</div>
</div>

<%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>