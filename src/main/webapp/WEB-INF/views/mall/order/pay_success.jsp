<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>

<script>
$(document).ready(function(){

});
</script>

${info}<br>

카카오페이 결제가 정상적으로 완료되었습니다.

<table>
	<tr>
		<td>결제 수단</td>
		<td>${info.payment_method_type}</td>
	</tr>
	<tr>
		<td>주문번호</td>
		<td>${info.partner_order_id}</td>
	</tr>
	<tr>
		<td>주문일자</td>
		<td>${info.approved_at}</td>
	</tr>
	<tr>
		<td>주문상품</td>
		<td>${info.item_name}</td>
	</tr>
	<tr>
		<td>주문자</td>
		<td>${info.partner_user_id}</td>
	</tr>
	<tr>
		<td>사용 및 적립</td>
		<td>
			사용한 마일리지: ${info.used_mileage}<br>
			적립된 마일리지: ${info.plus_mileage}<br>
		</td>
	</tr>
	<tr>
		<td>총 결제금액</td>
		<td>${info.amount.total}</td>
	</tr>
	
</table>
 

<jsp:include page="/resources/include/footer.jsp"/>
	