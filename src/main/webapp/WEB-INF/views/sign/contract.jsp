<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<style>
.wrapper {width:800px; margin:0 auto; text-align:center; padding:50px}
</style>
<script>
function go_next() {
	  if ($('input[name=ok]')[0].checked == true && $('input[name=ok]')[1].checked == true ) {
		  var contextPath = "<%=request.getContextPath()%>";
		  window.location.href= contextPath+'/signup';
	  } else if ($('input[name=ok]')[0].checked == false || $('input[name=ok]')[1].checked == false) {
	    alert('약관에 모두 동의하셔야만 합니다.');
	  }
	}
</script>
<div class="wrapper">
~~~~~이용약관~~~~~~ <br><br>
	<div>
		<input type="checkbox" name="ok">동의함 
	</div>
	<div>
		<input type="checkbox" name="ok">동의함 
	</div>
	<div>
 	 	<input type="button" class="button" value="다음 단계" onclick="go_next()"> 
 	 	<input type="button" class="button" value="취소" > 
	</div>

</div>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>