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
		console.log(datalength)
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
});
</script>

<div class="wrapper">
	<table class="signup">
	<tr>
		<td>아이디</td>
		<td><input type="text" name="id"></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="pwd" placeholder=""></td>
	</tr>
	<tr>
		<td>이름</td>
		<td><input type="text" name="name"></td>
	</tr>
	<tr>
		<td>닉네임</td>
		<td><input type="text" name="nickname"></td>
	</tr>
	<tr>
		<td>이메일</td>
		<td><input type="text" name="email"></td>
	</tr>
	<tr>
		<td>연락처</td>
		<td><input type="text" name="phone"></td>
	</tr>
	<tr>
		<td>주소</td>
		<td>
		<select name="dongne1">
			<option>시 선택</option>
		</select> 
		<select name="dongne2">
		</select>
		</td>
	</tr>
	<tr>
		<td>프로필사진</td>
		<td><input type="file" name="profile_pic"></td>
	</tr>
	<tr>
		<td>프로필소개</td>
		<td><input type="text" name="profile_text"></td>
	</tr>
	</table>


<div class="btns">
	<input type="submit" value="가입완료">
</div>

</div>
<jsp:include page="/resources/include/footer.jsp"/>