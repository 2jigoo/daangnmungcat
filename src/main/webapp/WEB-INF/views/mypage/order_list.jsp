<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>

<script>
$(document).ready(function(){

});
</script>

<div>
	<table>
		<thead>
			<tr>
				<th>주문일/주문번호</th>
				<th>상품명/옵션</th>
				<th>수량</th>
				<th>상품금액</th>
				<th>주문상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="order" items="${list}">
				<tr>
					<td>${order.payDate}<br>
						${order.id}</td>
					<td>${order.details}</td>
					<td></td>
					<td>${finalPrice}</td>
					<td>${order.state}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

</div>
<jsp:include page="/resources/include/footer.jsp"/>