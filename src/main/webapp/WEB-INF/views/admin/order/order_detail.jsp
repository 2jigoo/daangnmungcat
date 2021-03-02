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
	
	$('#checked_all').on('click', function(){
		if($('#checked_all').is(':checked')){
			$('input[name=od_check]').prop('checked', true);
		}else{
			$('input[name=od_check]').prop('checked', false);
        }
	});
	
	$('#order_price_chk').on('click', function(){
		if($('#order_price_chk').is(':checked')){
			$('#order_price_txt').attr('value', ${order.finalPrice});
		}else{
			$('#order_price_txt').attr('value', '0');
        }
	});
	
	$('#order_regdate_chk').on('click', function(){
		if($('#order_regdate_chk').is(':checked')){
			$('#order_regdate_txt').attr('value', getTimeStamp());
		}else{
			$('#order_regdate_txt').attr('value', '');
        }
	});
	
	$('#order_shipping_chk').on('click', function(){
		if($('#order_shipping_chk').is(':checked')){
			$('#order_shipping_txt').attr('value', getTimeStamp());
		}else{
			$('#order_shipping_txt').attr('value', '');
        }
	});
	
	$(document).on('click', 'input[name=status]', function(event) {
		var arr = [];
		var s = $(this).val();
        
		if($('input[name=od_check]:checked').length == 0){
			alert('처리할 자료를 하나 이상 선택하세요.')
			return;
		}else {
			if(confirm("'" + s + "'"+  '상태로 변경하시겠습니까?') == true){
				$('input[name=od_check]:checked').each(function (index) {
		            if (index >= 0) {
		               arr.push($(this).attr('od_id'));
		            }
		        });
		        console.log(arr);
		        console.log(s);
		        
		        updateOrderState(s, arr);	
			}
		}
       
	});
	
	$('#pay_shipping_update').on('click', function(){
		var data = {
				price: $('#order_price_txt').val(),
				depositor: $('#orderer_id').val(),
				payDate: $('#order_regdate_txt').val() ,
				returnPrice: $('#order_return').val(),
				trackingNum:  $('#order_shipping_num').val(),
				shippingDate: $('#order_shipping_txt').val(),
				qtt: ${order.details.size()},
				order: ${order.id}
		};
		console.log(data);
		
		 $.ajax({
			url: "/admin/order/post",
			type: "POST",
			contentType:"application/json; charset=utf-8",
			dataType: "json",
			cache : false,
			data : JSON.stringify(data),
			success: function() {
				location.reload();
			},
			error: function(request,status,error){
				alert('에러' + request.status+request.responseText+error);
			}
		});
	});
	
});

function updateOrderState(status, arr){
	
	$.ajaxSettings.traditional = true;
    $.ajax({
		url: "/admin/order/" + status ,
		type: "POST",
		contentType:"application/json; charset=utf-8",
		dataType: "json",
		cache : false,
		data : JSON.stringify(arr),
		success: function(res) {
			if(res == 1){
				location.reload();
			}
		},
		error: function(request,status,error){
			alert('에러' + request.status+request.responseText+error);
		}
	});

}

function getTimeStamp() {
	  var d = new Date();
	  var s = 
		  leadingZeros(d.getFullYear(), 4) + '-' + 
		  leadingZeros(d.getMonth()+1, 2) + '-' + 
		  
		  leadingZeros(d.getDate(), 2) + ' ' + 
		  leadingZeros(d.getHours(), 2) + ':' + 
		  leadingZeros(d.getMinutes(), 2) + ':' + 
		  leadingZeros(d.getSeconds(), 2);

	  return s;
	}

function leadingZeros(n, digits) {
  var zero = '';
  n = n.toString();

  if (n.length < digits) {
    for (i = 0; i < digits - n.length; i++)
      zero += '0';
  }
  return zero + n;
}



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
			현재 주문 상태 <b>${order.state}</b> | 
			주문일시 <b><fmt:parseDate value="${order.regDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parseDate" type="both" />
	            		<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${parseDate}"/></b> |  
			주문 총액 <b>${order.finalPrice } </b>
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
				<col width="50px">
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" id="checked_all" ></th>
					<th>상품명/옵션</th>
					<th>상태</th>
					<th>수량</th>
					<th>판매가</th>
					<th>배송비</th>
					<th>배송조건</th>
					<th>소계</th>
					<th>재고</th>
					
				</tr>
			</thead>
			<tbody>
				<c:forEach var="od" items="${order.details}" varStatus="odstatus">
					<tr>
						<td><input type="checkbox" od_id="${od.id}" pid="${od.pdt.id}" name="od_check" id="od_check"></td>
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
						<td>${od.pdt.stock}</td>
				</tr>
				</c:forEach>	
			</tbody>	
		</table>
	
	
	<div class="admin_order_status">
		<span>주문 및 상태 변경</span>  			
		<input type="button" value="대기" class="btn btn-warning btn-sm" name="status">
		<input type="button" value="결제" class="btn btn-primary btn-sm" name="status">
		<input type="button" value="배송" class="btn btn-info btn-sm" name="status">
		<input type="button" value="완료" class="btn btn-success btn-sm" name="status">
		<input type="button" value="취소" class="btn btn-secondary btn-sm" name="status">
		<input type="button" value="반품" class="btn btn-secondary btn-sm" name="status">
		<input type="button" value="품절" class="btn btn-secondary btn-sm" name="status">				
	</div>
	
	<div class="admin_od_top">
		대기, 결제, 배송, 완료는 장바구니와 주문서 상태를 모두 변경하지만, 취소, 환불, 반품은 장바구니의 상태만 변경하며, 주문서 상태는 변경하지 않습니다.
		<br>개별적인(이곳에서의) 상태 변경은 모든 작업을 수동으로 처리합니다. 예를 들어 입금대기에서 결제완료로 상태 변경시 입금액(결제금액)을 포함한 모든 정보는 수동 입력으로 처리하셔야 합니다.
		<br>포인트로 결제한 주문은 주문상태 변경을 인해 포인트가감이 발생하는 경우 포인트관리에서 수작업으로 포인트를 맞추어 주셔야 합니다.
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
						<td>결제번호</td>
						<td>${pay.id}</td>
					</tr>
					<tr>
						<td>무통장입금액</td>
						<td>
							<c:if test="${pay != null}">${pay.payPrice}</c:if>
							<c:if test="${pay == null}">${kakao}</c:if>
						</td>
					</tr>
					<tr>
						<td>입금자</td>
						<td>${pay.member.name}</td>
					</tr>
					<tr>
						<td>입금확인 일시</td>
						<td>
							<fmt:parseDate value="${pay.payDate }" pattern="yyyy-MM-dd'T'HH:mm" var="parseDate" type="both" />
	            			<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${parseDate}"/>
						</td>
					</tr>
					<tr>
						<td>취소/환불 금액</td>
						<td>
							<fmt:formatNumber value="${order.returnPrice}"/>
						</td>
					</tr>
					
					<tr>
						<td>운송장번호</td>
						<td>${order.trackingNumber }</td>
					</tr>
					<tr>
						<td>배송일시</td>
						<td><fmt:parseDate value="${order.shippingDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parseDate" type="both" />
							<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${parseDate}"/></td>
					</tr>
					<tr>
						<td>배송비</td>
						<td><input type="text" value="${order.deliveryPrice}"></td>
					</tr>
					<tr>
						<td>추가배송비</td>
						<td><input type="text" value="${order.addDeliveryPrice}"></td>
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
							<input type="checkbox" id="order_price_chk"> 결제금액 입력 <br>
							<c:if test="${pay == null}"><input type="text" id="order_price_txt" value="0">원</c:if>			
							<c:if test="${pay != null}"><input type="text" id="order_price_txt" value="${pay.payPrice}">원 </c:if>
						</td>
					</tr>
					<tr>
						<td>입금자</td>
						<td><input type="text" id="order_depositor" value="${pay.member.name}"></td>
					</tr>
					<tr>
						<td>입금확인 일시</td>
						<td>
							<input type="checkbox" id="order_regdate_chk"> 현재 시간으로 설정 <br>
							<fmt:parseDate value="${pay.payDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parseDate" type="both" />
							<input type="text" id="order_regdate_txt" readonly value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${parseDate}"/>">
						</td>
					</tr>
					<tr>
						<td>취소/환불 금액</td>
						<td><input type="text" id="order_return" value="${order.returnPrice }"></td>
					</tr>
					
					<tr>
						<td>운송장번호</td>
						<td><input type="text" id="order_shipping_num" value="${order.trackingNumber }"></td>
					</tr>
					<tr>
						<td>배송일시</td>
						<td>
							<input type="checkbox" id="order_shipping_chk"> 현재 시간으로 설정 <br>
							<fmt:parseDate value="${order.shippingDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parseDate" type="both" />
							<input type="text" id="order_shipping_txt" readonly value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${parseDate}"/>">
						</td>
					</tr>
					
				</table>
			</form>
		</div>
	
		<div class="admin_od_pay_info_btn tc">
			<input type="button" value="결제/배송내역 수정" id="pay_shipping_update">
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
							<td><input type="text" value="${order.member.id}" id="orderer_id"></td>
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