<%@page import="daangnmungcat.dto.AuthInfo"%>
<%@page import="daangnmungcat.service.MileageService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/resources/include/header.jsp" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
$(document).ready(function(){
	
	var price = $('#final_price').text();
	$('input[name=final]').prop('value', price);
	
	$('#order_btn').on('click', function(){
		$('#form').submit();
	});
	
	$('#account_order_btn').on('click', function(){
		console.log('무통장')
		$("#form").attr("action", "/accountPay");
		$('#form').submit();
	})
	
	$('input[name=chk]:eq(0)').on('click', function(){
		$('#zipcode').attr('value', "${member.zipcode}");
		$('#address1').attr('value', "${member.address1}");
		$('#address2').attr('value', "${member.address2}");
		$('#order_name').attr('value', "${member.name}");
		$('#order_phone').attr('value', "${member.phone}");
	});
	
	$('input[name=chk]:eq(1)').on('click',function(){
		$('#zipcode').attr('value', "");
		$('#address1').attr('value', "");
		$('#address2').attr('value', "");
		$('#order_name').attr('value', "");
		$('#order_phone').attr('value', "");
	});
	
	$('#myAddress').on('click', function(){
		window.open("/mall/order/mall_my_address", "", "width=700, height=500, left=100, top=50 ,location=no, directoryies=no, resizable=no, scrollbars=yes");
	});
	
	$('#mile_chk').on('change', function(){
		if($('#mile_chk').is(':checked')){
			$('#use_mileage').prop('value', ${member.mileage});	
			var use = $('#use_mileage').val();
			$('#final_price').text(${final_price} - use);
			$('input[name=final]').prop('value', ${final_price} - use);
		}else {
			$('#use_mileage').prop('value', "0");
			$('#final_price').text(${final_price});
			$('input[name=final]').prop('value', ${final_price});
			
		}
	});
	
	$('#use_mileage').keyup(function() {
		var use = $('#use_mileage').val();
		if(${member.mileage} < use){
			alert('보유 마일리지가 부족합니다.');
			$('#use_mileage').prop('value', "");
			$('#final_price').text(${final_price});
			$('input[name=final]').prop('value', ${final_price});
		}else {
			$('#final_price').text(${final_price} - use);
			$('input[name=final]').prop('value', ${final_price} - use);
		}
	})
	
});

function check(a){
	var obj = document.getElementsByName("chk");

    for(var i=0; i<obj.length; i++){
        if(obj[i] != a){
            obj[i].checked = false;
        }
    }
    
}

function execPostCode(){
	daum.postcode.load(function(){
      new daum.Postcode({
          oncomplete: function(data) {
				//변수값 없을때는 ''
				var addr = '';
				$('#zipcode').attr('value', data.zonecode);
				$('#address1').attr('value', data.address);
          	}
          }).open();
  });
}




</script>


<h3 style="text-align:center; padding:50px">주문서 작성 / 결제 </h3>
<form method="post" id="form" action="/kakao-pay" enctype="multipart/form-data" accept-charset="utf-8">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" >
	<!-- 넘어가는 data -->
	<input type="hidden" name="first_pdt" value="${cart.get(0).product.name}"> <!-- 첫번째 -->
	<input type="hidden" name="pdt_qtt" value="${size}"> <!-- 주문개수 -->
	<input type="hidden" name="final"> <!-- 최종가격  -->
	<input type="hidden" name="mem_id" value="${member.id}"> 
	<input type="hidden" name="total_qtt" value="${total_qtt}"> <!-- 총 수량 -->
	<input type="hidden" name="plus_mile" value="${mileage}"> <!-- 적립예정 -->
	<input type="hidden" name="total" value="${total}"> <!-- 적립예정 -->
	<input type="hidden" name="deli" value="${totalDeliveryFee}"> <!-- 적립예정 -->
	
	<div class="pre_order_cart_div">
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
						<c:choose>
							<c:when test="${cart.product.deliveryKind eq '조건부 무료배송' }">
								<c:if test="${conditionalDeliveryFee eq 0}">
										무료배송
								</c:if>
								<c:if test="${conditionalDeliveryFee ne 0}">
									<fmt:formatNumber value="${cart.product.deliveryPrice}"/>원
								</c:if>
									<br>(<fmt:formatNumber value="${cart.product.deliveryCondition}"/>원 이상 구매 시 무료)
							</c:when>
							<c:when test="${cart.product.deliveryKind eq '유료배송' }">
									개당 ${cart.product.deliveryPrice}원
							</c:when>
							<c:otherwise>
									${cart.product.deliveryKind}
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
				</tbody>
		</table>
	
		
		<div class="pre_order_go_cart_btn">
			<input type="button" value="장바구니로 가기" onclick="location.href='/mall/cart/list'">
		</div>
	</div>	
	
	<div class="pre_order_box">
		<div class="box1">
			총 ${size}개의 상품금액 <br>
			<span class=""><fmt:formatNumber value="${total}" />원</span> 
		</div>
		<div class="box2">
			배송비<br> 
			<fmt:formatNumber value="${totalDeliveryFee}" />
		</div>
		<div class="box3">
			합계 <br>
			<fmt:formatNumber value="${total + totalDeliveryFee }" />원<br>
			적립예정 마일리지: <fmt:formatNumber value="${mileage}" />원
		</div>
	</div>
	
<div class="order_detail_info_div">
		<h4>주문자 정보</h4>
		<table id="pre_order_info_table">
			<tr>
				<td>주문하시는 분</td> 
				<td><input type="text" value="${member.name}" name=""></td> 
			</tr>
			<tr>
				<td>주소</td> 
				<td>
					<c:if test="${member.address1 eq null}"></c:if>
					<c:if test="${member.address1 ne null}">
						<span>(${member.zipcode}) ${member.address1} ${member.address2}</span>
					</c:if>
				</td> 
			</tr>
			<tr>
				<td>연락처</td> 
				<td><input type="text" value="${member.phone}" name=""></td> 
			</tr>
			<tr>
				<td>이메일</td> 
				<td><input type="text" value="${member.email}" name=""></td> 
			</tr>
		</table>
	
		<h4>배송정보</h4>
			<table id="pre_order_info_table">
				<tr>
					<td>배송지 확인</td> 
					<td>
						<input type="checkbox" name="chk" onclick="check(this)" value="mem" checked> 주문자 정보와 동일
						<input type="checkbox" name="chk" onclick="check(this)" value="write"> 직접 입력
						<input type="button" value="배송지관리" id="myAddress">
					</td> 
				</tr>
				<tr>
					<td>받으실 분</td> 
					<td><input type="text" value="${member.name}" id="order_name" name="add_name"></td> 
				</tr>
				<tr>
					<td>받으실 곳</td> 
					<td>
						<input type="text" value="${member.zipcode}" id="zipcode" name="zipcode">
						<input type="button" value="우편번호 검색" onclick="execPostCode()">
						<br>
						<input type="text" value="${member.address1}" id="address1" name="address1">
						<input type="text" value="${member.address2}" id="address2" name="address2">
					</td> 
				</tr>
				<tr>
					<td>받는 분 일반 전화</td> 
					<td><input type="text" id="phone1" name="phone1"></td> 
				</tr>
				<tr>
					<td>받는 분 휴대폰</td> 
					<td><input type="text" value="${member.phone}" id="phone2" name="phone2"></td> 
				</tr>
				<tr>
					<td>남기실 말씀</td> 
					<td><input type="text" id="order_memo" name="order_memo"></td> 
				</tr>
			</table>

	
	
		<h4>결제정보</h4>
		<table id="pre_order_info_table">
			<tr>
				<td>합계금액</td>
				<td><span id="total_price"><fmt:formatNumber value="${total}" /></span></td>
			</tr>
			<tr>
				<td>배송비</td>
				<td><span id="shipping_price"><fmt:formatNumber value="${totalDeliveryFee}"/></span></td>
			</tr>
			<tr>
				<td>적립액</td>
				<td><span id="mileage_info"><fmt:formatNumber value="${mileage}"/></span></td>
			</tr>
			<tr>
				<td>마일리지 사용</td>
				<td><input type="text" id="use_mileage" name="use_mileage" value="">
				<input type="checkbox" id="mile_chk">전액 사용하기 
										(보유 마일리지:<fmt:formatNumber value="${memberMileage}"/>원)
				<input type="hidden" value="${memberMileage}" id="mem_mile"></td>
			</tr>
			<tr>
				<td>최종 결제 금액</td>
				<td><span id="final_price">${final_price}</span>
					
				</td>
			</tr>
		</table>
</div>	
	
	<div class="pre_order_btn">
		<input type="button" value="무통장입금" id="account_order_btn">
		<input type="button" value="카카오페이" id="order_btn">
	</div>
	</form>


<jsp:include page="/resources/include/footer.jsp"/>
	