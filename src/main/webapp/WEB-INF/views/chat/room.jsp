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
	
	var headerName = "${_csrf.headerName}";
	var token = "${_csrf.token}";
	var headers = {};
	headers[headerName] = token;
	console.log(headers);
	
	var sock = null;
	var client = null;
	var url = "/daangnmungcat/ws-stomp";
	
	function setConnected(connected){
		document.getElementById('connect').disabled = connected;
		document.getElementById('disconnect').disabled = !connected;
		document.getElementById('echo').disabled = !connected;
	}
	
	function connect(){
		sock = new SockJS(url);
		client = Stomp.over(sock); // 1. SockJS를 내부에 들고 있는 client를 내어준다.
		
		// 2. connection이 맺어지면 실행된다.
		client.connect(headers, function(frame){
			setConnected(true);
			log(frame);
			
			// subscribe(path, callback)로 메시지를 받을 수 있다. callback 첫번째 파라미터의 body로 메시지의 내용이 들어온다.
			client.subscribe('/sub/chats/message', function(message){
				log(message.body);
			}, headers);
		});
	}
	
	function disconnect(){
		if(client != null){
			client.disconnect();
			client = null;
		}
		setConnected(false);
	}
	
	function echo(){
		if(client != null){
			var message = document.getElementById('message').value;
			var chatMessage = {
					chat: {id: chatId},
					member: {id: memberId},
					content: message
			}
			
			log('Sent: ' + JSON.stringify(chatMessage));
			// send(path, header, message)로 메시지를 보낼 수 있다.
			client.send("/pub/sendMessage", headers, JSON.stringify(chatMessage));
		}else{
			alert('connection not established, please connect.');
		}
	}
	
	function log(message){
		var console = document.getElementById('logging');
		var p = document.createElement('p');
		p.appendChild(document.createTextNode(message));
		console.appendChild(p);
		while(console.childNodes.length > 12){
			console.removeChild(console.firstChild);
		}
		console.scrollTop = console.scrollHeight;
	}
</script>
<div>
	<article>
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
		
		<div id="connect-container" class="ui centered grid">
	        <div class="row">
	            <button id="connect" onclick="connect();" class="ui green button">Connect</button>
	            <button id="disconnect" disabled="disabled" onclick="disconnect();" class="ui red button">Disconnect</button>
	        </div>
	        <div class="row">
	            <textArea id="message" style="width: 350px" class="ui input" placeholder="Message to Echo"></textArea>
	        </div>
	        <div class="row">
	            <button id="echo" onclick="echo();" disabled="disabled" class="ui button">Echo message</button>
	        </div>
	        <div id="console-container">
	            <h3>Logging</h3>
	            <div id="logging"></div>
	        </div>
	    </div>
	</article>
</div>
<jsp:include page="/resources/include/footer.jsp"/>