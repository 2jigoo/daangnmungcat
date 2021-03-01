<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>

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
<div class="card shadow mb-4">
	<div class="card-header py-2">
		<h6 class=" font-weight-bold text-primary" style="font-size: 1.3em;">
			<div class="mt-2 float-left">주문 상세  ${order.id} </div>
			<button id="addNew" class="btn btn-success btn-sm" onclick="location.href='/admin/mileage/write' " style="float: right;">주문 등록</button>
		</h6>
	</div>
	<!-- card-body -->
	
	<div class="card-body">
		<div class="admin_od_top">
			현재 주문 상태 <b>${order.state}</b> | 주문일시 <b>${order.regDate}</b> | 주문 총액 <b>${order.finalPrice } </b>
		</div>
		<table class="adm_table_style2">
			<colgroup>
				<col width="50px">
				<col width="500px">
				<col width="100px">
				<col width="100px">
				<col width="150px">
				<col width="150px">
				<col width="150px">
				<col width="150px">
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" id="checked_all"></th>
					<th>상품명/옵션</th>
					<th>상태</th>
					<th>수량</th>
					<th>판매가</th>
					<th>배송비</th>
					<th>배송조건</th>
					<th>소계</th>
					
				</tr>
			</thead>
			<tbody>
				<c:forEach var="od" items="${order.details}" varStatus="odstatus">
					<tr>
						<td><input type="checkbox" pid="${od.pdt.id}" id="od_check"></td>
            			<td>
							<div class="order_img_wrapper">
								<c:if test="${od.pdt.image1 eq null}"><a href="/mall/product/${od.pdt.id}"><img src="/resources/images/no_image.jpg" class="admin_od_img"></a></c:if>
								<c:if test="${od.pdt.image1 ne null}"><a href="/mall/product/${od.pdt.id}"><img src="/resources${od.pdt.image1}" class="admin_od_img"></a></c:if>
								<a href="/mall/product/${od.pdt.id}">${od.pdt.name}</a>
							</div>
						</td>
						<td>${od.orderState.label}</td>
						<td>${od.quantity}</td>
						<td><fmt:formatNumber value="${od.pdt.price}"/></td>
						<td>${od.pdt.deliveryPrice}</td>
						<td>${od.pdt.deliveryKind}
						<td>${od.totalPrice}</td>
				</tr>
				</c:forEach>	
			</tbody>	
		</table>
		
	<div class="admin_order_status">
		<span>주문 및 상태 변경</span>  			
		<input type="button" value="대기" class="btn btn-warning btn-sm">
		<input type="button" value="결제" class="btn btn-primary btn-sm">
		<input type="button" value="배송" class="btn btn-info btn-sm">
		<input type="button" value="완료" class="btn btn-success btn-sm"> 
		<input type="button" value="취소" class="btn btn-secondary btn-sm">
		<input type="button" value="환불" class="btn btn-secondary btn-sm">					
		<input type="button" value="반품" class="btn btn-secondary btn-sm">
	</div>
	<span>현재 배송비: ${total }</span>
	
	
<!-- 주문결제내역 -->	
	
	<h5 class="admin_order_title tc">주문결제 내역</h5>
	<div class="admin_od_pay_info_div">
		<span style="color:red; text-align:left">미수금 ${order.misu}원</span>
		<table class="adm_table_style2">
			<colgroup>
				<col width="40%">
				<col width="5%">
				<col width="5%">
				<col width="5%">
				<col width="5%%">
				<col width="5%%">
				<col width="5%">
				<col width="5%">
			</colgroup>
			<thead>
				<tr>
					<th>주문번호</th>
					<th>결제방법</th>
					<th>주문총엑</th>
					<th>배송비</th>
					<th>추가 배송비</th>
					<th>사용마일리지</th>
					<th>총결제액</th>
					<th>주문취소</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>${order.id }</td>
					<td>${order.settleCase }</td>
					<td>${order.totalPrice }</td>
					<td>${order.deliveryPrice }</td>
					<td>${order.addDeliveryPrice }</td>
					<td>${order.usedMileage }</td>
					<td>${order.finalPrice}</td>
					<td>${order.returnPrice }</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	
	
<!-- 결제 상세정보 -->	
	<h5 class="admin_order_title tc">결제 상세 정보</h5>
	
	<!-- 무통장 -->
	<c:if test="${order.settleCase == '무통장'}">
	<div class="admin_od_pay_info_div">	
		<div class="admin_od_pay_info tl">
			<b>결제상세정보 확인</b>
			<form action="admin_pay">
				<table class="info_confirm">
					<tr>
						<td>무통장입금액</td>
						<td>
							<c:if test="${pay != null}">${pay.payPrice}</c:if>
							<c:if test="${pay == null}">${kakao}</c:if>
						</td>
					</tr>
					<tr>
						<td>입금자</td>
						<td></td>
					</tr>
					<tr>
						<td>입금확인 일시</td>
						<td></td>
					</tr>
					<tr>
						<td>취소/환불 금액</td>
						<td><fmt:formatNumber value="${order.returnPrice}"/></td>
					</tr>
					
					<tr>
						<td>운송장번호</td>
						<td></td>
					</tr>
					<tr>
						<td>배송일시</td>
						<td></td>
					</tr>
					<tr>
						<td>배송비</td>
						<td><input type="text"></td>
					</tr>
					<tr>
						<td>추가배송비</td>
						<td><input type="text"></td>
					</tr>
				</table>
			</form>
		</div>
		
		<div class="admin_od_pay_info tl">
			<b>결제상세정보 수정</b>
			<form action="admin_pay" >
				<table class="info_form">
					<tr>
						<td>무통장입금액</td>
						<td>
							<input type="checkbox"> 결제금액 입력 <br>
							<input type="text">원
						</td>
					</tr>
					<tr>
						<td>입금자</td>
						<td><input type="text"></td>
					</tr>
					<tr>
						<td>입금확인 일시</td>
						<td>
							<input type="checkbox"> 현재 시간으로 설정 <br>
							<input type="text">
						</td>
					</tr>
					<tr>
						<td>취소/환불 금액</td>
						<td><input type="text"></td>
					</tr>
					
					<tr>
						<td>운송장번호</td>
						<td><input type="text"></td>
					</tr>
					<tr>
						<td>배송일시</td>
						<td>
							<input type="checkbox"> 현재 시간으로 설정 <br>
							<input type="text">
						</td>
					</tr>
					<tr>
						<td>배송비</td>
						<td><input type="text"></td>
					</tr>
					<tr>
						<td>추가배송비</td>
						<td><input type="text"></td>
					</tr>
				</table>
			</form>
		</div>
	
		<div class="admin_od_pay_info_btn tc">
			<input type="button" value="결제/배송내역 수정">
			<input type="button" value="목록">
		</div>
	</div>
	</c:if>
	
	
	<!-- 카카오페이일때 -->
	<c:if test="${kakao != null }">
	<div class="admin_od_pay_info_div">	
		<div class="admin_od_pay_info tl">
			<b>결제상세정보 확인</b>
			<form action="admin_pay">
				<table class="info_confirm">
					<tr>
						<td>결제고유번호</td>
						<td>${kakao.tid}</td>
					</tr>
					<tr>
						<td>가맹점 코드</td>
						<td>${kakao.cid}</td>
					</tr>
					<tr>
						<td>결제 상태</td>
						<td>
							<c:if test="${kakao.status == 'SUCCESS_PAYMENT'}">결제 완료</c:if>
							<c:if test="${kakao.status == 'PART_CANCEL_PAYMENT'}">부분 취소</c:if>
							<c:if test="${kakao.status == 'CANCEL_PAYMENT'}">전체 취소</c:if>
							<c:if test="${kakao.status == 'FAIL_PAYMENT'}">결제 승인 실패</c:if>
						</td>
					</tr>
					<tr>
						<td>주문번호</td>
						<td>${kakao.partner_order_id}</td>
					</tr>
					<tr>
						<td>주문자</td>
						<td>${kakao.partner_user_id}</td>
					</tr>
					<tr>
						<td>결제 수단</td>
						<td>${kakao.payment_method_type}</td>
					</tr>
					<tr>
						<td>결제 금액</td>
						<td>${kakao.amount.total}</td>
					</tr>
					<tr>
						<td>부가세</td>
						<td>${kakao.amount.vat}</td>
					</tr>
					<tr>
						<td>취소된 금액</td>
						<td>${kakao.canceled_amount.total} </td>
					</tr>
					<tr>
						<td>남은 취소 가능 금액</td>
						<td> ${kakao.cancel_available_amount.total}</td>
					</tr>
					
					<tr>
						<td>상품 이름</td>
						<td>${kakao.item_name}</td>
					</tr>
					<tr>
						<td>상품 수량</td>
						<td>${kakao.quantity}</td>
					</tr>
					<tr>
						<td>결제 승인 시각</td>
						<td>${kakao.approved_at}</td>
					</tr>
					<tr>
						<td>결제 취소 시각</td>
						<td>${kakao.canceled_at}</td>
					</tr>
					<tr>
						<td>결제/취소 상세</td>
						<td>${kakao.payment_action_details}</td>
					</tr>
				</table>
			</form>
		</div>
		
		<div class="admin_od_pay_info tl">
			<b>결제상세정보 수정</b>
			<form action="admin_pay" >
				<table class="info_form">
					<tr>
						<td>운송장번호</td>
						<td><input type="text"></td>
					</tr>
					<tr>
						<td>배송일시</td>
						<td>
							<input type="checkbox"> 현재 시간으로 설정 <br>
							<input type="text">
						</td>
					</tr>
					<tr>
						<td>배송비</td>
						<td><input type="text"></td>
					</tr>
					<tr>
						<td>추가배송비</td>
						<td><input type="text"></td>
					</tr>
				</table>
			</form>
		</div>
	
		<div class="admin_od_pay_info_btn tc">
			<input type="button" value="결제/배송내역 수정">
			<input type="button" value="목록">
		</div>
	</div>
	
	</c:if>
	
	
<!-- 주문자/배송지 정보 -->
	<h5 class="admin_order_title tc">주문자/배송지 정보</h5>
	<div class="admin_od_pay_info_div ">
		<form action="admin_shipping" >
			<div class="admin_od_pay_info tl">
				<b>주문하신 분</b>
					<table class="info_form">
						<tr>
							<td>아이디</td>
							<td><input type="text"></td>
						</tr>
						<tr>
							<td>이름</td>
							<td><input type="text"></td>
						</tr>
						<tr>
							<td>전화번호</td>
							<td><input type="text"></td>
						</tr>
						<tr>
							<td>핸드폰</td>
							<td><input type="text"></td>
						</tr>
						<tr>
							<td>주소</td>
							<td><input type="text"><input type="button" value="우편번호검색"><br>
								<input type="text"><input type="text">
							</td>
						</tr>
						
					</table>
				
			</div>
			
				<div class="admin_od_pay_info tl">
				<b>받으시는 분</b>
					<table class="info_form">
						<tr>
							<td>이름</td>
							<td><input type="text"></td>
						</tr>
						<tr>
							<td>전화번호</td>
							<td><input type="text"></td>
						</tr>
						<tr>
							<td>핸드폰</td>
							<td><input type="text"></td>
						</tr>
						<tr>
							<td>주소</td>
							<td><input type="text"><input type="button" value="우편번호검색"><br>
								<input type="text"><input type="text">
							</td>
						</tr>
						<tr>
							<td>배송 메모</td>
							<td><input type="text"> </td>
						</tr>
					</table>
				</div>
			</form>
		
		<div class="admin_od_pay_info_btn tc">
			<input type="button" value="주문자/배송지 정보 수정" onclick='location.href="/admin/order/list"' >
			<input type="button" value="목록" onclick='location.href="/admin/order/list"' >
		</div>
		
	</div>


<%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>