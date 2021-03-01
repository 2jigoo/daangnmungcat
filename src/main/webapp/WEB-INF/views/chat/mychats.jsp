<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://sargue.net/jsptags/time" prefix="javatime" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ include file="/resources/include/header.jsp" %>
<script>
$(document).ready(function(){
	
	/* 글쓴 시간 비교시간 변경 */
	var regdate = document.getElementsByClassName("regdate");
	$.each(regdate, function(idx, item) {
		var writeNow = dayjs(item.innerText).toDate();
	 	item.innerHTML = timeBefore(writeNow);
	});
	
	/* $.ajax({
		url: "/daangnmungcat/api/chat/",
		type: "get",
		dataType: "json",
		success: function(data) {
			console.log(data);
		}
	}); */
	
});
</script>

<div id="subContent">
	<h2 id="subTitle">내 채팅 목록</h2>
	<div id="pageCont" class="s-inner" style="width: 800px;">
		<article>
			<c:forEach  var="chat" items="${list }" >
				<c:if test="${chat.sale.member.id eq loginUser.id }">
					<c:set var="you" value="${chat.buyer }" />
				</c:if>
				<c:if test="${chat.buyer.id eq loginUser.id }">
					<c:set var="you" value="${chat.sale.member }" />
				</c:if>
				<section class="section_chat">
					<div class="section_chat_profile_img">
						<a href="${pageContext.request.contextPath }/member/profile?id=${member.id}">
							<c:choose>
								<c:when test="${member.profilePic eq null}">
									<img alt="기본프로필" src="<%=request.getContextPath() %>/resources/images/default_user_image.png">
								</c:when>
								<c:otherwise>
									<img alt="개인프로필" src="<%=request.getContextPath() %>/resources/upload/profile/${you.profilePic}">
								</c:otherwise>
							</c:choose>
						</a>
					</div>
					<a id="section_chat_link" href="${pageContext.request.contextPath }/chat/${chat.id} ">
						<div class="section_chat_left">
							<div class="user_info" user_id="${you.id }">
								<span class="nickname"> ${you.nickname } </span>
								${chat.sale.dongne2.dongne1.name } ${chat.sale.dongne2.name}
								/ <span class="regdate" regdate="${chat.latestDate }"> ${chat.latestDate }</span>
							</div>
							<div class="dongnename">${chat.messages[0].content }</div>
						</div>		
					</a>
				</section>
			</c:forEach>
		</article>
	</div>
</div>
<%@ include file="/resources/include/footer.jsp" %>