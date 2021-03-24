<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<style>
.wrapper {margin:0 auto; padding:70px; margin-bottom:150px; }
</style>
<script>
$(document).ready(function(){
	
	var contextPath = "<%=request.getContextPath()%>";
	var id_status; //있으면 1 없으면 0
	var email_status;
	var pwd_status;
	var data;
	
	
	$.get(contextPath+"/dongne1", function(json){
		console.log(json)
		var datalength = json.length; 
		if(datalength >= 1){
			var sCont = "";
			for(i=0; i<datalength; i++){
				sCont += '<option value="' + json[i].id + '">' + json[i].name + '</option>';
			}
			$("select[name=dongne1]").append(sCont);
		}
	});
	
	
	$("select[name=dongne1]").change(function(){
		$("select[name=dongne2]").find('option').remove();
		var dong1 = $("select[name=dongne1]").val();
		$.get(contextPath+"/dongne2/"+dong1, function(json){
			var datalength = json.length; 
			var sCont = "";
			for(i=0; i<datalength; i++){
				sCont += '<option value="' + json[i].id + '">' + json[i].name + '</option>';
			}
			$("select[name=dongne2]").append(sCont);	
		});
	});
	
	$('#signup').on("click", function(json){
		var pwdReg = /^[A-Za-z0-9]{6,20}$/;
		console.log('id_status' + id_status)
		var id = $('#id').val();
		if($('#id').val() == ""){
			alert('아이디를 입력하세요');
			return;
		}else if(id_status == 1 ){
			alert('이미 사용중인 아이디입니다.');
			return;
		}else if($('#pwd').val() != $('#pwdCheck').val()){
			alert('비밀번호가 일치하지 않습니다.');
			return;
		}else if(pwdReg.test($('#pwd').val()) == false ){
			alert("비밀번호는 한글과 숫자를 포함한 6~20자리 이내만 가능합니다.");
			return;
		}else if($('#name').val() == ""){
			alert('이름을 입력하세요.');
			return;
		}else if($('#nickname').val() == ""){
			alert('닉네임을 입력하세요.');
			return;
		}else if($('#email').val() == ""){
			alert('이메일을 입력하세요.');
			return;
		}else if(email_status == 1){
			alert('이메일 형식이 맞지 않거나 이미 사용중인 이메일입니다.');
			return;
		}else if($('#certi').val() == 0){
			alert('본인인증을 완료해주세요.');
			return;
		}else if($('#dongne1').val() == "0"){
			alert('지역을 선택하세요.');
			return;
		}else if($('#dongne2').val() == "0"){
			alert('동네를 선택하세요.');
			return;
		}
		
		var newMember = {
				id: $('#id').val(),
				pwd:$('#pwd').val(),
				name:$('#name').val(),
				nickname:$('#nickname').val(),
				email:$('#email').val(),
				phone:$('#phone').val(),
				dongne1:{id:$('#dongne1').val()},
				dongne2:{id:$('#dongne2').val()},
				profilePic:'images/default_user_image.png'
				};
		
		console.log(newMember);
		
		$.ajax({
			url: contextPath + "/sign-up",
			type: "POST",
			contentType:"application/json; charset=utf-8",
			dataType: "json",
			cache : false,
			data : JSON.stringify(newMember),
			success: function(data) {
				alert('회원가입이 완료되었습니다.');
				window.location.href= '/sign/welcome?id=' + id;
			},
			error: function(request,status,error){
				alert('에러' + request.status+request.responseText+error);
				console.log(error);
			}
		});
	});
	
	//비밀번호 일치여부
	$('font[name=check]').hide();
	
	$('#pwdCheck').keyup(function(){
			
			var pwdReg = /^[A-Za-z0-9]{6,20}$/;
			if(pwdReg.test($('#pwd').val()) == false || pwdReg.test($('#pwdCheck').val() == false)){
				$('font[name=check]').show();
				$('font[name=check]').text("비밀번호는 한글과 숫자를 포함한 6~20자리 이내만 가능합니다.").attr("style","color:red;");
			 	$('input[name=pwdCheck]').attr("style","border:1px solid red");
			   	$('input[name=pwd]').attr("style","border:1px solid red");
				$('input[name=pwd]').prop("status", "0");
			
			}else if($('#pwd').val()!=$('#pwdCheck').val()){
				$('font[name=check]').show();
			  	$('font[name=check]').text('');
			   	$('font[name=check]').text("암호가 일치하지 않습니다.").attr("style","color:red;");;
			   	$('input[name=pwdCheck]').attr("style","border:1px solid red");  
			   	$('input[name=pwd]').prop("status", "0");
			  
		   	}else{
		   		//암호일치
		   		$('font[name=check]').hide();
			  	$('font[name=check]').text('');
		 	  	/* $('font[name=check]').html("암호가 일치합니다."); */
				$('input[name=pwdCheck]').attr("style","border:1px solid black");
				$('input[name=pwd]').attr("style","border:1px solid black"); 
				$('input[name=pwd]').prop("status", "1");
		  }
		
		 pwd_status = document.getElementById('pwd').status;
		 console.log('pwd:'+ pwd_status);
	});	  
	
	
	//아이디 중복여부
	$('font[name=id_check]').hide();
	$('#id').keyup(function(){
		var id = $('#id').val();
		
		var reg = /^[A-Za-z0-9+]{4,20}$/; 
		if(reg.test(id) == false){
			$('font[name=id_check]').text('아이디는 4자리 이상의 영문자와 숫자만 사용가능합니다.').attr("style","color:red;");
			$('input[name=id]').attr("style","border:1px solid red");
			
		}else {
			$.ajax({
				url: "/id-check/post",
				type: "POST",
				contentType:"application/json; charset=utf-8",
				dataType: "json",
				cache : false,
				data : JSON.stringify(id),
				success: function(res) {
					console.log(res)
					if(res == 0){
						$('font[name=id_check]').text('');
						$('input[name=id]').attr("style","border:1px solid black");
						$('input[name=id]').prop("status", "0");
					}else{
						$('font[name=id_check]').text('이미 사용중인 아이디입니다.').attr("style","color:red;");
						$('input[name=id]').attr("style","border:1px solid red");
						$('input[name=id]').prop("status", "1");
					}
					id_status = document.getElementById('id').status
					console.log('id:' + id_status);
				},
				error: function(request,status,error){
					alert('에러' + request.status+request.responseText+error);
				}
				
			});
			
			
			
		}
	});
	
	
	//이메일 정규표현식 & 중복여부
	$('font[name=email_check]').hide();
	$('#email').keyup(function(){
		var contextPath = "<%=request.getContextPath()%>";
		var email = $('#email').val();
		var reg = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
		
		if(reg.test(email) == false){
			$('font[name=email_check]').show();
		   	$('font[name=email_check]').text("이메일 형식에 맞게 작성해주세요.").attr("style","color:red;");;
		   	$('input[name=email]').attr("style","border:1px solid red");
		   	$('input[name=email]').prop("status", "1");
		}else {
			
			$.ajax({
				url: contextPath + "/email/post",
				type: "POST",
				contentType:"application/json; charset=utf-8",
				dataType: "json",
				cache : false,
				data : JSON.stringify(email),
				success: function(res) {
					console.log(res)
					if(res == 0){
						$('font[name=email_check]').hide();
						$('input[name=email]').attr("style","border:1px solid black");
						$('input[name=email]').prop("status", "0");
					}else{
						$('font[name=email_check]').show();
						$('font[name=email_check]').text('이미 사용중인 이메일입니다.').attr("style","color:red;");
						$('input[name=email]').attr("style","border:1px solid red");
						$('input[name=email]').prop("status", "1");
					}
					email_status = document.getElementById('email').status;
					console.log('email' + email_status)
				},
				error: function(request,status,error){
					alert('에러' + request.status+request.responseText+error);
				}
			});
			
		}
	});
	
	
	//폰번호 입력시 '-' 자동
	$('#phone').keyup(function(){
		$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );
		
	});
	
	//휴대폰인증
	
	$("#certiSubmit").hide();
    $("#certiNum").hide();
    
    $('#send').click(function(){
        var number = $('#phone').val();
        var certiNum = $('#certiNum').val();
        
        if(number == ""){
        	alert('연락처를 입력해주세요.');
        	return;
        }
        
        $.get(contextPath + "/phone/post/" + number, function(res){
    		if(res == 1){
    			alert('이미 사용중인 폰번호입니다');
    			return;
    		}else {
    			alert("인증번호가 발송되었습니다.");
    			$("#certiSubmit").show();
    	    	$("#certiNum").show();
    	    	
    	        $.ajax({
    	        	type:'get',
    	        	url: contextPath + "/send-sms/" + number,
    	       		success: function(json){
    	       			console.log(json);
    	       			$('#certiSubmit').click(function(){
    	       				if(json == $('#certiNum').val()){
    	       					$("#certiSubmit").hide();
    	       					$("#certiNum").hide();
    	       					$("#certi").prop("value", "1");
    	       					$("#send").attr('value', '인증완료');
    	       					$("#send").attr("disabled",true);
    	       					$("#send").attr('style', 'cursor:auto');
    	       					console.log('인증확인'+$('#certi').val());
    	       						
    	       	        	}else {
    	       	        		alert('인증번호가 맞지 않습니다.');
    	       	        		console.log('인증확인'+$('#certi').val());
    	       	        	}
    	       			})
    	       		},
    	       		error: function(){
    	       			console.log('에러');
    	       		}
    	        })
    		}
    	    });
    		
        });
    
});


</script>

<div class="wrapper">
<h2 id="subTitle">회원가입</h2>

<div class="step_div">
	<div class="step1">01.약관동의</div>
	<div class="step2 step_now">02.정보입력</div>
	<div class="step3">03.가입완료</div>
</div>

<div class="signup_table_div">
	<table class="signup_table tc">
		<tr>
			<td>
				<input type="text" name="id" id="id" placeholder=" * 아이디" class="sign_text">
				<br>
				<font size="1.8" class="tl" name="id_check"></font>
			</td>
		</tr>
		<tr>
			<td><input type="password" name="pwd" id="pwd" placeholder=" * 비밀번호 (한글, 숫자 포함  20자 이내)" class="sign_text"></td>
		</tr>
		<tr>
			<td><input type="password" name="pwdCheck" id="pwdCheck" placeholder=" * 비밀번호 확인" class="sign_text">
			<br>
			<font size="1.8" name="check" class="tl"></font></td>
		</tr>
		<tr>
			<td><input type="text" name="name" id="name" placeholder=" * 이름" class="sign_text"> </td>
		</tr>
		<tr>
			<td><input type="text" name="nickname" id="nickname" placeholder=" * 닉네임" class="sign_text"></td>
		</tr>
		<tr>
			<td>
				<input type="text" name="email" id="email" placeholder=" * 이메일주소" class="sign_text">
				<br>
				<font size="1.8" color="black" name="email_check" id="email_check"></font>
			</td>
		</tr>
		<tr class="phone">
			<td class="replace"><input type="text" name="phone" id="phone" placeholder=" * 연락처" class="sign_text" style="width:215px">
			<input type="button" name="send" id="send" value="인증번호발송" class="sign_btn1">
			<input type="hidden" id="certi" name="certi" value="0"></td> <!-- 0으로 변경해야됨 -->
		</tr>
		<tr class="certi_tr">
			<td><input type="text" name="certiNum" id="certiNum" placeholder=" 인증번호입력" class="sign_text" style="width:215px">
			<input type="button" id="certiSubmit" value="확인" class="sign_btn2">
			</td>
		</tr>
		<tr>
			<td><div class="dongne_label" >
			<span style="margin-left:20px; line-height:30px;">나의 동네</span>
			</div></td>
		</tr>
		<tr style="padding:5px;">
			<td>
			<select name="dongne1" id="dongne1" class="sign_select">
				<option value="0">지역을 선택하세요</option>
			</select> 
			<select name="dongne2" id="dongne2" class="sign_select">
				<option value="0">동네를 선택하세요</option>
			</select>
			</td>
		</tr>

	</table>
</div>
<div class="confirm_btns">
	<input type="button" value="회원가입" id="signup" class="go_list" style="width:340px; border-radius:20px; padding:10px; font-size:13px">
</div>

</div>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>