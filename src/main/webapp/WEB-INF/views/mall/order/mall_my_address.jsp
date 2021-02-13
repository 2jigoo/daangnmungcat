<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}">
<title>배송지 목록</title>

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
				sCont += '<tr><td><input type="button" value="선택" id="sel_add" aid="' + list[i].id +'"></td>';
				sCont += '<td>' + list[i].subject + '</td>' ;
				sCont += '<td>' + list[i].name + '</td>';
				sCont += '<td>' + (list[i].zipcode) + ' ' + list[i].address1 + list[i].address2 + '</td>';
				sCont += '<td>' + list[i].phone + '</td>';
				sCont += '<td><input type="button" value="수정" id="update_addr" addrId=' + list[i].id;
				sCont += '> <input type="button" value="삭제" id="delete_addr" addrId=' + list[i].id + '></td>';
				sCont += '</tr>';
			}
			$("#addr").append(sCont);
		}else if(datalength == 0){
			var t = '배송지 목록이 없습니다.';
			$("#txt").append(t);
		}
	});
	
	$(document).on('click', '[id=sel_add]', function(){
		var aid = $(this).attr('aid');
		$.get("/address/"+aid, function(addr){
			console.log(addr);
			$('#zipcode', parent.opener.document).attr('value', addr.zipcode);
			$('#address1', parent.opener.document).attr('value', addr.address1);
			$('#address2', parent.opener.document).attr('value', addr.address2);
			$('#address2', parent.opener.document).attr('value', addr.address2);
			$('#order_name', parent.opener.document).attr('value', addr.name);
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
</head>
<body>
<div class="wrapper">
<h2 id="subTitle">배송지 관리</h2>
<input type="button" value="배송지추가" id="add_addr" onclick="location.href='/mall/order/mall_shipping_add'">
<table id="addr">
	<tr>
		<td></td><td>배송지이름</td> <td>받으실 분</td> <td>주소</td> <td>연락처</td> <td>수정/삭제</td>
	</tr>
	
</table>
<p id="txt" style="padding:30px"></p>
   </div>

</body>
</html>