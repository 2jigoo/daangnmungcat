<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
<script>
$(function(){
	
});
</script>

<div class="card shadow mb-4">
	<div class="card-header py-2">
		<h6 class=" font-weight-bold text-primary" style="font-size: 1.3em;">
			<div class="mt-2 float-left">마일리지 리스트</div>
			<button id="addNew" class="btn btn-success btn-sm" onclick="location.href='/admin/mileage/write' " style="float: right;">마일리지 등록</button>
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
				<col width="5%">
				<col width="7%">
				<col width="20%">
				<col width="15%">
				<col width="30%">
				<col width="12%">
				<col width="10%">
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>주문 번호</th>
					<th>회원 아이디</th>
					<th>금액</th>
					<th>적립 내용</th>
					<th>등록일</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="list">
				<tr>
					<td>${list.id }</td>
					<td>${list.order.id}</td>
					<td>${list.member.id}</td>
					<td>${list.mileage}</td>
					<td>${list.content}</td>
					<td>${list.regDate}</td>
					<td>
						<a href="<%=request.getContextPath() %>/admin/mileage/update?id=${list.id}">수정</a>
						<a href="<%=request.getContextPath() %>/admin/mileage/delete?id=${list.id}">삭제</a>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<div class="board_page">
		    <c:if test="${pageMaker.prev}">
		    	<p><a href="<%=request.getContextPath()%>/admin/mileage/list${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></p>
		    </c:if> 
			<ul>
			
			  <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
			  	<li><a href="<%=request.getContextPath()%>/admin/mileage/list${pageMaker.makeQuery(idx)}">${idx}</a></li>
			  </c:forEach>
			</ul>
			
			  <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
			    <p><a href="<%=request.getContextPath()%>/admin/mileage/list${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></p>
			  </c:if> 
		</div>
	</div>
</div>


<%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>