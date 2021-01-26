<%@page import="daangnmungcat.dto.Address"%>
<%@page import="java.util.List"%>
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
	$.get(contextPath +"/address-list", function(list){
		var datalength = list.length; 
		if(datalength >= 1){
			var sCont = "";
			for(i=0; i<datalength; i++){
				sCont += '<tr><td>' + list[i].subject + '<input type="text" value=' + list[i].id +'></td>' ;
				sCont += '<td>' + list[i].name + '</td>';
				sCont += '<td>' + (list[i].zipcode) + ' ' + list[i].address1 + list[i].address2 + '</td>';
				sCont += '<td>' + list[i].phone + '</td>';
				sCont += '<td><input type="button" value="수정" id="update_addr" addrId=' + list[i].id;
				sCont += '> <input type="button" value="삭제" id="delete_addr" addrId=' + list[i].id + '></td>';
				sCont += '</tr>';
			}
			$("#addr").append(sCont);
		}
	});
	
	
	
	$(document).on('click', '[id=update_addr]', function(){
		var num = $(this).attr('addrId');
		window.open(contextPath+"/mypage/shipping_update?id="+num, "", "width=600, height=500, left=100, top=50 ,location=no, directoryies=no, resizable=no, scrollbars=yes");
	});

	$(document).on('click', '[id=delete_addr]', function(){
		var num = $(this).attr('addrId');
		$.get(contextPath +"/address/" + num, function(add){
			if (confirm("["+ add.subject + "] 배송지를 삭제하시겠습니까?") == true){
				$.get(contextPath +"/address/get/" + num, function(){
					location.reload(true);
				});
			}else{
				return;
			}
		});
	});
	
	$('#add_addr').on("click", function(){
		window.open(contextPath+"/mypage/shipping_add", "", "width=600, height=500, left=100, top=50 ,location=no, directoryies=no, resizable=no, scrollbars=yes");
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
<h2 id="subTitle">배송지 관리</h2>
<input type="button" value="배송지추가" id="add_addr">
<table id="addr">
	<tr>
		<td>배송지이름</td> <td>받으실 분</td> <td>주소</td> <td>연락처</td> <td>수정/삭제</td>
	</tr>
	
</table>

   </div>


<jsp:include page="/resources/include/footer.jsp"/>