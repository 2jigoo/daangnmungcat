<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/resources/include/header.jsp" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script>
$(document).ready(function(){

});

</script>

<div class="pre_order">
<h3 style="text-align:center; padding:20px">주문서 작성 / 결제 </h3>
<form method="post" id="form" action="/kakao-pay" enctype="multipart/form-data" accept-charset="utf-8">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" >
	<table class="pre_order_table">
		<colgroup>
			<col width="50px">
			<col width="200px">
			<col width="50px">
			<col width="50px">
			<col width="50px">
			<col width="50px">
			<col width="100px">
		</colgroup>
		<thead>
			<tr>
				<th></th>	
				<th>상품/옵션 정보</th>
				<th>수량</th>
				<th>상품금액</th>
				<th>적립금액</th>
				<th>합계금액</th>
				<th>배송비</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="cart" items="${cart}" varStatus="status">
			<tr>
				<td><img id="pdt_img" src="/resources/images/no_image.jpg" width="100%"></td>
				<td>
					<input type="hidden" id="pdt_id" name="pdt_id" value="${cart.product.id}">
					${cart.product.name}
				</td>
				<td>${cart.quantity }</td>
				<td><span class="price" value="${cart.product.price }">${cart.product.price}</span></td>
				<td><fmt:formatNumber value="${cart.product.price * 0.01}" /></td>
				<td>${cart.product.price * cart.quantity}</td>
				<td>
					${cart.product.deliveryKind}
					<c:if test="${cart.product.deliveryKind eq '조건부 무료배송'}">
						<br><span class="cart_price"><fmt:formatNumber value="${cart.product.deliveryPrice}"/></span>원
						<br>(<fmt:formatNumber value="${cart.product.deliveryCondition}"/>원 이상 구매)
					</c:if>
					<c:if test="${cart.product.deliveryKind eq '유료배송'}">
						<br><span class="cart_price"><fmt:formatNumber value="${cart.product.deliveryPrice}"/></span>원
					</c:if>
				</td>
			</tr>
		</c:forEach>
			</tbody>
		</table>

	<div class="pre_order_box">
		<div class="box1">
			총 ${size}개의 상품금액 <br>
			<span class="">${total}원</span> 
		</div>
		<div class="box2">
		배송비<br>
		${delivery}
		</div>
		<div class="box3">
		합계 <br>
		${final_price}원<br>
		적립예정 마일리지: <fmt:formatNumber value="${mileage}" />원
		</div>
	</div>
	<div class="pre_order_btn">
		<div class="pre_order_info"></div>
		<input type="submit" value="결제" id="order_btn" onclick="location.href='/mall/mall_pre_order'">
	</div>
	</form>
</div>

<jsp:include page="/resources/include/footer.jsp"/>
	