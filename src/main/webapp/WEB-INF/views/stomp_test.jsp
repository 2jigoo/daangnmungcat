<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>STMOP TEST</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script> <!-- jquery, sockjs 등 webjar로 올릴 수도 있다 -->
<script>
	var sock = new SockJS("/stompTest");
	var client = Stomp.over(sock);
	
	client.connect({}, function() {
		console.log("Connected stompTest!");
		// Controller's MessageMapping, header, message(자유형식)
		client.send("/TTT", {}, "msg: Haha~");
		
		// 해당 토픽을 구독한다;
		client.subscribe("/topic/message", function(event) {
			console.log("!!!!!!!!! event >> " + event);
		});
	});
</script>
</head>
<body>

</body>
</html>