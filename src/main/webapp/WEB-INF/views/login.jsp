<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<script>
	$(document).ready(function() {
		
		$(document).on("click", "#login_btn", function(e) {
			e.preventDefault();

			if(validate()) {
				var form = $("#loginForm");
				var formData = form.serialize();
			    var url = form.attr('action');
	
			    console.log(form);
			    console.log(url);
			    
			    $.ajax({
			           type: "POST",
			           url: url,
			           data: formData, // serializes the form's elements.
			           success: function(data) {
			        	   location.href = data;
			           },
			           error: function(error) {
			        	   console.log(error);
			        	   var errorMsg = JSON.parse(error.responseText).exception;
			        	   $(".login_fail_msg").text(errorMsg);
			           }
		         });
			}
		})
	});

	function validate() {
	    if (document.loginForm.id.value == "" && document.loginForm.password.value == "") {
	        alert("아이디와 비밀번호를 입력해주세요");
	        document.loginForm.id.focus();
	        return false;
	    }
	    if (document.loginForm.id.value == "") {
	        alert("아이디를 입력해주세요");
	        document.loginForm.id.focus();
	        return false;
	    }
	    if (document.loginForm.password.value == "") {
			alert("비밀번호를 입력해주세요");
			document.loginForm.password.focus();
	        return false;
	    }
	    
	    return true;
	}
	
</script>
<div id="subContent">
	<div id="pageCont" class="s-inner">
		<h2 id="subTitle">로그인</h2>
		<div class="login-wrapper">
			<form name="loginForm" method="post" action="/doLogin" autocomplete="off" id="loginForm">
				<input class="input_row" type="text" name="id" placeholder="아이디" required>
				<input class="input_row" type="password" name="password" placeholder="비밀번호" required>
				<p class="login_fail_msg"></p>
				<%-- <c:if test="${sessionScope['SPRING_SECURITY_LAST_EXCEPTION'] ne null}">
					<p class="login_fail_msg">${sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].message}</p>
					<c:remove var="SPRING_SECURITY_LAST_EXCEPTION" scope="session"/>
				</c:if> --%>
				<input type="submit" class="login_btn" id="login_btn" value="로그인">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			</form>
			<div class="link_row">
				<a class="link_items" href="">아이디 찾기</a><span class="bar" aria-hidden="true"></span><a class="link_items" href="">비밀번호 찾기</a><span class="bar" aria-hidden="true"></span><a class="link_items" href="/sign/contract">회원가입</a>
			</div>
		</div>
	</div>
</div>


<%@ include file="/WEB-INF/views/include/footer.jsp" %>