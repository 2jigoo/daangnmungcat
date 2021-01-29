<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>

<script>
$(document).ready(function(){
	var data = $('#form').serialize();
	console.log(data);
	
});

</script>
${loginUser.getId()}
개당 금액: ${pdt.price} <br>
총금액: ${total} <br>
수량 : ${qtt} <br> 
정보: ${pdt } <br>
<form method="post" id="form" action="/kakao-pay" enctype="multipart/form-data" accept-charset="utf-8">
	<input type="text" name="${_csrf.parameterName}" value="${_csrf.token}" >
	<input type="text" name="pdt_name" value="${pdt.name}">
	<input type="text" name="pdt_id" value="${pdt.id}">
	<input type="text" name="pdt_qtt" value="${qtt}">
	<input type="text" name="total" value="${total}">
	<input type="text" name="mem_id" value="${loginUser.getId()}">
	<input type="submit" value="제출">
</form>
<img id="payment" src="<%=request.getContextPath() %>/resources/images/ico_payment.png" >


<jsp:include page="/resources/include/footer.jsp"/>
	