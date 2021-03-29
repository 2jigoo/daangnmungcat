<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}">
<title>배송지 목록</title>
<link rel="stylesheet" href="<c:url value="/resources/css/common.css"/>">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="<c:url value="/resources/js/jquery-1.12.4.min.js" />" type="text/javascript" ></script>
<script src="<c:url value="/resources/js/common.js" />" type="text/javascript" ></script>
<script>
//주소 api
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

$(document).ready(function(){
	
	//spring security -> ajax post 타입 전송시 필요
	var csrfToken = $("meta[name='_csrf']").attr("content");
	$.ajaxPrefilter(function(options, originalOptions, jqXHR){
	    if (options['type'].toLowerCase() === "post") {
	        jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
	    }
	});
	
	$.get("/address-list", function(list){
		var datalength = list.length; 
		
		if(datalength >= 1){
			var sCont = "";
			for(i=0; i<datalength; i++){
				sCont += '<tbody>';
				sCont += '<tr><td><input type="button" value="선택" class="pre_order_btn2" id="sel_add" aid="' + list[i].id +'"></td>';
				sCont += '<td>' + list[i].subject + '</td>' ;
				sCont += '<td>' + list[i].name + '</td>';
				sCont += '<td>(' + list[i].zipcode +') <br>' + list[i].address1 + ', ' +  list[i].address2 + '<br> 배송메모 : ' + list[i].memo + '</td>';
				sCont += '<td>' + list[i].phone1 + '<br>' + list[i].phone2 +'</td>';
				sCont += '<td><input type="button" value="수정" id="update_addr" class="pre_order_btn2" addrId=' + list[i].id;
				sCont += '> <input type="button" value="삭제" id="delete_addr" class="pre_order_btn2" addrId=' + list[i].id + '></td>';
				sCont += '</tr>';
				sCont += '</tbody>';
			}
			$("#addr").append(sCont);
		}else if(datalength == 0){
			var t = '<tr><td colspan="6" style="padding:80px">배송지 목록이 없습니다.</td></tr>';
			$("#addr").append(t);
			
		}
	});
	
	$(document).on('click', '[id=sel_add]', function(){
		var aid = $(this).attr('aid');
		$.get("/address/"+aid, function(addr){
			console.log(addr);
			$('#zipcode', parent.opener.document).prop('value', addr.zipcode);
			$('#address1', parent.opener.document).prop('value', addr.address1);
			$('#address2', parent.opener.document).prop('value', addr.address2);
			$('#phone1', parent.opener.document).prop('value', addr.phone1);
			$('#phone2', parent.opener.document).prop('value', addr.phone2);
			$('#memo', parent.opener.document).prop('value', addr.memo);
			$('#order_name', parent.opener.document).prop('value', addr.name);
		});
		setTimeout(function(){
		    self.close();
		},300);
	});
	
	$(document).on('click', '[id=update_addr]', function(){
		var num = $(this).attr('addrId');
		location.href= "/mall/order/mall_shipping_update?id="+num; 
	});

	$(document).on('click', '[id=delete_addr]', function(){
		var num = $(this).attr('addrId');
		$.get("/address/" + num, function(add){
			if (confirm("["+ add.subject + "] 배송지를 삭제하시겠습니까?") == true){
				$.get("/address/get/" + num, function(){
					location.reload(true);
				});
			}else{
				return;
			}
		});
	});
	
});


</script>
<style>
.wrapper {margin:0 auto; padding:30px; margin-bottom:50px;}
.wrapper input{font-family:'S-CoreDream'; margin:2px 2px;}
#addr tr td:nth-child(5) {text-align:left;}
</style>
</head>
<body>
<div class="wrapper">
<h3 class="tc">배송지 관리</h3>

<div class="addr_btns">
	<input type="button" value="+새 배송지추가" id="add_addr" class="pre_order_btn3" style="padding:10px"onclick="location.href='/mall/order/mall_shipping_add'">
</div>

<table id="addr">
	<colgroup>
		<col width=5%>
		<col width=12%>
		<col width=12%>
		<col width=37%>
		<col width=18%>
		<col width=15%>
	</colgroup>
	<thead>
		<tr>
			<th></th><th>배송지명</th> <th>받으실 분</th> <th>주소</th> <th>연락처</th> <th>수정/삭제</th>
		</tr>
	</thead>
	
</table>
<p id="txt" style="padding:30px;" class="tc"></p>
   </div>

</body>
</html>