<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="javatime" uri="http://sargue.net/jsptags/time" %>
<jsp:include page="/resources/include/header.jsp"/>
<script src="${pageContext.request.contextPath }/resources/js/stomp.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/sockjs.min.js"></script>
<script>
	var contextPath = "${pageContext.request.contextPath }";
	
	var chatId = 0;
	var memberId = "${loginUser.id}";
	var memberNickname = "${loginUser.nickname}";
	
	var page = 1;
	var perPage = 20;
	
	/* var headerName = "${_csrf.headerName}";
	var token = "${_csrf.token}";
	var headers = {};
	headers[headerName] = token;
	console.log(headers); */
	
	$(document).ready(function(){
		
		/* 글쓴 시간 비교시간 변경 */
		var regdate = document.getElementsByClassName("regdate");
		$.each(regdate, function(idx, item) {
			var writeNow = dayjs(item.innerText).format("YYYY년 M월 D일 h:mm");
		 	item.innerHTML = writeNow;
		});
		
		$("#chat-loading-btn").click(function(e) {
			$.ajax({
				url: contextPath + "/chat/createChat",
				type: "post",
				data: {id: ${sale.id}, member: {id: ${sale.member.id}}},
				dataType: "",
				success: function(data) {
					console.log(data);
				},
				error: function(error) {
					console.log(error);
				}
			});
			
			/* connect();
			sendMessage(e);
			messageForm.addEventListener('submit', sendMessage, true); */
		});
	});
</script>
<div>
	<article>
		<div id="chat-page">
		    <div class="chat-container">
		        <div class="chat-header">
		            <h2>
						${sale.member.nickname }
					</h2>
		            [${sale.saleState.label }] ${sale.title } <br>
		            <span class="dongne">${sale.dongne2.dongne1.name } ${sale.dongne2.name}</span><br>
					<c:choose>
						<c:when test="${sale.price eq 0}">무료나눔</c:when>
						<c:otherwise>${sale.price}원</c:otherwise>
					</c:choose>
					<br>
		        </div>
		        <div class="connecting">
		          	  연결중...
		        </div>
		        <ul id="messageArea">
		        </ul>
		        <form id="messageForm" name="messageForm">
		            <div class="form-group">
		                <div class="input-group clearfix">
		                    <input type="text" id="message" placeholder="메시지를 입력하세요." autocomplete="off" class="form-control"/>
		                    <button type="submit" class="primary">보내기</button>
		                </div>
		            </div>
		        </form>
		    </div>	
		</div>
	</article>
</div>
<script src="${pageContext.request.contextPath }/resources/js/test_page.js"></script>
<jsp:include page="/resources/include/footer.jsp"/>