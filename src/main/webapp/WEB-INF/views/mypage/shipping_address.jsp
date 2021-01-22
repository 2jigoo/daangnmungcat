<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>
<style>
.wrapper {margin:0 auto; padding:50px; text-align:center}
table {width:800px; margin:0 auto;}

</style>
<script>
$(function(){
	var contextPath = "<%=request.getContextPath()%>";
	
	$('#add_addr').on("click", function(){
		window.open(contextPath+"/shipping_popup", "", "width=600, height=500, left=100, top=50 ,location=no, directoryies=no, resizable=no, scrollbars=yes");
	});
	
});


function window_close(){
	this.close();
	opener.document.location.reload(true);
}

function addr_save(){
	console.log('추가하기')
}
//주소 api
function execPostCode(){
	daum.postcode.load(function(){
        new daum.Postcode({
            oncomplete: function(data) {
				//변수값 없을때는 ''
				var addr = '';
				$('#zipcode').attr('value', data.zonecode);
				$('#addr1').attr('value', data.address);
            	}
            }).open();
    });
}


</script>


<div class="wrapper">
<input type="button" id="add_addr" value="배송지추가" style="text-align:left">

<table>
	<tr>
		<td>배송지이름</td> <td>받으실 분</td> <td>주소</td> <td>연락처</td> <td>수정/삭제</td>
	</tr>
	<tr id="addr">
	</tr>
	
</table>

   </div>


<jsp:include page="/resources/include/footer.jsp"/>