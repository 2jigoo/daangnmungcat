<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
<script>
$(function(){
	
	$(".delete_btn").click(function(){
		if (confirm("정말 삭제하시겠습니까??") == true){
		} else{
		    return false;
		}
	})
	
	$("#searchBtn").click(function(){
		if ($("select[name='where']").val() == ""){
			alert("검색 기준을 선택해주세요.")
			return false;
		} else if ($("input[name='query']").val() == ""){
			alert("검색 내용을 입력해주세요.")
			return false;
		} else {
			window.location = "/admin/product/list?"+$("select[name='where']").val()+"="+$("input[name='query']").val()+"";
		}
	})
});
</script>

<div class="card shadow mb-4">
	<div class="card-header py-2">
		<h6 class=" font-weight-bold text-primary" style="font-size: 1.3em;">
			<div class="mt-2 float-left">상품 리스트</div>
			<button id="addNew" class="btn btn-success btn-sm" onclick="location.href='/admin/product/write' " style="float: right;">상품 등록</button>
			<!-- <button id="deselectAll" class="btn btn-outline-secondary btn-sm" style="float: right;  margin-right: 10px;">선택해제</button>
			<button id="selectAll" class="btn btn-secondary btn-sm" style="float: right;  margin-right: 10px;">전체선택</button>
           	<button id="deleteSelected"class="btn btn-danger btn-sm" style="float: right; margin-right: 10px;">예약 취소</button> -->
		</h6>
	</div>
	<!-- card-body -->
	<div class="card-body">
		<div class="col-sm-12 col-md-6 p-0">
			<div>
				<select class="custom-select custom-select-sm" name="where" style="width: 80px;">
					<option value="">기준</option>
					<option value="name">상품명</option>
					<option value="category">카테고리</option>
					<option value="saleYn">판매상태</option>
				</select>
				<label>
					<input type="search" class="form-control form-control-sm" name="query">
				</label>
				<input type="submit" class="btn btn-primary btn-sm" value="검색" id="searchBtn"></input>
			</div>
		</div>
	
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
					<th>멍</th>
					<th>냥</th>
					<th>가격</th>
					<th rowspan="2">판매중</th>
					<th rowspan="2">관리</th>
				</tr>
				<tr>
					<th colspan="2">상품명</th>
					<th>재고</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="list">
				<tr>
					<td rowspan="2">
						<c:if test="${empty list.image1}">
						<img src="<%=request.getContextPath() %>/resources/images/no_image.jpg">
						</c:if>
						<c:if test="${not empty list.image1}">
						<img src="<c:url value="/resources${list.image1}" />">
						</c:if>
					</td>
					<td>${list.dogCate.name}</td>
					<td>${list.catCate.name}</td>
					<td class="tc"><fmt:formatNumber value="${list.price}" /> 원</td>
					<td rowspan="2"  class="tc">${list.saleYn}</td>
					<td rowspan="2">
						<a href="<%=request.getContextPath() %>/admin/product/update?id=${list.id}">수정</a>
						<a href="<%=request.getContextPath() %>/admin/product/delete?id=${list.id}" class="delete_btn">삭제</a>
						<a href="<%=request.getContextPath() %>/mall/product/${list.id}">보기</a>
					</td>
				</tr>
				<tr>
					<td colspan="2">${list.name}</td>
					<td class="tc"><fmt:formatNumber value="${list.stock}" /> 개</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<div class="board_page">
		    <c:if test="${pageMaker.prev}">
		    	<p><a href="<%=request.getContextPath()%>/admin/product/list${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></p>
		    </c:if> 
			<ul>
			
			  <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
			  	<li><a href="<%=request.getContextPath()%>/admin/product/list${pageMaker.makeQuery(idx)}">${idx}</a></li>
			  </c:forEach>
			</ul>
			
			  <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
			    <p><a href="<%=request.getContextPath()%>/admin/product/list${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></p>
			  </c:if> 
		</div>
	</div>
</div>


<%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>