<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>

<script>
//주소 api
function execDaumPostcode(){
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
<table>
		<tr>
			<td>우편번호</td>
			<td><input type="text" id="zipcode">
				<input type="button" value="우편번호검색" onclick="execDaumPostcode()">
			</td>
		</tr>
		<tr>
			<td>주소</td>
			<td><input type="text" id="addr1"><input type="text" id="addr2" placeholder="상세주소"></td>
		</tr>
</table>



<jsp:include page="/resources/include/footer.jsp"/>