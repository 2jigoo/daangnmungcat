<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<style>
.wrapper {margin:0 auto; padding:80px; text-align:center; margin-bottom:250px;}
.wrapper input{font-family:'S-CoreDream'; margin:2px 2px;}
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
	
	<div class="confirm_noti">
		회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인해 주세요.
	</div>
	<div class="confirm_info">
	아이디 <span style="color:#ff7e15; font-weight:bold; margin-right:10px;">${loginUser.getId()}</span> 
	비밀번호 <input type="password" id="pwd" style="width:200px">
	</div>
	
	<div class="confirm_btns">
		<input type="button" id="cancel" value="취소" onclick="history.back()"  class="go_list" style="padding:8px; background-color:#676767; font-size:15px; width:100px;">
		<input type="button" id="pwd_confirm" value="인증하기" class="go_list" style="padding:8px; font-size:15px; width:100px;">
	</div>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>