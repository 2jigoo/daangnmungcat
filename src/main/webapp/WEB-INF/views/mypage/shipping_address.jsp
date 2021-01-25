<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>
<style>
.wrapper {margin:0 auto; padding:50px; text-align:center}
table {width:800px; margin:0 auto;}

</style>
<script>
$(document).ready(function(){
	var contextPath = "<%=request.getContextPath()%>";
	
	$(document).on('click', '[id=update_addr]', function(){
		var num = $(this).attr('addrId');
		window.open(contextPath+"/shipping_update?id="+num, "", "width=600, height=500, left=100, top=50 ,location=no, directoryies=no, resizable=no, scrollbars=yes");
	});

	$(document).on('click', '[id=delete_addr]', function(){
		var num = $(this).attr('addrId');
		$.get(contextPath +"/addressInfo/" + num, function(add){
			if (confirm("["+ add.subject + "] 배송지를 삭제하시겠습니까?") == true){
				$.get(contextPath +"/deleteShippingAddress/" + num, function(){
					location.reload(true);
				});
			}else{
				return;
			}
		});
	});
	
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
<input type="button" value="배송지추가" id="add_addr">
<table id="addr">
	<tr>
		<td>배송지이름</td> <td>받으실 분</td> <td>주소</td> <td>연락처</td> <td>수정/삭제</td>
	</tr>
	<c:forEach var="add" items="${list}">
		<tr>	
				<td>${add.subject} <input type="hidden" value="${add.id}"></td>
				<td>${add.name}</td>
				<td>(${add.zipcode}) ${add.address1} ${add.address2}</td>
				<td>${add.phone}</td>
				<td>
					<input type="button" value="수정" id="update_addr" addrId="${add.id}">
					<input type="button" value="삭제" id="delete_addr" addrId="${add.id}">
				</td>
		</tr>
	</c:forEach>
</table>

   </div>


<jsp:include page="/resources/include/footer.jsp"/>