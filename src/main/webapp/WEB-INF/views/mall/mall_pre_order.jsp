<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>

<script>
$(document).ready(function(){
	var data = $('#form').serialize();
	console.log(data);
	$.get("/pre-order", function(json){
		var total = json.total;
		var qtt = json.qtt;
		var pdt = json.pdt;
		var mem = json.member;
		$('#pdt_id').attr('value', pdt.id);
		$('#pdt_name').attr('value', pdt.name);
		$('#pdt_qtt').attr('value', qtt);
		$('#total').attr('value', total);
		$('#mem_id').attr('value', mem.id);
		
	});
	
	
});

</script>
${loginUser.getId()}
개당 금액: ${pdt.price} <br>
총금액: ${total} <br>
수량 : ${qtt} <br> 
정보: ${pdt } <br>
<form method="post" id="form" action="/kakao-pay" enctype="multipart/form-data" accept-charset="utf-8">
	<table>
		<tr>
			<td><input type="text" name="${_csrf.parameterName}" value="${_csrf.token}" ></td>
		</tr>
		<tr>
			<td>이름:</td>
			<td><input type="text" id="pdt_name" name="pdt_name"></td>
		</tr>
		<tr>
			<td>product id:</td>
			<td><input type="text" id="pdt_id" name="pdt_id"></td>
		</tr>
		<tr>
			<td>수량:</td>
			<td><input type="text" id="pdt_qtt" name="pdt_qtt"></td>
		</tr>
		<tr>
			<td>총금액</td>
			<td><input type="text" id="total" name="total"></td>
		</tr>
		<tr>
			<td></td>
			<td><input type="text" id="mem_id" name="mem_id"></td>
		</tr>
		<tr>
			<td></td>
			<td><input type="submit" value="제출"></td>
		</tr>
	</table>
</form>
<img id="payment" src="<%=request.getContextPath() %>/resources/images/ico_payment.png" >


<jsp:include page="/resources/include/footer.jsp"/>
	