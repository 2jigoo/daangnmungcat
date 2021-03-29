<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://sargue.net/jsptags/time" prefix="javatime" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<script>
var path = new URL(window.location.href).pathname;

function goToPage(page) {
	location.href = path + "?page=" + page;
}

</script>
<div id="subContent">
	<h2 id="subTitle">내 채팅 목록</h2>
	<div id="pageCont" class="s-inner" style="width: 800px;">
		<c:if test="${sale ne null }">
		<div class="chat-header" style="display: flex; border-top: 2px solid #ececec;">
			<div class="info">
				<a href="/joongoSale/detailList?id=${sale.id }">
						<div class="thumb">
							<c:if test="${sale.thumImg eq null }">
								<img src="/resources/images/no_image.jpg">
							</c:if>
							<c:if test="${sale.thumImg ne null }">
								<img src="/resources/${sale.thumImg }">
							</c:if>
	 		   	</div>
			    <div class="txt">
					<span class="title"><span class="${sale.saleState.code }">${sale.saleState.label }</span> ${sale.title }</span>
					<span class="dongne">${sale.dongne2.dongne1.name } ${sale.dongne2.name}</span>
					<c:choose>
						<c:when test="${sale.price eq 0}">무료나눔</c:when>
						<c:otherwise>${sale.price}원</c:otherwise>
					</c:choose>
			    </div>
				</a>
			</div>
		</div>
		</c:if>
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
						<a href="${pageContext.request.contextPath }/profile/${you.id}">
							<c:choose>
								<c:when test="${you.profilePic eq null}">
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
								· <span class="regdate" regdate="${chat.latestDate }"> ${chat.latestDate }</span>
							</div>
							<div class="dongnename">
								<c:choose>
									<c:when test="${chat.messages[0].image ne null}"><img src="${chat.messages[0].image }" width=60px></c:when>
									<c:otherwise>${chat.messages[0].content }</c:otherwise>
								</c:choose>
							</div>
						</div>		
					</a>
					<c:if test="${not empty chat.sale.thumImg }">
						<a href="/joongoSale/detailList?id=${chat.sale.id }">
						<div class="section_chat_right">
							<img src="/resources/${chat.sale.thumImg }">
						</div>
						</a>
					</c:if>
				</section>
			</c:forEach>
			<c:if test="${empty list }">
				<section class="section_chat" style="text-align: center; padding: 40px 0;">채팅 목록이 비었습니다.</section> 
			</c:if>
		</article>
		<div class="board_page">
			<c:if test="${pageMaker.prev}">
		    	<p><a href="javascript:void(0)" onclick="goToPage(${pageMaker.startPage - 1})">이전</a></p>
		    </c:if> 
			<ul>
				<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
			    	<li><a href="javascript:void(0)" onclick="goToPage(${idx})">${idx}</a></li>
				</c:forEach>
			</ul>
			<c:if test="${pageMaker.next eq true && pageMaker.endPage > 0}">
	    		<p><a href="javascript:void(0)" onclick="goToPage(${pageMaker.endPage + 1})">다음</a></p>
			</c:if> 
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>