<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>

<script>
$(document).ready(function(){
	var contextPath = "<%=request.getContextPath()%>";

	
	/* $('#od_qtt').on('keyup', function(){
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
	}); */
	
	/* $('#order_btn').on('click', function(){
		var total = $('#price').val();
		var qtt = $('#od_qtt').val();
		var id = ${pdt.id};
		console.log('total: ' + total);
		console.log('qtt: ' + qtt);
		console.log('id: ' + id);
		var info = {
			total_price: total,
			quantity: qtt,
			m_id : id
			}
		
		$.ajax({
			url: contextPath + "/pre-order",
			type: "post",
			contentType:"application/json; charset=utf-8",
			dataType: "text", //json200에러뜰때 text로
			cache : false,
			data : JSON.stringify(info),
			success: function() {
				console.log('이동')
			},
			error: function(request,status,error){
				alert('에러' + request.status+request.responseText+error);
			}
		});
	}); */
	
	
});


function deleteCartItem(cart_id) {
	$.ajax({
		url: "/mall/cart",
		type: "delete",
		contentType:"application/json; charset=utf-8",
		dataType: "text", //json200에러뜰때 text로
		cache : false,
		data : JSON.stringify({id: cart_id}),
		success: function(data) {
			console.log(data);
		},
		error: function(error){
			console.log(error);
		}
	});
}

</script>

<div id="subContent">
	<div id="pageCont" class="s-inner">
		<table>
			<thead>
				<tr>
					<th>상품번호</th>
					<th>상품썸네일</th>
					<th>상품이름</th>
					<th>금액</th>
					<th>수량</th>
					<th>합계</th>
					<th>배송비</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="cart" items="${list }">
					<tr>
						<td>${cart.product.id }</td>
						<td>
							<c:if test="${cart.product.image1 eq null}"><img src="/resources/images/no_image.jpg" width=80px;></c:if>
							<c:if test="${cart.product.image1 ne null}"><img src="/resources${pdt.image1}" width=80px;></c:if>
						</td>
						<td>${cart.product.name }</td>
						<td>${cart.product.price }</td>
						<td>
							<div class="length">
								<p>수량</p>
								<div>
									<p class="down"><span class="text_hidden">감소</span></p>
									<input type="text" value="${cart.quantity }" id="od_qtt">
									<p class="up"><span class="text_hidden">증가</span></p>
								</div>
							</div>
						</td>
						<td>
							<!-- 백엔드에서 합계 구하는 로직 아직 X -->
							<%-- ${cart.amount } --%>
							${cart.product.price * cart.quantity } 원
							<%-- <div class="totalPrice">
								<p><span id="od_price"><fmt:formatNumber value="${pdt.price}" /></span> 원</p>
								<p><input type="hidden" value="${pdt.price}" id="price" onchange="comma(${pdt.price})"></p>
							</div> --%>
						</td>
						<td>
							${cart.product.deliveryKind}
							<c:if test="${cart.product.deliveryKind eq '조건부 무료배송'}">
								<br><fmt:formatNumber value="${cart.product.deliveryPrice}"/>원(<fmt:formatNumber value="${cart.product.deliveryCondition}"/>원 이상 구매 시 무료배송)
							</c:if>
							<c:if test="${cart.product.deliveryKind eq '유료배송'}">
								<br><fmt:formatNumber value="${cart.product.deliveryPrice}"/>원
							</c:if>
						</td>
						<td>
							<button cart-no="${cart.id }" onclick="deleteCartItem(${cart.id})">삭제</button>
						</td>
					</tr>		
				</c:forEach>	
			</tbody>
		</table>
	</div>
</div>

<jsp:include page="/resources/include/footer.jsp"/>