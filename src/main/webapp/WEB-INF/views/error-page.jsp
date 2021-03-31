<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<script>
	function goBack() {
		history.go(-1);
	}
</script>
<div id="subContent">
	<div id="pageCont" class="s-inner">
		<h2 id="subTitle">Error ${requestScope['javax.servlet.error.status_code']}</h2>
		<div class="empty_cart">
			<c:if test="${requestScope['javax.servlet.error.status_code'] == 400}">
				<p>잘못된 요청입니다.</p>    
			</c:if>	
			
			<c:if test="${requestScope['javax.servlet.error.status_code'] == 403}">
				<p>접근 권한이 없습니다.</p>    
			</c:if>
			
			<c:if test="${requestScope['javax.servlet.error.status_code'] == 404}">
				<p>요청하신 페이지를 찾을 수 없습니다.</p>    
			</c:if>
			
			<c:if test="${requestScope['javax.servlet.error.status_code'] == 405}">
				<p>요청된 메소드가 허용되지 않습니다.</p>    
			</c:if>
			
			<c:if test="${requestScope['javax.servlet.error.status_code'] == 500}">
				<p>서버에 오류가 발생하여 요청을 수행할 수 없습니다.</p>
			</c:if>
			
			<c:if test="${requestScope['javax.servlet.error.status_code'] == 503}">
				<p>서비스를 사용할 수 없습니다.</p>
			</c:if>
			<p>
				<a class="cart_btn" href="/">메인으로</a>		
				<a class="cart_btn" href="javascript:void()" onclick="goBack()">뒤로가기</a>
			</p>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>