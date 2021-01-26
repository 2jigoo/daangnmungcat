<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}">
<title>배송지 수정</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="<c:url value="/resources/js/jquery-1.12.4.min.js" />" type="text/javascript" ></script>
<script src="<c:url value="/resources/js/common.js" />" type="text/javascript" ></script>

<%  
	String id = request.getParameter("id");
	request.setAttribute("id", id);
%>

<script>


$(function(){
	var csrfToken = $("meta[name='_csrf']").attr("content");
	console.log(csrfToken);
	$.ajaxPrefilter(function(options, originalOptions, jqXHR){
	    if (options['type'].toLowerCase() === "post") {
	        jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
	    }
	});
	
	var id;
	var contextPath = "<%=request.getContextPath()%>";
	
	$.get(contextPath +"/member/info", function(member){
		id = member.member.id;
	});
	
	$('#addr_phone').keyup(function(){
		$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );
	});

	
	$.get(contextPath +"/address/" + ${id}, function(add){
		$('#addr_subject').attr('value', add.subject);
		$('#addr_name').attr('value', add.name);
		$('#zipcode').attr('value', add.zipcode);
		$('#address1').attr('value', add.address1);
		$('#address2').attr('value', add.address2);
		$('#addr_phone').attr('value', add.phone);
		$('#addr_memo').attr('value', add.memo);
	
	});
	
	
	$('#addr_update').on("click", function(){
		if($('#addr_subject').val() == ""){
			alert('배송지명을 입력하세요');
			return;
		}else if($('#addr_name').val() == ""){
			alert('받으실 분을 입력하세요.');
			return;
		}else if($('#zipcode').val() == ""){
			alert('우편번호를 입력하세요');
			return;
		}else if($('#address1').val() == ""){
			alert('주소를 입력하세요');
			return;
		}else if($('#addr_phone').val() == ""){
			alert('전화번호를 입력하세요');
			return;ㄴ
		}else if($('#address2').val() == ""){
			alert('상세주소를 입력하세요');
			return;
		}else {
			var add = {
					memId: id,
					subject: $('#addr_subject').val(),
					name: $('#addr_name').val(),
					phone: $('#addr_phone').val(),
					zipcode: $('#zipcode').val(),
					address1: $('#address1').val(),
					address2: $('#address2').val(),
					memo: $('#addr_memo').val()
				}
				
				
				if($('#default_addr').is(":checked") == true){
					if (confirm("입력하신 주소를 기본 배송지로 설정하시겠습니까?") == true){
						var member = {
								zipcode: $('#zipcode').val(),
								address1: $('#address1').val(),
								address2: $('#address2').val()
							}
						
						$.ajax({
							url: contextPath + "/member/adddress/post",
							type: "POST",
							contentType:"application/json; charset=utf-8",
							dataType: "json",
							cache : false,
							data : JSON.stringify(member),
							success: function(res) {
									if(res == 1){
										alert('기본 주소로 변경완료')
									}
							},
							error: function(request,status,error){
								alert('에러' + request.status+request.responseText+error);
							}
						});
						
					}else{
						return;
					}
				}
			
				$.ajax({
					url: contextPath + "/address/post/"+${id},
					type: "POST",
					contentType:"application/json; charset=utf-8",
					dataType: "json",
					cache : false,
					data : JSON.stringify(add),
					success: function() {
						alert('배송지 수정 완료');
						opener.document.location.reload(true);
					},
					error: function(request,status,error){
						alert('에러' + request.status+request.responseText+error);
					}
				});
		}
		
		});
});


function window_close(){
	this.close();
	opener.document.location.reload(true);
}

//주소 api
function execPostCode(){
	daum.postcode.load(function(){
        new daum.Postcode({
            oncomplete: function(data) {
				//변수값 없을때는 ''
				var addr = '';
				zipcode = data.zonecode; 
				$('#zipcode').attr('value', data.zonecode);
				$('#address1').attr('value', data.address);
				
            	}
            }).open();
    });
}

</script>
</head>

<body>

<div class="wrapper">
<table>
	<tr>
		<td>배송지 이름</td>
		<td><input type="text" id="addr_subject"></td>
	</tr>
	<tr>
		<td>받으실 분</td>
		<td><input type="text" id="addr_name"></td>
	</tr>
	<tr>
		<td>받으실 곳</td>
		<td><input type="text" id="zipcode">
			<input type="button" value="우편번호검색" onclick="execPostCode()">
		</td>
	</tr>
	<tr>
		<td></td>
		<td><input type="text" id="address1"></td>
	</tr>
	<tr>
		<td></td>
		<td><input type="text" id="address2"></td>
	</tr>
	<tr>
		<td>전화번호</td>
		<td><input type="text" id="addr_phone"></td>
	</tr>
	<tr>
		<td>배송 메모</td>
		<td><input type="text" id="addr_memo"></td>
	</tr>
	<tr>
		<td></td>
		<td><input type="checkbox" id="default_addr">기본 배송지로 설정합니다.</td>
	</tr>
</table>
<input type="button" value="취소" id="cancel" onclick="window_close()">
<input type="button" value="수정" id="addr_update">
</div>
</body>
</html>