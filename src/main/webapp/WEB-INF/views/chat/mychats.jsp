<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://sargue.net/jsptags/time" prefix="javatime" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="/resources/include/header.jsp"/>
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

<div>
	<article>
		<div id="article">
			<c:forEach  var="chat" items="${list }" >
				<c:if test="${chat.sale.member.id eq loginUser.id }">
					<c:set var="member" value="${chat.sale.member }" />
				</c:if>
				<c:if test="${chat.buyer.id eq loginUser.id }">
					<c:set var="member" value="${chat.buyer }" />
				</c:if>
				<section class="section_chat">
					<div class="section_chat_profile_img">
						<a href="${pageContext.request.contextPath }/member/profile?id=${member.id}">
							<c:choose>
								<c:when test="${member.profilePic eq null}">
									<img alt="기본프로필" src="https://d1unjqcospf8gs.cloudfront.net/assets/users/default_profile_80-7e50c459a71e0e88c474406a45bbbdce8a3bf2ed4f2efcae59a064e39ea9ff30.png">
								</c:when>
								<c:otherwise>
									<img alt="개인프로필" src="<%=request.getContextPath() %>/resources/upload/profile/${member.profilePic}">
								</c:otherwise>
							</c:choose>
						</a>
					</div>
					<a id="section_chat_link" href="${pageContext.request.contextPath }/chat/${chat.id} ">
						<div class="section_chat_left">
							<div class="user_info" user_id="${member.id }">
								<span class="nickname"> ${member.nickname } </span>
								${chat.sale.dongne2.dongne1.name } ${chat.sale.dongne2.name}
								/ <span class="regdate" regdate="${chat.latestDate }"> ${chat.latestDate }</span>
							</div>
							<div class="dongnename">${chat.messages[0].content }</div>
						</div>		
					</a>
				</section>
			</c:forEach>
		
		<%-- <tr>
				<td>${chat.id }</td>
				<td>${chat.sale.id }</td>
				<td>아직${chat.sale.thumImage }</td>
				<td>${chat.sale.title }</td>
				<td>${chat.sale.member.id }</td>
				<td>${chat.buyer.id }</td>
				<td>${chat.regdate }</td>
				<td><javatime:format value="${chat.latestDate }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<td><javatime:format value="${chat.messages[0].regdate }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			</tr> --%>
		</div>
	</article>
</div>
<jsp:include page="/resources/include/footer.jsp"/>