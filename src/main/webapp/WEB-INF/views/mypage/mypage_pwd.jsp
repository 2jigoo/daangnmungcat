<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<style>
.wrapper {margin:0 auto; padding:70px; text-align:center; margin-bottom:150px; }

</style>
<script>
$(function(){
	var contextPath = "<%=request.getContextPath()%>";
	var pwd_status;
	console.log('pwd_status:'+ pwd_status);
	
	$('#re_pwd').keyup(function(){
		  if($('#new_pwd').val()!=$('#re_pwd').val()){
		  	$('font[name=check]').text('');
		   	$('font[name=check]').html("암호가 일치하지 않습니다.");
		   	$('input[name=re_pwd]').attr("style","border:2px solid red");
		   	$('input[name=new_pwd]').attr("style","border:2px solid red");
		   	
		   	$('input[name=new_pwd]').prop("status", "0");
		  }else{
		  	$('font[name=check]').text('');
		  	$('font[name=check]').html("암호가 일치합니다.");
			$('input[name=re_pwd]').attr("style","border:1px solid black");
			$('input[name=new_pwd]').attr("style","border:1px solid black");
			
			$('input[name=new_pwd]').prop("status", "1");
		  }
		 pwd_status = document.getElementById('new_pwd').status;
		 console.log('pwd_status:'+ pwd_status);
	});
	
	$('#new_pwd').keyup(function(){
		  if($('#new_pwd').val()!=$('#re_pwd').val()){
		  	$('font[name=check]').text('');
		   	$('font[name=check]').html("암호가 일치하지 않습니다.");
		   	$('input[name=new_pwd]').prop("status", "0");
		  }else{
		  	$('font[name=check]').text('');
		  	$('font[name=check]').html("암호가 일치합니다.");
			$('input[name=new_pwd]').prop("status", "1");
		  }
		 pwd_status = document.getElementById('new_pwd').status;
		 console.log('pwd_status:'+ pwd_status);
	});
	
	$('#pwd_update').on("click", function(){
		var pwdReg = /^[A-Za-z0-9]{6,20}$/;
		
		if(pwdReg.test($('#new_pwd').val()) == false ){
			alert("비밀번호는 한글과 숫자를 포함한 6~20자리 이내만 가능합니다.");
			return;
		}else if($('#now_pwd').val() == ""){
			alert('현재 비밀번호를 입력하세요');
			return;
		}else if($('#new_pwd').val() == ""){
			alert('새 비밀번호를 입력하세요');
			return;
		}else if($('#re_pwd').val() == ""){
			alert('새 비밀번호를 다시 입력하세요');
			return;
		}else if(pwd_status == 0){
			alert('새 비밀번호가 일치하지 않습니다.')
			return;
		}else {
			if (confirm("비밀번호를 변경하시겠습니까?") == true) {
				var pwd = {
					now_pwd: $('#now_pwd').val(),
					new_pwd: $('#new_pwd').val()
				};
			
				$.ajax({
					url: contextPath + "/member/pwd",
					type: "PUT",
					data: JSON.stringify(pwd),
					contentType: "application/json",
					success: function(res) {
						if(res == 1){
							alert("비밀번호가 변경되었습니다.");
							location.href = "/mypage/mypage_main";
						}
					},
					error: function(e) {
						alert("비밀번호가 일치하지 않습니다.");
					}
				});
			} else {
				return;
			}
			
		}
	});
	
})
</script>

<div class="wrapper">
	<h2 id="subTitle">비밀번호 변경</h2>
	<div>
		<table class="pwd_update_table">
			<tr>
				<td><span class="asterisk">* </span> 현재 비밀번호</td>
				<td><input type="password" id="now_pwd" name="now_pwd" class="mypage_pwd_text"></td> 
			</tr>
			<tr>
				<td><span class="asterisk">* </span> 새 비밀번호</td>
				<td><input type="password" id="new_pwd" name="new_pwd" class="mypage_pwd_text"></td>
			</tr>
			<tr>
				<td><span class="asterisk">* </span> 비밀번호 확인</td>
				<td><input type="password" id="re_pwd" name="re_pwd" class="mypage_pwd_text"></td>
			</tr>
			<tr>
				<td></td>
				<td>
					<font size="2" color="black" name="check"></font>
				</td>
			</tr>
		</table>
	</div>
	
	<div class="confirm_btns">
		<input type="button" id="cancel" value="취소" onclick="history.back()"  class="go_list" style="padding:8px; background-color:#676767; font-size:15px; width:100px;">
		<input type="button" id="pwd_update" value="변경" class="go_list" style="padding:8px; font-size:15px; width:100px;">
	</div>
</div>
	
<%@ include file="/WEB-INF/views/include/footer.jsp" %>