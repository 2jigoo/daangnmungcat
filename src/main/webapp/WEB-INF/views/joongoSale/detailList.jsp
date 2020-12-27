<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ include file="/resources/include/header.jsp" %>

<style>
</style>

<script type="text/javascript">
function timeBefore(){
	//현재시간 가져오기
	
}

</script>

<c:forEach items="${list}" var="list">
<section>
	<div class="img">
		<img src="<c:url value="/resources/images/mProduct_img1.png" />">
	</div>
</section>
<section id="profile">
	<ul>
		<li>${list.member.grade }</li>
		<li><a href="#"></a>${list.thumImg }</li>
		<li><a href="#"></a>${list.member.id}</li>
		<li>${list.dongne1.dong1Name}</li>
		<li>${list.dongne2.dong2Name}</li>
	</ul>
</section>

<section id="description">
	<ul>
		<li><h1>${list.title }</h1></li>
		<li>
			<c:if test="${list.dogCate == 'y'}">강아지카테고리</c:if>
			<c:if test="${list.dogCate == 'n'}"></c:if>
			<c:if test="${list.catCate == 'y'}">고양이카테고리</c:if>
			<c:if test="${list.catCate == 'n'}"></c:if>
		/ ${list.regdate }<div id=""></div>
		</li>
		<li>${list.price }원</li>
		<li>${list.content }</li>
	</ul>
	
	<ul>
		<li> 관심 ${list.heartCount} 채팅 ${list.chatCount} 조회${list.hits } </li>
	</ul>
	
	
	<ul>
		<li>
			<button type="button"><img src="/resources/images/ico_heart.png" alt="하트" onclick=""></button>
			<input type="button" value="대화로 문의하기">
		</li>
	</ul>
	
	<ul>
		<li><h1>이 판매자의 다른 중고상품들 입니다.</h1></li>
		<li></li>
	</ul>
</section>
</c:forEach>

<jsp:include page="/resources/include/footer.jsp"/>