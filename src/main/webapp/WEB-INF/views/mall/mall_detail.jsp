<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>

<script>
var product_id;

$(document).ready(function(){
	var contextPath = "<%=request.getContextPath()%>";

	product_id = ${pdt.id};
	
	$('#od_qtt').on('keyup', function(){
		var price = ${pdt.price};
		var qtt = $('#od_qtt').val();
		var total = price * qtt; 
		$('#od_price').html(total.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","));
		$('#price').attr('value', total);
		
	});
	
	$('.down').on('click', function(){
		var price = ${pdt.price};
		var qtt = $('#od_qtt').val();
		var total = price * qtt; 
		$('#od_price').html(total.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","));
		$('#price').attr('value', total);
	});
	
	$('.up').on('click', function(){
		var price = ${pdt.price};
		var qtt = $('#od_qtt').val();
		var total = price * qtt; 
		$('#od_price').html(total.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","));
		$('#price').attr('value', total);
	});
	
	$('#order_btn').on('click', function(){
		$('#form').submit();
	});
	
});


//카트에 추가하기
function addCart() {
	var cart = {
			product: {id: product_id},
			quantity: $('#od_qtt').val()
	}
	
	console.log(cart);
	
	$.ajax({
		url: "/mall/cart",
		type: "post",
		contentType:"application/json; charset=utf-8",
		dataType: "text",
		cache : false,
		data : JSON.stringify(cart),
		success: function(res) {
			var confirm_res = confirm("장바구니에 담았습니다. 장바구니로 이동하겠습니까?");
			if(confirm_res == true) {
				location.href = "/mall/cart/list";
			}
		},
		error: function(error){
			console.log(error);
		}
	});
}

</script>
<form action="/mall/pre-order/single" method="post" id="form">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" >

<div id="subContent">
	<div id="pageCont" class="s-inner">
		<div class="product_detail">
			<div class="detail_info">
				<div class="img_box">
					<c:if test="${empty pdt.image1}"><img src="<%=request.getContextPath() %>/resources/images/no_image.jpg"></c:if>
					<c:if test="${not empty pdt.image1}"><img src="<c:url value="/resources${pdt.image1}" />"></c:if>
				</div>
				<div class="txt_box">
					<input type="hidden" value="${pdt.id }" name="id" id="pdt_id">
					<p class="name">${pdt.name}</p>
					<p class="content">${pdt.content}</p>
					<dl>
						<dt>가격</dt>
						<dd><fmt:formatNumber value="${pdt.price}"/>원</dd>
						<dt>배송비 유형</dt>
						<dd>
							${pdt.deliveryKind}
							<c:if test="${pdt.deliveryKind eq '조건부 무료배송'}">
							<br><fmt:formatNumber value="${pdt.deliveryPrice}"/>원(<fmt:formatNumber value="${pdt.deliveryCondition}"/>원 이상 구매 시 무료배송)
							</c:if>
							<c:if test="${pdt.deliveryKind eq '유료배송'}">
							<br><fmt:formatNumber value="${pdt.deliveryPrice}"/>원
							</c:if>
						</dd>
					</dl>
					<div class="length">
						<p>수량</p>
						<div>
							<p class="down"><span class="text_hidden">감소</span></p>
							<input type="text" value="1" id="od_qtt" name="quantity">
							<p class="up"><span class="text_hidden">증가</span></p>
						</div>
					</div>
					<div class="totalPrice">
						<p>총 금액</p>
						<p><span id="od_price"><fmt:formatNumber value="${pdt.price}" /></span> 원</p>
					</div>
					<ul class="btn">
						<li><a href="#" onclick="addCart()">장바구니</a></li>
						<li><a href="#" id="order_btn">바로구매</a></li>
					</ul>
				</div>
			</div>
			<div class="detail_view">
				<c:if test="${not empty pdt.image2}"><img src="<c:url value="/resources${pdt.image2}" />"></c:if>
				<c:if test="${not empty pdt.image3}"><img src="<c:url value="/resources${pdt.image3}" />"></c:if>
			</div>
		</div>
	</div>
</div>
</form>
<jsp:include page="/resources/include/footer.jsp"/>