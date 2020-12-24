<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>

<style>
.wrapper {padding:50px; width:80%; margin:0 auto;}
.signup {width:700px; margin:0 auto; }
.btns {width:700px; margin:0 auto; text-align:center;}


</style>
<script type="text/javascript">
$(function(){
	var contextPath = "<%=request.getContextPath()%>";
	
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
			var sCont = "<option>동네를 선택하세요</option>";
			for(i=0; i<datalength; i++){
				sCont += '<option value="' + json[i].dong2Id + '">' + json[i].dong2Name + '</option>';
			}
			$("select[name=dongne2]").append(sCont);	
		});
	});
	
	$('#signup').on("click", function(e){
		e.preventDefault();
		var newMember = {
				id: $('#id').val(),
				pwd:$('#pwd2').val(),
				name:$('#name').val(),
				nickname:$('#nickname').val(),
				email:$('#email').val(),
				phone:$('#phone').val(),
				dongne1:$('#dongne1').val(),
				dongne2:$('#dongne2').val(),
				grade:'1',
				profilePic:$('#profile_pic').val(),
				profileText:$('#profile_text').val()
				};
		console.log(newMember);
		
		$.ajax({
			url: contextPath + "/submit",
			type: "POST",
			contentType:"application/json; charset=utf-8",
			dataType: "json",
			cache : false,
			data : JSON.stringify(newMember),
			success: function(newMember) {
				alert(newMember);
			},
			error: function(newMember){
				alert(newMember);
			}
		});
		console.log(contextPath+"/submit");
	});
});
</script>

<div class="wrapper">
	<table class="signup">
	<tr>
		<td>아이디</td>
		<td>
			<input type="text" name="id" id="id">
			<input type="button" value="중복확인" onclick="">
			<input type="text" name="id_confirm" id="id_confirm">
		</td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="pwd1" id="pwd1"></td>
	</tr>
	<tr>
		<td>비밀번호 확인</td>
		<td><input type="password" name="pwd2"  id="pwd2"></td>
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
	<tr>
		<td>연락처</td>
		<td><input type="text" name="phone" id="phone"></td>
	</tr>
	<tr>
		<td>주소</td>
		<td>
		<select name="dongne1" id="dongne1">
			<option>시 선택</option>
		</select> 
		<select name="dongne2" id="dongne2">
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