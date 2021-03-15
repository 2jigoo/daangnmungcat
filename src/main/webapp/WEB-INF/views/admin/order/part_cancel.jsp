<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}">
<title>부분취소</title>
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">

<style>
.kakao_cancel_title {padding:10px; text-align:center}
.kakao_cancel_btn {padding:30px; text-align:center;}
#cancel_info {width:80%; margin:0 auto; padding:20px;}
#cancel_info td{border-top:1px solid black; border-bottom:1px solid black; padding:10px}
</style>
<script>
$(document).ready(function(){
	
	var csrfToken = $("meta[name='_csrf']").attr("content");
	$.ajaxPrefilter(function(options, originalOptions, jqXHR){
	    if (options['type'].toLowerCase() === "post") {
	        jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
	    }
	});
	
	$('#all_check').on('click', function(){
		var price = $('#price').text();
		console.log(price)
		if($('#all_check').is(':checked')){
			$('#cancel_price').attr('value', price);
		}else{
			$('#cancel_price').attr('value', '');
	    }
	});
	
	$('#cancel_btn').on('click', function(){
		var pay_id = getParameterByName('tid');
		var price = $('#cancel_price').val();
		var order_id = ${order.id};
		var member = $('#member_id').val();
		
		var data = {
				tid: pay_id, 
				partner_order_id: order_id,
				partner_user_id: member,
				cancel_amount: price
			};
			
		console.log(data);
		if(price == ""){
			alert('취소할 금액을 입력하세요.')
		}else {
			if(confirm(price + '원을 부분취소하시겠습니까?') == true){
				//post 전송
				$.ajax({
					url: '/kakao-part',
					type: "post",
					contentType: "application/json; charset=utf-8",
					data : JSON.stringify(data),
					success: function() {
						alert('주문 취소 완료');
						window_close();
						opener.document.location.reload(true);
					},
					error: function(request,status,error){
						alert('에러' + request.status+request.responseText+error);
					}
				});
				
			}else{
				return;
			}	
		}
		
	});
	
	
});

function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
            results = regex.exec(location.search);
    return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}


function window_close(){
	this.close();
}


</script>
</head>

<body>
<div class="kakao_cancel_title"><span style="font-size:20px;">카카오페이 부분취소</span></div>
<table id="cancel_info">
	<tr>
		<td>취소 가능한 금액: </td>
		<td><span id="price">${kakao.cancel_available_amount.total}</span></td>
	<tr>
		<td>취소할 금액: </td>
		<td>
			<input type="hidden" value="${order.member.id}" id="member_id">
			<input type="checkbox" id="all_check"> 전체 금액<br> 
			<input type="text" id="cancel_price" name="cancel_price">
		</td>
</table>
	<div class="kakao_cancel_btn">
		<input type="button" value="확인" id="cancel_btn" class="btn btn-primary btn-sm">
		<input type="button" value="닫기" onClick="window_close()" class="btn btn-secondary btn-sm">
	</div>	

</body>
</html>