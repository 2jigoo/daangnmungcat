<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
<script>
</script>

<div class="card shadow mb-4">
	<div class="card-header py-2">
		<h6 class=" font-weight-bold text-primary" style="font-size: 1.3em;">
			<div class="mt-2 float-left">주문 리스트</div>
			<button id="addNew" class="btn btn-success btn-sm" onclick="location.href='/admin/mileage/write' " style="float: right;">주문 등록</button>
		</h6>
	</div>
	<!-- card-body -->
	<div class="card-body">
		<div class="col-sm-12 col-md-6 p-0">
			<div>
				<select class="custom-select custom-select-sm" name="search" style="width: 80px;">
					<option value="">기준</option>
					<option value="content">적립 내용</option>
					<option value="member">회원 아이디</option>
					</select>
				<label>
					<input type="search" class="form-control form-control-sm" name="query">
				</label>
				<input type="submit" class="btn btn-primary btn-sm" value="검색" id="submitBtn"></input>
			</div>
		</div>
	
		<table class="adm_table_style1">
			<colgroup>
				<col width="5%">
				<col width="12%">
				<col width="10%">
				<col width="12%">
				<col width="10%">
				<col width="12%">
				<col width="10%">
				<col width="10%">
				<col width="15%">
				<col width="10%">
			</colgroup>
			<thead>
				<tr>
					<th rowspan="2">번호</th>
					<th>주문 번호</th>
					<th>주문자</th>
					<th>주문자전화</th>
					<th>받는 분</th>
					<th rowspan="2">결제합계<br>배송비포함</th>
					<th rowspan="2">주문취소</th>
					<th rowspan="2">사용한<br>마일리지</th>
					<th rowspan="2">주문일</th>
					<th rowspan="2">관리</th>
				</tr>
				<tr>
					<th>결제정보</th>
					<th>아이디</th>
					<th>상품 수</th>
					<th>누적주문수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="order" items="${list}" varStatus="status">
					
				<tr>
					<td rowspan="2">${pageMaker.totalCount - ((pageMaker.cri.page -1) * pageMaker.cri.perPageNum + status.index)}</td>
					<td>${order.id }</td>
					<td>${order.member.name}</td>
					<td>${order.member.phone}</td>
					<td>${order.addName}</td>
					<td rowspan="2">${order.finalPrice }</td>
					<td rowspan="2">${order.returnPrice}</td>
					<td rowspan="2">${order.usedMileage}</td>
					<td rowspan="2">
						<fmt:parseDate value="${order.payDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parseDate" type="both" />
	            		<fmt:formatDate pattern="yyyy-MM-dd" value="${parseDate}"/>
					</td>
					<td rowspan="2">
						<input type="button" value="보기">
					</td>
				</tr>
				<tr>
					<td><input type="button" value="결제정보"></td>
					<td>${order.member.id}</td>
					<td></td>
					<td></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>

		<div class="board_page">
		    <c:if test="${pageMaker.prev}">
		    	<p><a href="<%=request.getContextPath()%>/admin/order/list${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></p>
		    </c:if> 
			<ul>
			
			  <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
			  	<li><a href="<%=request.getContextPath()%>/admin/order/list${pageMaker.makeQuery(idx)}">${idx}</a></li>
			  </c:forEach>
			</ul>
			
			  <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
			    <p><a href="<%=request.getContextPath()%>/admin/order/list${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></p>
			  </c:if> 
		</div>
<%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>