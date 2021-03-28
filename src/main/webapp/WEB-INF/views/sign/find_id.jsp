<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<style>
.wrapper {margin:0 auto; padding:70px; magin-bottom:70px;}
</style>
<script>
$(document).ready(function() {
	$('input[name=find_type]').change(function(){
		if($('input[name=find_type]:input[value="휴대폰"]').is(':checked') == true){
			$('#type').prop('placeholder', '휴대폰')
		} else {
			$('#type').prop('placeholder', '이메일')
		}
	})
	
	$('#find').on('click', function(){
		var data = {
			name: $('#name').val(),
			email: $('#type').val()		
		}
		
		$.ajax({
			url:  "/find-id",
			type: "POST",
			contentType:"application/json; charset=utf-8",
			dataType: "json",
			cache : false,
			data : JSON.stringify(data),
			success: function(res) {
				if(res == 1){
					alert('존재')
				} else {
					alert('ㄴㄴ')
				}
			},
			error: function(request,status,error){
				alert('에러' + request.status+request.responseText+error);
				
			}
		});
		
	});
	
});
</script>
<div class="wrapper">
	<div>
		<div>회원 아이디 찾기</div> 
		<input type="text" placeholder="이름" name="name" id="name"> <Br>
		<input type="text" placeholder="이메일" id="type" name="type">
	</div>
	<div>
		<input type="button" value="아이디찾기" id="find">
	</div>

</div>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>