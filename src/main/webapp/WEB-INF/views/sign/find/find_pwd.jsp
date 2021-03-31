<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<style>
.wrapper {margin:0 auto; padding:70px; margin-bottom:150px; text-align:center;}
</style>
<script>
$(document).ready(function() {

	$('#key').hide();
	$('#confirm').hide();
	$('#re_confirm').hide();
	$('#text').hide();
	$('#pwd_update_div').hide();
	$('#pwd_update_btns').hide();
	
	var pwd_status;
	var certiKey;

	$('#find').on('click', function(){
		if($('#id').val() == ""){
			alert('아이디를 입력하세요.');
			return;
		}else if($('#name').val() == ""){
			alert('이름을 입력하세요.');
			return;
		}else if($('#mail').val() == ""){
			alert('이메일을 입력하세요.');
			return;
		}else {
			
		
			var data = {
				id: $('#id').val(),
				name: $('#name').val(),
				email: $('#mail').val()		
			}
			
			$.ajax({
				url:  "/find",
				type: "POST",
				contentType:"application/json; charset=utf-8",
				dataType: "json",
				cache : false,
				data : JSON.stringify(data),
				success: function(res) {
					
					if(res == 0){
						$('#text').show();
						$('#text').text("존재하지 않는 회원입니다.").attr("style","color:red; margin-top:5px;");
						
					}else {
						$('#find').hide();
						$('#text').hide();
						alert('입력하신 이메일로 인증번호가 발송되었습니다.')
						$('#key').show();
						$('#confirm').show();
						$('#re_confirm').show();
						certiKey = res ;	
					}
					
				},
				error: function(request,status,error){
					alert('에러' + request.status+request.responseText+error);
					
				}
			});
		}
		
	});
		
		
	$('#confirm').on('click', function(){
		
		if($('#key').val() == ""){
			alert('인증번호를 입력하세요.');
			return;
		}else {
			
			var inputKey = $('#key').val();
			
			
			if(certiKey == inputKey){
				
				var data = {key : inputKey};
				
				$.ajax({
					url:  "/find/certi" ,
					type: "POST",
					contentType:"application/json; charset=utf-8",
					dataType: "json",
					cache : false,
					data : JSON.stringify(data),
					success: function(res) {
						if(res == 1){
						
							certiKey = null;
							
							var data = {
									id: $('#id').val(),
									name: $('#name').val(),
									email: $('#mail').val()		
								}
							
							$.ajax({
								url:  "/find/confirm" ,
								type: "POST",
								contentType:"application/json; charset=utf-8",
								dataType: "json",
								cache : false,
								data : JSON.stringify(data),
								success: function(id) {
									console.log(id)
									
									$('#search_div').remove();
									$('#search_btns').remove();
									
									$('#pwd_update_div').show();
									$('#pwd_update_btns').show();
									$('#input_id').attr('value', id);
									
									
								},
								error: function(request,status,error){
									alert('에러' + request.status+request.responseText+error);
									
								}
									
							});
							
						}
					},
					error: function(request,status,error){
						alert('에러' + request.status+request.responseText+error);
						
					}
				});
			}else {
				$('#certi_text').text("인증번호가 맞지 않습니다.").attr("style","color:red");
			}
			
		}
		
	});
	
	$('#re_confirm').on('click', function(){
		if($('#name').val() == ""){
			alert('이름을 입력하세요.');
			return;
		}else if($('#mail').val() == ""){
			alert('이메일을 입력하세요.');
			return;
		}else {
		
			if(confirm('인증번호를 재전송하시겠습니까?') == true){
				
				var data = {
						name: $('#name').val(),
						email: $('#mail').val()		
					}
					
				$.ajax({
					url:  "/find-id",
					type: "POST",
					contentType:"application/json; charset=utf-8",
					dataType: "json",
					cache : false,
					data : JSON.stringify(data),
					success: function(res) {
						console.log(res)
						if(res == 0){
							$('#text').show();
							$('#text').text("존재하지 않는 회원입니다.").attr("style","color:red");
							
						}else {
							$('#text').hide();
							alert('입력하신 이메일로 인증번호가 발송되었습니다.')
							$('#key').show();
							$('#confirm').show();
							$('#re_confirm').show();
							certiKey = res ;	
						}
						
					},
					error: function(request,status,error){
						alert('에러' + request.status+request.responseText+error);
						
					}
				});
			}else {
				return;
			}
		}
		
	});
	
	
	$('#re_pwd').keyup(function(){
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
	

	
	$('#update_pwd').on('click', function(){

		var pwdReg = /^[A-Za-z0-9]{6,20}$/;
		
		if(pwdReg.test($('#new_pwd').val()) == false ){
			alert("비밀번호는 한글과 숫자를 포함한 6~20자리 이내만 가능합니다.");
			return;
		}else if($('#new_pwd').val() == ""){
			alert('새 비밀번호를 입력하세요.');
			return;
		}else if($('#re_pwd').val() == ""){
			alert('새 비밀번호를 다시 입력해주세요.');
			return;
		}else if(pwd_status == 0){
			alert('새 비밀번호가 일치하지 않습니다.');
			return;
		}else {
			var data = {
					id : $('#input_id').val(),
					new_pwd : $('#new_pwd').val()
				}
			
			$.ajax({
				url:  "/find/confirm/pwd",
				type: "POST",
				contentType:"application/json; charset=utf-8",
				dataType: "json",
				cache : false,
				data : JSON.stringify(data),
				success: function() {
					alert('비밀번호가 변경되었습니다.');
					location.href = '/login';
				},
				error: function(e){
					alert("현재 비밀번호가 일치하지 않습니다.");
					
				}
			});
		}
			
		
	});
	
	
	$('#login').on('click', function(){
		location.href='/login';
	});
	
	$('#find_id').on('click', function(){
		location.href='/sign/find/find_id';
	});
})
</script>

<div class="wrapper">
	<h2 id="subTitle">비빌번호 찾기</h2>
	<div class="search_div" id="replace">
		<div id="search_div">
		<input type="text" placeholder=" 아이디" name="id" id="id" class="search_input"> <Br>
		<input type="text" placeholder=" 이름" name="name" id="name" class="search_input"> <Br>
		<input type="text" placeholder=" 이메일" id="mail" name="type" class="search_input"> <Br>
		<font id="text" size="2" color="black"></font>
		
		<input type="text" placeholder="인증번호를 입력하세요." id="key" name="key" class="search_input" style="width:222px">
		<input type="button" value="확인" id="confirm" class="certi_confirm">
		<input type="button" value="재전송" id="re_confirm" class="re_certi"><Br>
		<font id="certi_text" size="2" color="black"></font>
		</div>
	
		<div id="search_btns" class="search_btns">
			<input type="button" value="인증번호 전송" id="find" class="search_btn" style="width:330px; height:40px; border-radius:4px;">
		</div>
		
		<!-- hide -->
		<div id="pwd_update_div" >
			<input type="hidden" id="input_id"><br>
			<input type="password" placeholder=" 새 비밀번호" name="new_pwd" id="new_pwd" class="search_input">
			<input type="password" placeholder=" 새 비밀번호 확인" name="re_pwd" id="re_pwd" class="search_input"> <br>
			<font size="2" color="black" name="check"></font>
		</div>
		<div id="pwd_update_btns" class="search_btns">
			<input type="button" value="비밀번호 변경하기" id="update_pwd" class="search_btn" style="width:330px; height:40px; border-radius:4px;">
		</div>
		<!--  -->
		
		<div id="confirm_btns" class="search_btns">
			<input type="button" value="로그인" id="login" class="search_btn" style="background-color:#676767; color:#fff; border:1px solid #676767;">
			<input type="button" value="아이디찾기" id="find_id" class="search_btn" style="background-color:#fff; color:#676767; border:1px solid #676767;">
		</div>
	
	</div>
	
	
</div>

<%@ include file="/WEB-INF/views/include/footer.jsp"%>