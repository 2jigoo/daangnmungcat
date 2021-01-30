<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>

<script>
$(document).ready(function(){
	
	$.get("/mall/pre-order", function(json){
		var total = json.total;
		var qtt = json.qtt;
		var pdt = json.pdt;
		var mem = json.member;
		if(pdt.image1 != null){
			$('#pdt_img').attr('src', 'resources'+pdt.image1);
		}	
		$('#mem_id').attr('value', mem.id);
		$('#pdt_id').attr('value', pdt.id);
		$('#pdt_name').attr('value', pdt.name);
		$('#pdt_qtt').attr('value', qtt);
		$('#pdt_price').attr('value', pdt.price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		$('#mile').attr('value', pdt.price * 0.01);
		$('#total_price').attr('value', total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		$('#total').attr('value', total);
		$('#deli_kind').attr('value', pdt.deliveryKind);
		
		if(pdt.deliveryCondition != null){
			$('#deli_condition').attr('value', '(' + pdt.deliveryCondition.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + '원 이상)');	
		}
		if(pdt.deliveryPrice != null){
			$('#deli_price').attr('value', pdt.deliveryPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + '원');	
		}
		
	});
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
			<tr>
				<td><img id="pdt_img" src="/resources/images/no_image.jpg" width="100%"></td>
				<td>
					<input type="hidden" id="pdt_id" name="pdt_id"  readonly>
					<input type="hidden" id="mem_id" name="mem_id" readonly>
					<input type="text" id="pdt_name" name="pdt_name" readonly>
				</td>
				<td><input type="text" id="pdt_qtt" name="pdt_qtt" readonly></td>
				<td><input type="text" id="pdt_price" name="pdt_price" readonly></td>
				<td><input type="text" id="mile" name="mile" readonly></td>
				<td>
					<input type="text" id="total_price" name="total_price" readonly>
					<input type="hidden" id="total" name="total" readonly> <!-- 넘어가는 total price -->
				</td>
				<td>
					<input type="text" id="deli_price" name="deli_price" readonly><br>
					<input type="text" id="deli_kind" name="deli_kind" readonly><br>
					<input type="text" id="deli_condition" name="deli_condition" readonly>
				</td>
			</tr>
			</tbody>
		</table>

	<div class="pre_order_box">
		<div class="box1">
		총 #개의 상품금액 <br>
		###원
		</div>
		<div class="box2">
		배송비<br>
		###원
		</div>
		<div class="box3">
		합계 <br>
		####원<br>
		적립예정 마일리지: ##원
		</div>
	</div>
	<div class="pre_order_btn">
		<div class="pre_order_info"></div>
		<input type="submit" value="결제" id="order_btn">
	</div>
	</form>
</div>

<jsp:include page="/resources/include/footer.jsp"/>
	