<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<style>
.wrapper {margin:0 auto; padding:70px; margin-bottom:100px; }
</style>
<%  
	String id = request.getParameter("id");
	request.setAttribute("id", id);
%>
<div class="wrapper">
<h2 id="subTitle">회원가입</h2>
		<div class="step_div">
			<div class="step1">01.약관동의</div>
			<div class="step2">02.정보입력</div>
			<div class="step3 step_now">03.가입완료</div>
		</div>
	<div style="width:70%; margin:0 auto; text-align:Center; padding:40px">
	
	<i class="fas fa-user-check" style="font-size:100px; padding:20px; margin-left:30px; color:#676767"></i>
	<div style="margin:20px;">
			<p class="welcome_p" style="font-size:28px;">당근멍캣의 회원이 되신 것을 축하드립니다!</p>
			<p class="welcome_p">회원님의 아이디는  <span style="color:#ff7e15; font-weight:bold;"><%=id%></span> 입니다. </p>
			<br>
			<p class="welcome_p">더욱 다양한 서비스를 위해 노력하는 당근멍캣이 되겠습니다.</p>
			<p class="welcome_p">감사합니다.</p>
	</div>
		
		<div class="confirm_btns">
	 	 	<input type="button" value="메인으로" class="go_list" onclick="location.href='/'" style="padding:10px; background-color:#676767; font-size:15px; width:110px;border-radius:20px;"> 
	 	 	<input type="button" value="로그인"  class="go_list" onclick="location.href='/login'" style="padding:10px; font-size:15px; width:110px;border-radius:20px; "> 
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>