<%@page import="daangnmungcat.dto.Address"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<style>
.wrapper {margin:0 auto; padding:70px; text-align:center;  margin-bottom:80px;}

</style>
<script>
$(document).ready(function(){
	$('#col').hide();
	
	var contextPath = "<%=request.getContextPath()%>";
	$.get(contextPath +"/address-list", function(list){
		var datalength = list.length; 
		
		if(datalength >= 1){
			var sCont = "";
			for(i=0; i<datalength; i++){
				sCont += '<tr><td>' + list[i].subject + '<input type="hidden" value=' + list[i].id +'></td>' ;
				sCont += '<td>' + list[i].name + '</td>';
				sCont += '<td>(' + list[i].zipcode +') <br>' + list[i].address1 + ', ' +  list[i].address2 + '<br> 배송메모 : ' + list[i].memo + '</td>';
				sCont += '<td>전화번호 : ' + list[i].phone1 + '<br>휴대폰 : ' + list[i].phone2 +'</td>';
				sCont += '<td><input type="button" value="수정" id="update_addr" class="pre_order_btn2" style="width:50px;" addrId=' + list[i].id;
				sCont += '> <input type="button" value="삭제" id="delete_addr" class="pre_order_btn2" style="width:50px;" addrId=' + list[i].id + '></td>';
				sCont += '</tr>';
			}
			$("#mypage_addr_main").append(sCont);
		}else if(datalength == 0){
			$('#col').show();
			
		}
	});
	
	
	
	$(document).on('click', '[id=update_addr]', function(){
		var num = $(this).attr('addrId');
		window.open(contextPath+"/mypage/shipping_update?id="+num, "", "width=650, height=520, left=100, top=50 ,location=no, directoryies=no, resizable=no, scrollbars=yes");
	});

	$(document).on('click', '[id=delete_addr]', function(){
		var num = $(this).attr('addrId');
		console.log(num)
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
		window.open(contextPath+"/mypage/shipping_add", "", "width=650, height=520, left=100, top=50 ,location=no, directoryies=no, resizable=no, scrollbars=yes");
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
<div class="mypage_addr_btns">
	<input type="button" value="+새 배송지추가" id="add_addr" class="go_list" style="font-size:15px;">
</div>

<table id="mypage_addr_main">
	<colgroup>
			<col width=10%>
			<col width=12%>
			<col width=37%>
			<col width=18%>
			<col width=15%>
	</colgroup>
	<thead>
		<tr>
			<th>배송지이름</th> <th>받으실 분</th> <th>주소</th> <th>연락처</th> <th>수정/삭제</th>
		</tr>
	</thead>
	<tbody>
		<tr id="col">
			<td colspan="5" style="padding:50px;">배송지 목록이 없습니다.</td>
		</tr>
	</tbody>
	
</table>

   </div>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>