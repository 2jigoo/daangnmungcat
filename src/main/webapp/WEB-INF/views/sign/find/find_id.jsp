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
	
	var certiKey;
	
	$('#find').on('click', function(){
		
		if($('#name').val() == ""){
			alert('이름을 입력하세요.');
			return;
		}else if($('#mail').val() == ""){
			alert('이메일을 입력하세요.');
			return;
		}else {
			
		
			var data = {
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
					console.log(res)
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
			
			console.log(inputKey +' : '+ certiKey)
			
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
									$('#search_div').remove();
									$('#search_btns').remove();
									
									var cont = "";
									
									cont += '<div id="search_div" style="margin-top:20px; margin-bottom:20px;">'
									cont += '<span class="find_span">회원님의 아이디는 <span class="id_span">' + id + '</span> 입니다.</span>'
									cont += '</div>'
								
								
									$('#replace').prepend(cont);
									
									
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
				$('#certi_text').text("인증번호가 맞지 않습니다.").attr("style","color:red;");
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
							$('#text').text("존재하지 않는 회원입니다.").attr("style","color:red;");
							
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
	
	$('#login').on('click', function(){
		location.href='/login';
	});
	
	$('#find_pwd').on('click', function(){
		location.href='/sign/find/find_pwd';
	});
	
});
</script>
<div class="wrapper">
	<h2 id="subTitle">아이디 찾기</h2>
	<div class="search_div" id="replace">
		<div id="search_div">
		<!-- <p style=" padding:8px;">가입 시 작성하신 이름과 이메일을 입력해주세요.</p> -->
		<input type="text" placeholder=" 이름" name="name" id="name" class="search_input"> <Br>
		<input type="text" placeholder=" 이메일" id="mail" name="type" class="search_input"> <Br>
		<font id="text" size="2" color="black"></font>
		
		<input type="text" placeholder="인증번호를 입력하세요." id="key" name="key" class="search_input" style="width:222px">
		<input type="button" value="확인" id="confirm" class="certi_confirm">
		<input type="button" value="재전송" id="re_confirm" class="re_certi"> <Br>
		<font id="certi_text" size="2" color="black"></font>
		</div>
	
		<div id="search_btns" class="search_btns">
			<input type="button" value="인증번호 전송" id="find" class="search_btn" style="width:330px; height:40px; border-radius:4px;">
		</div>
		
		<div id="confirm_btns" class="search_btns">
			<input type="button" value="로그인" id="login" class="search_btn" style="background-color:#676767; color:#fff; border:1px solid #676767;">
			<input type="button" value="비밀번호 찾기" id="find_pwd" class="search_btn" style="background-color:#fff; color:#676767; border:1px solid #676767;">
		</div>
	
	
	</div>
	
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>