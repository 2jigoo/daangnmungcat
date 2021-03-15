<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<style>
.wrapper {margin:0 auto; padding:50px; text-align:center}
</style>
<script>
$(function(){
	var contextPath = "<%=request.getContextPath()%>";
	
	$('#pwd_confirm').on("click", function(){
		var pwd = JSON.stringify({pwd: $('#pwd').val()});
		
			$.ajax({
				url: contextPath + "/member/checkPwd",
				type: "POST",
				data: pwd,
				contentType: "application/json",
				success: function(res) {
					if(res == true) {
						location.href = "/mypage/mypage_info";
					}
				},
				error: function(e) {
					alert("비밀번호가 일치하지 않습니다.");
				}
			});
	});
});
</script>
<div class="wrapper">
	<h2 id="subTitle">회원정보 변경</h2>
	회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인해 주세요.
	<div>
	아이디: ${loginUser.getId()} 비밀번호: <input type="password" id="pwd">
	</div>
	<div>
	<input type="button" id="cancel" value="취소" onclick="history.back()">
	<input type="button" id="pwd_confirm" value="인증하기">
	</div>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>