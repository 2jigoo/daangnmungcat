<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>
<style>
.wrapper {margin:0 auto; padding:50px; text-align:center}
</style>
<script>
$(function(){
	var contextPath = "<%=request.getContextPath()%>";
	
	$('#pwd_confirm').on("click", function(){
		$.get(contextPath +"/member/info", function(member){
			console.log(member)
			var pwd = $('#pwd').val();
			if(pwd == member.member.pwd){
				window.location.href= contextPath+'/mypage/mypage_info';
			}else {
				alert('비밀번호가 맞지 않습니다.');	
			}
		});
	});
});
</script>
<div class="wrapper">
	<h2 id="subTitle">회원 정보 변경</h2>
	회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인해 주세요.
	<div>
	아이디: ${loginUser.getId()} 비밀번호: <input type="password" id="pwd">
	</div>
	<div>
	<input type="button" id="cancel" value="취소">
	<input type="button" id="pwd_confirm" value="인증하기">
	</div>
</div>
<jsp:include page="/resources/include/footer.jsp"/>