<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<style>
.wrapper {margin:0 auto; padding:70px; margin-bottom:50px;}
</style>
<script>
$(document).ready(function(){
	
	$(".gubun").each(function () {
	 	var rows = $(".gubun:contains('" + $(this).text() + "')");
		if (rows.length > 1) {
		     rows.eq(0).prop("rowspan", rows.length);
		     rows.not(":eq(0)").remove();
		        
		} 
	});
	
	$(document).on('click', '#cancel_multiple', '#cancel_single', function(){
		var id = {id: $(this).attr('orderId')};
		
		if(confirm('주문을 취소하시겠습니까?') == true){
			$.ajax({
				url: '/order-cancel',
				type: "post",
				contentType: "application/json; charset=utf-8",
				data : JSON.stringify(id),
				dataType: "json",
				cache : false,
				success: function(res) {
					alert('주문 취소 완료');
					location.reload();
				},
				error: function(request,status,error){
					alert('에러' + request.status+request.responseText+error);
				}
			});
		}else {
			return;
		}
		
	});
	
});
</script>
<br>
<div class="wrapper">
<h2 id="subTitle">주문 상세</h2>
	<table id="order_list_table" style="margin-top:80px;">
		<colgroup>
			<col width="200px">
			<col width="400px">
			<col width="100px">
			<col width="200px">
			<col width="150px">
			<col width="150px">
		</colgroup>
		<thead>
			<tr>
				<th>주문일/주문번호</th>
				<th>상품명/옵션</th>
				<th>수량</th>
				<th>상품금액</th>
				<th>주문상태</th>
				<th>상품 합계 금액</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="od" items="${order.details}" varStatus="odstatus">
				<tr>
					<c:if test="${od.partcnt > 1}">
            				<td class="gubun order_num">
            					<fmt:parseDate value="${order.regDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parseDate" type="both" />
            					<fmt:formatDate pattern="yyyy-MM-dd" value="${parseDate}"/><br>
           						<span class="order_list_span" onclick="location.href='/mypage/mypage_order_list?id=${order.id}'">	
            						${order.id}
           						</span>
           						
           						<c:if test="${order.state == '대기'}">
           							<br><input type="button" value="주문취소" orderId="${order.id}" id="cancel_multiple" class="order_list_cancel" style="margin:10px;">
           						</c:if>
           						
           					</td>
            			</c:if>
            			
            			<c:if test="${od.partcnt == 1}">
            				<td class="order_num">
            					<fmt:parseDate value="${order.regDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parseDate" type="both" />
            					<fmt:formatDate pattern="yyyy-MM-dd" value="${parseDate}"/><br>
           						<span class="order_list_span" onclick="location.href='/mypage/mypage_order_list?id=${order.id}'">	
            						${order.id}
           						</span>
           						
           						<c:if test="${order.state == '대기'}">
           							<br><input type="button" value="주문취소" orderId="${order.id}" id="cancel_multiple" class="order_list_cancel" style="margin:10px;">
           						</c:if>
            				</td>
            			</c:if>
            			
            			<td class="tl" >
							<div class="order_img_wrapper">
									<c:if test="${od.pdt.image1 eq null}"><a href="/mall/product/${od.pdt.id}"><img src="/resources/images/no_image.jpg" class="order_list_img"></a></c:if>
									<c:if test="${od.pdt.image1 ne null}"><a href="/mall/product/${od.pdt.id}"><img src="/resources${od.pdt.image1}" class="order_list_img"></a></c:if>
								<span style="margin-left:30px; line-height:100px; overflow:hidden" id="part_pdt" pdt="${od.pdt.name}">
									<a href="/mall/product/${od.pdt.id}">${od.pdt.name}</a>
								</span>
							</div>
							
						</td>
						<td>${od.quantity}</td>
						<td><fmt:formatNumber value="${od.pdt.price}"/></td>
						<td>
							<c:if test="${od.orderState.label == '대기'}">입금대기</c:if>
							<c:if test="${od.orderState.label == '결제'}">결제완료</c:if>
							<c:if test="${od.orderState.label == '배송'}">배송중</c:if>
							<c:if test="${od.orderState.label == '완료'}">배송완료</c:if>
							<c:if test="${od.orderState.label == '취소'}">결제취소</c:if>
							<c:if test="${od.orderState.label == '반품'}">반품취소</c:if>
							<c:if test="${od.orderState.label == '퓸절'}">품절취소</c:if>
							<c:if test="${od.orderState.label == '환불'}">환불완료</c:if>
							<c:if test="${od.orderState.label == '구매확정'}">구매확정</c:if>
						</td>
						
						<c:if test="${od.partcnt > 1}">
            				<td class="gubun final_price">
            					<input type="hidden" value="<fmt:parseDate value="${order.payDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parseDate" type="both" />
	            				<fmt:formatDate pattern="yyyy-MM-dd" value="${parseDate}"/>">
            					<fmt:formatNumber value="${order.finalPrice}"/>
	            				<br>
	            				<c:if test="${order.state == '대기'}">입금대기</c:if>
								<c:if test="${order.state == '결제'}">결제완료</c:if>
								<c:if test="${order.state == '배송'}">배송중</c:if>
								<c:if test="${order.state == '완료'}">배송완료</c:if>
								<c:if test="${order.state == '취소'}">결제취소</c:if>
								<c:if test="${order.state == '반품'}">반품</c:if>
								<c:if test="${order.state == '퓸절'}">품절</c:if>
								<c:if test="${order.state == '환불'}">환불</c:if>
								<c:if test="${order.state == '구매확정'}">구매확정</c:if>
	            				<br>
	            				<c:if test="${order.trackingNumber != null}">[<a href="#" style="text-decoration:underline">${order.trackingNumber}</a>]</c:if>
	            				<c:if test="${order.state == '완료'}"><input type="button" value="구매확정"></c:if>
            				</td>
						</c:if>
						
						<c:if test="${od.partcnt == 1}">
            				<td class="final_price">
	            				<input type="hidden" value="<fmt:parseDate value="${order.payDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parseDate" type="both" />
	            				<fmt:formatDate pattern="yyyy-MM-dd" value="${parseDate}"/>">
	            				<fmt:formatNumber value="${order.finalPrice}"/> 
	            				<br>
	            				<c:if test="${order.state == '대기'}">입금대기</c:if>
								<c:if test="${order.state == '결제'}">결제완료</c:if>
								<c:if test="${order.state == '배송'}">배송중</c:if>
								<c:if test="${order.state == '완료'}">배송완료</c:if>
								<c:if test="${order.state == '취소'}">결제취소</c:if>
								<c:if test="${order.state == '반품'}">반품</c:if>
								<c:if test="${order.state == '퓸절'}">품절</c:if>
								<c:if test="${order.state == '환불'}">환불</c:if>
								<c:if test="${order.state == '구매확정'}">구매확정</c:if>
	            				<br>
	            				<c:if test="${order.trackingNumber != null}">[<a href="#" style="text-decoration:underline">${order.trackingNumber}</a>]</c:if>
	            				<c:if test="${order.state == '완료'}"><input type="button" value="구매확정"></c:if>
            				</td>
            			</c:if>
				</tr>
			</c:forEach>
		</tbody>
		<tfoot>
			<tr>
			
				<td colspan="6" style="padding:20px;">
					구매금액  <fmt:formatNumber value="${order.totalPrice - order.cancelPrice}"/> + 
					배송비  <fmt:formatNumber value="${order.deliveryPrice}"/> + 
					추가배송비 <fmt:formatNumber value="${order.addDeliveryPrice}"/> = 
					합계 : <span style="font-weight:bold">
							<fmt:formatNumber value="${order.totalPrice - order.cancelPrice + order.deliveryPrice + order.addDeliveryPrice}"/> 원
						</span>
				</td>
			</tr>
		</tfoot>
	</table>
	
<div class="order_detail_info_div">
		<span class="tableTitle">주문자 정보</span>
		<table class="order_detail_table">
			<tr>
				<td>주문자 정보</td>
				<td>${order.member.name}</td>
			</tr>
			
			<tr>
				<td>주소</td>
				<td>(${order.member.zipcode}) ${order.member.address1} ${order.member.address2}</td>
			</tr>
			<tr>	
				<td>휴대폰 번호</td>
				<td>${order.member.phone}</td>
			</tr>
			
			<tr>
				<td>이메일</td>
				<td>${order.member.email}</td>
			</tr>
			
			
		</table>
	
		<span class="tableTitle">배송지 정보</span>
		<table  class="order_detail_table">
				<tr>
					<td>받으시는 분</td>
					<td>${order.addName }</td>
				</tr>
				<tr>
					<td>받으실 주소</td>
					<td>(${order.zipcode}) ${order.address1} ${order.address1}</td>
				<tr>
					<td>전화번호</td>
					<td>${order.addPhone1}</td>
				</tr>
				<tr>
					<td>휴대폰 번호</td>
					<td>${order.addPhone2}</td>
				</tr>
				<tr>
					<td>남기실 말씀</td>
					<td>${order.addMemo}</td>
				</tr>
		</table>
		
		<span class="tableTitle">결제 정보</span>
		<table  class="order_detail_table">
				<tr>
					<td>결제 방식</td>
					<td>${order.settleCase }</td>
				</tr>
				<tr>
					<td>상품 합계 금액</td>
					<td><fmt:formatNumber value="${order.totalPrice - order.cancelPrice}"/></td>
				</tr>
				<tr>
					<td>배송비</td>
					<td><fmt:formatNumber value="${order.deliveryPrice}"/></td>
				</tr>
				<c:if test="${order.addDeliveryPrice != null && order.addDeliveryPrice != 0}">
				<tr>
					<td>추가 배송비 </td>
					<td><fmt:formatNumber value="${order.addDeliveryPrice}"/></td>
				</tr>
				</c:if>
				<tr>
					<td>총 결제 금액</td>
					<td style="font-weight:bold">
						<c:if test="${order.settleCase == '카카오페이'}">
							<fmt:formatNumber value="${kakao.kakao.amount.total}"/>
						</c:if>
						<c:if test="${order.settleCase == '무통장'}">
							<fmt:formatNumber value="${account.payPrice}"/>
						</c:if>
					</td>
				</tr>
				<c:if test="${order.returnPrice != null && order.returnPrice != 0}">
					<tr>
						<td>주문취소 금액</td>
						<td><fmt:formatNumber value="${order.returnPrice}"/></td>
					</tr>
				</c:if>
				<c:if test="${order.cancelPrice != 0}">
					<tr>
						<td>환불 금액</td>
						<td><fmt:formatNumber value="${order.cancelPrice}"/></td>
					</tr>
				</c:if>
				<tr>
					<td>마일리지</td>
					<td>
						적립 예정 마일리지 : <fmt:formatNumber value="${order.plusMileage}"/><br> 
						사용한 마일리지 : <fmt:formatNumber value="${order.usedMileage}"/>
					</td>
				</tr>
		</table>
	
	<input type="button" value="목록으로" onclick='location.href="/mypage/mypage_order_list"' class="go_list">
	</div>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>