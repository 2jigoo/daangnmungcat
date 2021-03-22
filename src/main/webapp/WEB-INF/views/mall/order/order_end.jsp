<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<style>
.wrapper {padding:70px;}
</style>
<script>
$(document).ready(function(){

});
</script>

<div class="wrapper">
<h2 id="subTitle">주문 완료</h2>

	<div class="order_completion">
		<img src="/resources/images/ico_order_complete.png" width="100px">
		<p style="font-size:25px; font-weight:bold; margin-top:20px;">주문이 정상적으로 접수 되었습니다.</p>
		<p>감사합니다. </p>
	</div>

	<table class="order_comple_table">
		<colgroup>
			<col style="width:200px;">
			<col style="">
		</colgroup>
		<tr>
			<td>결제 수단</td>
			<td>
				<c:if test="${order.settleCase == '무통장' }">
					무통장 입금<br>
					입금은행: 당근은행<br>
					입금계좌: 123-123121-1234<br>
					예금주명: (주)당근멍캣<br>
					입금금액: <fmt:formatNumber value="${order.finalPrice}"/><br>
					입금자명: ${order.member.name}<br>
				</c:if>
				<c:if test="${order.settleCase == '카카오페이' }">
					카카오페이<br>
					결제방식: 
						<c:if test="${kakao.payment_method_type == 'MONEY'}">현금</c:if>
						<c:if test="${kakao.payment_method_type == 'CARD'}">카드</c:if><br>
					결제금액: <fmt:formatNumber value="${kakao.amount.total }"/> <br>
					결제상태:
						<c:if test="${kakao.status == 'SUCCESS_PAYMENT'}">결제완료</c:if>
						<c:if test="${kakao.status == 'PART_CANCEL_PAYMENT'}">부분취소</c:if>
						<c:if test="${kakao.status == 'CANCEL_PAYMENT'}">전체취소</c:if>
						<c:if test="${kakao.status == 'FAIL_PAYMENT'}">결제승인실패</c:if>
					<br>
				</c:if>
				
			</td>
		</tr>
		<tr>
			<td>주문번호</td>
			<td>${order.id}</td>
		</tr>
		<tr>
			<td>주문일자</td>
			<td>
				<fmt:parseDate value="${order.regDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parseDate" type="both" />
	           <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${parseDate}"/>
			</td>
		</tr>
		<tr>
			<td>주문상품</td>
			<td>
			<c:forEach var="od" items="${order.details}" varStatus="odstatus">
				${od.pdt.name} 
			</c:forEach>
			</td>
		</tr>
		<tr>
			<td>주문자명</td>
			<td>${order.member.name}</td>
		</tr>
		<tr>
			<td>배송정보</td>
			<td>
				[${order.zipcode}] ${order.address1} ${order.address2}<br>
				${order.addPhone1} / ${order.addPhone2}<br>
				남기실 말씀: ${order.addMemo}
			
			</td>
		</tr>
		<tr>
			<td>상품 금액</td>
			<td><fmt:formatNumber value="${order.totalPrice}"/></td>
		</tr>
		<tr>
			<td>배송비</td>
			<td><fmt:formatNumber value="${order.deliveryPrice}"/>
			 + 추가배송비 <fmt:formatNumber value="${order.addDeliveryPrice}"/> 
			 = <fmt:formatNumber value="${order.deliveryPrice + order.addDeliveryPrice}"/></td>
		</tr>
		<tr>
			<td>마일리지</td>
			<td>
				사용: (-) <fmt:formatNumber value="${order.usedMileage}"/> <br>
			</td>
		</tr>
		<tr>
			<td>총 결제금액</td>
			<td style="font-weight:bold;"><fmt:formatNumber value="${order.finalPrice}"/></td>
		</tr>
	</table>
	<div class="btns">
		<input type="button" value="확인" onclick="location.href='/'" class="go_list">
 	</div>
	

</div>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	