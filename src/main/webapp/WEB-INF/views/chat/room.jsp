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
	console.log(moment().format());
	
	var headerName = "${_csrf.headerName}";
	var token = "${_csrf.token}";
	var headers = {};
	headers[headerName] = token;
	console.log(headers);
</script>
<div>
	<article>
		<div id="chat-page">
		    <div class="chat-container">
		        <div class="chat-header">
		            <h2>${chat.sale.member.nickname }</h2>
		            [${chat.sale.saleState.label }] ${chat.sale.title } <br>
					${chat.sale.price }원 <br>
		        </div>
		        <div class="connecting">
		            연결중...
		        </div>
		        <ul id="messageArea">
		        	<c:forEach items="${chat.messages }" var="msg">
					<li class="chat-message" msg_id="${msg.id }" sender="${msg.member.id }">
						<i style="background-color: rgb(57, 187, 176);">*</i>
						<span>${msg.member.nickname }</span>
						<p>${msg.content } ${msg.image }</p>
						${msg.readYn }
						<javatime:format value="${msg.regdate }" pattern="yyyy-MM-dd HH:mm:ss" />
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