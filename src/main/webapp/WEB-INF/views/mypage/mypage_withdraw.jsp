<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<style>
.wrapper {margin:0 auto; padding:70px; text-align:center; margin-bottom:50px;}
</style>
<script>
$(document).ready(function(){
	var contextPath = "<%=request.getContextPath()%>";
	var id;
	
	$.get(contextPath +"/member/info", function(member){
		id = member.member.id;
	});
	
	$('#del').on("click", function(){
		var pwd = {pwd: $('#w_pwd').val()};
		if(pwd == ""){
			alert('비밀번호를 입력하세요.')
		}else {
			if(confirm('탈퇴하시겠습니까?') == true){
				$.ajax({
					url: contextPath + "/withdrawal",
					type: "POST",
					contentType:"application/json; charset=utf-8",
					data : JSON.stringify(pwd),
					dataType: "json",
					cache : false,
					success: function(res) {
						if(res == 1){
							alert('이용해주셔서 감사합니다.');
							location.href = "/";
						}
					},
					error: function(request,status,error){
						alert("비밀번호가 일치하지 않습니다.");
					}
				});
			} else {
				return ;
			}
		}
	});
});
</script>

<div class="wrapper">
	<h2 id="subTitle">회원 탈퇴</h2>
		<div class="withdraw_span_div"><span style="font-size:20px;">01. 회원탈퇴 안내</span></div>
		<div class="withdraw_div">
			<p>당근멍캣 탈퇴안내</p>
			<br>
			<p>■ 아울러 회원 탈퇴시의 아래 사항을 숙지하시기 바랍니다.</p>
			<p>1. 회원 탈퇴 시 회원님의 정보는 상품 반품 및 A/S를 위해 전자상거래 등에서의 소비자 보호에 관한 법률에 의거한</p>
			<p>고객정보 보호정책에 따라 관리 됩니다.</p>
			<p>2. 탈퇴 시 회원님께서 보유하셨던 마일리지는 삭제 됩니다.</p>
		</div>
		<div class="withdraw_span_div"><span style="font-size:20px;">02. 회원탈퇴 하기</span></div>
		<div>
			<table id="withdraw_table">
				<tr>
					<td><span style="margin-left:150px;">비밀번호</span></td> 
					<td class="tl"><input type="password" id="w_pwd" style="width:200px;"></td>
				</tr>
			</table>
			
		<div class="confirm_btns">
			<input type="button" value="이전으로" onclick="history.back()"  class="go_list" style="padding:8px; background-color:#676767; font-size:15px; width:100px;">
			<input type="button" value="탈퇴" id="del" class="go_list" style="padding:8px; font-size:15px; width:100px;">
		</div>
	</div>

</div>


<%@ include file="/WEB-INF/views/include/footer.jsp" %>