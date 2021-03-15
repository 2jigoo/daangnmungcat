<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<script>
$(document).ready(function(){
	
});

</script>

<table style="width:70%; margin:0 auto; ">
	<tr>
		<td>결제 고유 번호</td>
		<td>${info.tid}</td>
	</tr>
	<tr>
		<td>가맹점 코드</td>
		<td>${info.cid}</td>
	</tr>
	<tr>
		<td>결제 상태</td>
		<td>${info.status}</td>
	</tr>
	<tr>
		<td>주문번호</td>
		<td>${info.partner_order_id}</td>
	</tr>
	<tr>
		<td>주문자</td>
		<td>${info.partner_user_id}</td>
	</tr>
	<tr>
		<td>결제 수단</td>
		<td>${info.payment_method_type}</td>
	</tr>
	<tr>
		<td>결제 금액</td>
		<td>${info.amount}</td>
	</tr>
	<tr>
		<td>취소된 금액</td>
		<td>${info.canceled_amount}</td>
	</tr>
	<tr>
		<td>남은 취소 가능 금액</td>
		<td> ${info.cancel_available_amount.total}</td>
	</tr>
	
	<tr>
		<td>상품 이름</td>
		<td>${info.item_name}</td>
	</tr>
	<tr>
		<td>상품 수량</td>
		<td>${info.quantity}</td>
	</tr>
	<tr>
		<td>결제 승인 시각</td>
		<td>${info.approved_at}</td>
	</tr>
	<tr>
		<td>결제 취소 시각</td>
		<td>${info.canceled_at}</td>
	</tr>
	<tr>
		<td>결제/취소 상세</td>
		<td>${info.payment_action_details}</td>
	</tr>
	
	
	
</table>


<%@ include file="/WEB-INF/views/include/footer.jsp" %>