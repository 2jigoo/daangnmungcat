<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="javatime" uri="http://sargue.net/jsptags/time" %>
<jsp:include page="/resources/include/header.jsp"/>
<script src="${pageContext.request.contextPath }/resources/js/stomp.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/sockjs.min.js"></script>
<script>
	var chatId = ${chat.id};
	var memberId = "${loginUser.id}";
	var memberNickname = "${loginUser.nickname}";
	console.log(chatId);
	console.log(memberId);
	
	var headerName = "${_csrf.headerName}";
	var token = "${_csrf.token}";
	var headers = {};
	headers[headerName] = token;
	console.log(headers);
	
	$(document).ready(function(){
		/* 글쓴 시간 비교시간 변경 */
		var regdate = document.getElementsByClassName("regdate");
		$.each(regdate, function(idx, item) {
			var writeNow = dayjs(item.innerText).format("YYYY년 M월 D일 h:mm");
		 	item.innerHTML = writeNow;
		});
	});
</script>
<div>
	<article>
		<div id="chat-page">
		    <div class="chat-container">
		        <div class="chat-header">
		            <h2>
			        	<c:if test="${chat.sale.member.id eq loginUser.id }">
							${chat.sale.member.nickname }
						</c:if>
						<c:if test="${chat.buyer.id eq loginUser.id }">
							${chat.buyer.nickname }
						</c:if>
					</h2>
		            [${chat.sale.saleState.label }] ${chat.sale.title } <br>
		            <span class="dongne">${chat.sale.dongne2.dongne1.name } ${chat.sale.dongne2.name}</span><br>
					<c:choose>
						<c:when test="${chat.sale.price eq 0}">무료나눔</c:when>
						<c:otherwise>${chat.sale.price}원</c:otherwise>
					</c:choose>
					<br>
		        </div>
		        <div class="connecting">
		            연결중...
		        </div>
		        <ul id="messageArea">
		        	<c:forEach items="${chat.messages }" var="msg">
		        	<c:choose>
			        	<c:when test="${msg.member.id eq loginUser.id }">
							<c:set var="sender" value="me" />
						</c:when>
						<c:otherwise>
							<c:set var="sender" value="you" />
						</c:otherwise>
					</c:choose>
					<li class="chat-message ${sender }" msg_id="${msg.id }" sender="${msg.member.id }">
						<!-- <i style="background-color: rgb(57, 187, 176);">*</i> -->
						<div class="chat-message ${sender } profile_img">
							<c:choose>
								<c:when test="${sender eq 'you' }">
									<a href="${pageContext.request.contextPath }/member/profile?id=${msg.member.id}">
									<c:choose>
										<c:when test="${msg.member.profilePic eq null}">
											<img alt="기본프로필" src="https://d1unjqcospf8gs.cloudfront.net/assets/users/default_profile_80-7e50c459a71e0e88c474406a45bbbdce8a3bf2ed4f2efcae59a064e39ea9ff30.png">
										</c:when>
										<c:otherwise>
											<img alt="개인프로필" src="<%=request.getContextPath() %>/resources/upload/profile/${msg.member.profilePic}">
										</c:otherwise>
									</c:choose>
									</a>
								</c:when>
								<c:otherwise>
									<!-- 내가 보낸 메시지 -->
								</c:otherwise>
							</c:choose>
						</div>
						<div class="chat-message ${sender } bubble">
							<c:if test="${sender eq 'you' }">
								<span class="nickname">${msg.member.nickname }</span>
							</c:if>
							<p>${msg.content } ${msg.image }</p>
							<span class="read_yn" read_yn="${msg.readYn }">
								<c:if test="${msg.readYn eq 'y' }">읽음</c:if>
								<c:if test="${msg.readYn eq 'n' }">읽지 않음</c:if>
							</span>
							<span class="regdate" regdate="${msg.regdate }"> ${msg.regdate } </span>
						</div>
					</li>
					</c:forEach>
		        </ul>
		        <form id="messageForm" name="messageForm">
		            <div class="form-group">
		                <div class="input-group clearfix">
		                    <input type="text" id="message" placeholder="Type a message..." autocomplete="off" class="form-control"/>
		                    <button type="submit" class="primary">보내기</button>
		                </div>
		            </div>
		        </form>
		    </div>	
		</div>
	</article>
	<%-- <article>
		<div id="article">
			<section class="section_chat">
				${chat.sale.title } <br>
				${chat.sale.saleState.label } <br>
				${chat.sale.price } <br>
				<hr>
				<c:forEach items="${chat.messages }" var="msg">
					${msg.member.id } <br>
					${msg.member.nickname } <br>
					${msg.content } <br>			
					<javatime:format value="${msg.regdate }" pattern="yyyy-MM-dd HH:mm:ss" /> <br>			
					${msg.image } <br>			
					${msg.readYn } <br>					
					<br>
				</c:forEach>
			</section>
		</div>
	</article> --%>
	
</div>
<script src="${pageContext.request.contextPath }/resources/js/test_page.js"></script>
<jsp:include page="/resources/include/footer.jsp"/>