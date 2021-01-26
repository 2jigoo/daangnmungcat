<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>
<style>
.wrapper {margin:0 auto; padding:50px; text-align:center}
.box {text-align:left; padding:100px;}
#withdraw-table {width:800px; padding:30px;}
</style>
<script>
$(document).ready(function(){
	var contextPath = "<%=request.getContextPath()%>";
	var id;
	
	$.get(contextPath +"/member/info", function(member){
		id = member.member.id;
	});
	
	$('#del').on("click", function(){
		var pwd = $('#w_pwd').val();
		if(pwd == ""){
			alert('비밀번호를 입력하세요.')
		}else {
			if(confirm('탈퇴하시겠습니까?') == true){
					$.get(contextPath +"/member/info", function(member){
						
						if(pwd == member.member.pwd){
							$.ajax({
								url: contextPath + "/withdrawal",
								type: "POST",
								contentType:"application/json; charset=utf-8",
								dataType: "json",
								cache : false,
								data : JSON.stringify(id),
								success: function(res) {
										if(res == 1){
											alert('이용해주셔서 감사합니다.');
											location.href = contextPath + '/logout'
										}
								},
								error: function(request,status,error){
									alert('에러' + request.status+request.responseText+error);
								}
							});
						}else {
							alert('비밀번호가 맞지 않습니다.');	
						}
					});
			}else {
				return ;
			}
		}
	});
});
</script>

<div class="wrapper">
<h2 id="subTitle">회원 탈퇴</h2>
	<span>01. 회원탈퇴 안내</span>
	<div class="box">
		<p>당근멍캣 탈퇴안내</p>

		<p>당근멍캣을 탈퇴하시는 이유는 무엇인가요?</p>
		<p>탈퇴하시는 이유를 알려주시면 보다 좋은 서비스 제공을 위해 노력하겠습니다.</p>
		<br>
		<p>■ 아울러 회원 탈퇴시의 아래 사항을 숙지하시기 바랍니다.</p>
		<p>1. 회원 탈퇴 시 회원님의 정보는 상품 반품 및 A/S를 위해 전자상거래 등에서의 소비자 보호에 관한 법률에 의거한</p>
		<p>고객정보 보호정책에따라 관리 됩니다.</p>
		<p>2. 탈퇴 시 회원님께서 보유하셨던 마일리지는 삭제 됩니다</p>
	</div>
	<span>02. 회원탈퇴 하기</span>
	<div>
		<table id="withdraw-table">
			<tr>
				<td>비밀번호</td> 
				<td><input type="text" id="w_pwd"></td>
			</tr>

			<tr>
				<td>남기실 말씀</td>
				<td><input type="text" id="w_memo"></td>
			</tr>
		</table>
		<input type="button" value="이전으로" onclick="history.back()">
		<input type="button" value="탈퇴" id="del">
	</div>
		
	
</div>

<jsp:include page="/resources/include/footer.jsp"/>