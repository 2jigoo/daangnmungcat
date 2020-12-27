<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>

<style>
.wrapper {padding:50px; width:80%; margin:0 auto;}
.signup {width:700px; margin:0 auto;}
.btns {width:700px; margin:0 auto; text-align:center; padding:30px;}
</style>

<script>
$(document).ready(function(){
	var contextPath = "<%=request.getContextPath()%>";
	var csrfToken = $("meta[name='_csrf']").attr("th:content");
	var email_status; //email_status가 0이면 return
	var pwd_status;
	var data;
	
	console.log(csrfToken);
	$.ajaxPrefilter(function(options, originalOptions, jqXHR){
	    if (options['type'].toLowerCase() === "post") {
	        jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
	    }
	});
	
	$.get(contextPath+"/dongne1", function(json){
		var datalength = json.length; 
		if(datalength >= 1){
			var sCont = "";
			for(i=0; i<datalength; i++){
				sCont += '<option value="' + json[i].dong1Id + '">' + json[i].dong1Name + '</option>';
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
				sCont += '<option value="' + json[i].dong2Id + '">' + json[i].dong2Name + '</option>';
			}
			$("select[name=dongne2]").append(sCont);	
		});
	});
	
	$('#signup').on("click", function(json){
		var pwdReg = /^[A-Za-z0-9]{6,20}$/;
		
		if($('#id').val() != $('#id_confirm').val()){
			alert('아이디 중복확인을 눌러주세요.');
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
		}else if(email_status == 0){
			alert('이미 사용중인 이메일입니다');
			return;
		}else if($('#phone').val() == ""){
			alert('연락처를 입력하세요.');
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
				dongne1:$('#dongne1').val(),
				dongne2:$('#dongne2').val(),
				grade:5,
				profilePic:$('#profile_pic').val(),
				profileText:$('#profile_text').val(),
				regdate: null
				};
		console.log(newMember);
		
		$.ajax({
			url: contextPath + "/submit",
			type: "POST",
			contentType:"application/json; charset=utf-8",
			dataType: "json",
			cache : false,
			data : JSON.stringify(newMember),
			success: function() {
				alert('회원가입이 완료되었습니다.');
			},
			error: function(request,status,error){
				alert('에러' + request.status+request.responseText+error);
			}
		});
		console.log(contextPath+"/submit");
	});
	
	//비밀번호 일치여부
		$('#pwdCheck').keyup(function(){
			  if($('#pwd').val()!=$('#pwdCheck').val()){
			  	$('font[name=check]').text('');
			   	$('font[name=check]').html("암호가 일치하지 않습니다.");
			   	$('input[name=pwdCheck]').attr("style","border:2px solid red");
			   	$('input[name=pwd]').attr("style","border:2px solid red");
			   	
			   	$('input[name=pwd]').prop("status", "0");
			  }else{
			  	$('font[name=check]').text('');
			  	$('font[name=check]').html("암호가 일치합니다.");
				$('input[name=pwdCheck]').attr("style","border:1px solid black");
				$('input[name=pwd]').attr("style","border:1px solid black");
				
				$('input[name=pwd]').prop("status", "1");
			  }
			 pwd_status = document.getElementById('pwd').status;
			 console.log('pwd:'+ pwd_status);
	});	  
	
	//이메일 정규표현식 & 중복여부
	$('#email').keyup(function(){
		var contextPath = "<%=request.getContextPath()%>";
		var email = $('#email').val();
		var save;
		var reg = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
		
		if(reg.test(email) == false){
			$('font[name=email_check]').text('');
		   	$('font[name=email_check]').html("이메일 형식에 맞게 작성해주세요.");
		   	$('input[name=email]').attr("style","border:2px solid red");
		}else {
			save = contextPath + "/emailCheck/"+ email + "/";
			$.get(save, function(res){
				if(res == 0){
					$('font[name=email_check]').text('사용가능한 이메일입니다.').attr("style","color:black");
					$('input[name=email]').prop("status", "1");
				}else{
					$('font[name=email_check]').text('이미 사용중인 이메일입니다.').attr("style","color:red");
					$('input[name=email]').attr("style","border:2px solid red");
					
					$('input[name=email]').prop("status", "0");
				}
				email_status = document.getElementById('email').status;
			});
			console.log(email_status);
			
			$('font[name=email_check]').text('');
			$('input[name=email]').attr("style","border:1px solid black");
		}
	});
	
	//폰번호 입력시 '-' 자동
	$('#phone').keyup(function(){
		$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );

	});
	
	//휴대폰인증
    $('#send').click(function(){
        var number = $('#phone').val();
        var certiNum = $('#certiNum').val();
       
       
        $.ajax({
        	type:'get',
        	url: contextPath + "/sendSMS/" + number + "/",
       		success: function(json){
       			console.log(json);
       			$('#certiSubmit').click(function(){
       				if(json == $('#certiNum').val()){
       					alert('인증 완료');
       	        	}else {
       	        		alert('인증번호가 맞지 않습니다.')
       	        	}
       			})
       		},
       		error: function(){
       			console.log('에러');
       		}
        })
        
    });
    
});

function id_check() {
	var contextPath = "<%=request.getContextPath()%>";
	var reg = /^[A-Za-z0-9+]{4,20}$/; 

	var id = $('#id').val();
	if(id == ""){
		alert("아이디 입력 후 중복확인을 눌러주세요.");
	}else if(reg.test(id) == false){
		alert("아이디는 4자리 이상의 영문자와 숫자만 사용가능합니다.");
		return;
	}
	$.get(contextPath+"/idCheck/"+id, function(json){
		console.log(json);
		window.open(contextPath+"/idCheck?id="+id+"&status="+json, "", "width=400, height=300, left=100, top=50 ,location=no, directoryies=no, resizable=no, scrollbars=yes");
	});

}


</script>

<div class="wrapper">
	<table class="signup">
	<tr>
		<td>아이디</td>
		<td>
			<input type="text" name="id" id="id" placeholder="입력후 중복확인">
			<input type="button" value="중복확인" onclick="id_check()">
	</tr>
	<tr>
		<td>(<input type="text" name="id_confirm" id="id_confirm">)</td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="pwd" id="pwd"></td>
	</tr>
	<tr>
		<td>비밀번호 확인</td>
		<td><input type="password" name="pwdCheck"  id="pwdCheck"></td>
	</tr>
	<tr height="30px">
		<td></td>
		<td><font size="2" color="black" name="check">비밀번호는 한글과 숫자를 포함한 6~20자리 이내만 가능합니다.</font></td>
	</tr>
	<tr>
		<td>이름</td>
		<td><input type="text" name="name" id="name"></td>
	</tr>
	<tr>
		<td>닉네임</td>
		<td><input type="text" name="nickname" id="nickname"></td>
	</tr>
	<tr>
		<td>이메일</td>
		<td><input type="text" name="email" id="email"></td>
	</tr>
	<tr height="30px">
		<td></td>
		<td><font size="2" color="black" name="email_check" id="email_check"></font></td>
	</tr>
	<tr class="phone">
		<td>연락처</td>
		<td><input type="text" name="phone" id="phone">
		<input type="button" name="send" id="send" value="인증번호발송"></td>
	</tr>
	<tr class="certi">
		<td></td>
		<td><input type="text" name="certiNum" id="certiNum">
		<input type="button" id="certiSubmit" value="확인">
		</td>
	</tr>
	<tr>
		<td>주소</td>
		<td>
		<select name="dongne1" id="dongne1">
			<option value="0">지역을 선택하세요</option>
		</select> 
		<select name="dongne2" id="dongne2">
			<option value="0">동네를 선택하세요</option>
		</select>
		</td>
	</tr>
	<tr>
		<td>프로필사진</td>
		<td><input type="file" name="profile_pic" id="profile_pic"></td>
	</tr>
	<tr>
		<td>프로필소개</td>
		<td><input type="text" name="profile_text" id="profile_text"></td>
	</tr>
	</table>


<div class="btns">
	<input type="button" value="가입완료" id="signup">
</div>

</div>
<jsp:include page="/resources/include/footer.jsp"/>