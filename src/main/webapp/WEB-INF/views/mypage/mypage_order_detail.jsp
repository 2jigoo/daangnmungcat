<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>

<style>
.wrapper {margin:0 auto; padding:50px;}
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
});
</script>

<div class="wrapper">
<h2 id="subTitle">주문 상세내역</h2>
	<table id="order_list_table">
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
				<th>총 결제금액</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="od" items="${order.details}" varStatus="odstatus">
				<tr>
					<c:if test="${od.partcnt > 1}">
            				<td class="gubun order_num">
            					<span class="order_list_span"  onclick="location.href='/mypage/mypage_order_list/${order.id}'">	
	            					<fmt:parseDate value="${order.payDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parseDate" type="both" />
	            					<fmt:formatDate pattern="yyyy-MM-dd" value="${parseDate}"/>
	            					<br> ${order.id}
            					</span>
            				</td>
            			</c:if>
            			<c:if test="${od.partcnt == 1}">
            				<td class="order_num">
            					<span class="order_list_span"  onclick="location.href='/mypage/mypage_order_list/${order.id}'">	
	            					<fmt:parseDate value="${order.payDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parseDate" type="both" />
	            					<fmt:formatDate pattern="yyyy-MM-dd" value="${parseDate}"/>
	            					<br> ${order.id}
	            				</span>
            				</td>
            			</c:if>
            			<td class="tl" >
							<div class="order_img_wrapper">
									<c:if test="${od.pdt.image1 eq null}"><a href="/mall/product/${od.pdt.id}"><img src="/resources/images/no_image.jpg" class="order_list_img"></a></c:if>
									<c:if test="${od.pdt.image1 ne null}"><a href="/mall/product/${od.pdt.id}"><img src="/resources${od.pdt.image1}" class="order_list_img"></a></c:if>
								<span style="margin-left:30px; line-height:100px"><a href="/mall/product/${od.pdt.id}">${od.pdt.name}</a></span></div>
							
						</td>
						<td>${od.quantity}</td>
						<td><fmt:formatNumber value="${od.pdt.price}"/></td>
						<td>${od.orderState.label}</td>
						
						<c:if test="${od.partcnt > 1}">
            				<td class="gubun final_price">
            					<input type="hidden" value="<fmt:parseDate value="${order.payDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parseDate" type="both" />
	            				<fmt:formatDate pattern="yyyy-MM-dd" value="${parseDate}"/>">
            					<fmt:formatNumber value="${order.finalPrice}"/>
            					<br>
            					<input type="button" value="주문취소">
            				</td>
            					
						</c:if>
						<c:if test="${od.partcnt == 1}">
            				<td class="final_price">
	            				<input type="hidden" value="<fmt:parseDate value="${order.payDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parseDate" type="both" />
	            				<fmt:formatDate pattern="yyyy-MM-dd" value="${parseDate}"/>">
	            				<fmt:formatNumber value="${order.finalPrice}"/>
	            				<br>
								<input type="button" value="주문취소">
            				
            				</td>
            				
            			</c:if>
				</tr>
			</c:forEach>
		</tbody>
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
				<td>상품 합계 금액</td>
				<td><fmt:formatNumber value="${order.totalPrice}"/></td>
			</tr>
			<tr>
				<td>배송비</td>
				<td><fmt:formatNumber value="${order.deliveryPrice}"/></td>
			</tr>
			<tr>
				<td>총 결제 금액</td>
				<td><fmt:formatNumber value="${order.finalPrice}"/></td>
			</tr>
			<tr>
				<td>마일리지</td>
				<td>
					적립된 마일리지 : <fmt:formatNumber value="${order.plusMileage}"/><br> 
					사용한 마일리지 : <fmt:formatNumber value="${order.usedMileage}"/>
				</td>
			</tr>
		</table>
	<input type="button" value="목록으로" onclick='location.href="/mypage/mypage_order_list"' >
	</div>
</div>



<jsp:include page="/resources/include/footer.jsp"/>