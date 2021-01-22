<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송지 추가</title>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="<c:url value="/resources/js/jquery-1.12.4.min.js" />" type="text/javascript" ></script>
<script src="<c:url value="/resources/js/common.js" />" type="text/javascript" ></script>
<script>
$(function(){
	
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
</head>

<body>
<div class="wrapper">
<table>
	<tr>
		<td>배송지 이름</td>
		<td><input type="text" id="addr_name"></td>
	</tr>
	<tr>
		<td>받으실 분</td>
		<td><input type="text" id="addr_receiver"></td>
	</tr>
	<tr>
		<td>받으실 곳</td>
		<td><input type="text" id="zipcode">
			<input type="button" value="우편번호검색" onclick="execPostCode()">
		</td>
	</tr>
	<tr>
		<td></td>
		<td><input type="text" id="addr1"></td>
	</tr>
	<tr>
		<td></td>
		<td><input type="text" id="addr2"></td>
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
<input type="button" value="저장" id="addr_save" onclick="addr_save()">
</div>
</body>
</html>