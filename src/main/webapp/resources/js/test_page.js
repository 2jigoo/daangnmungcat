var usernamePage = document.querySelector('#username-page');
var chatPage = document.querySelector('#chat-page');
var usernameForm = document.querySelector('#usernameForm');
var messageForm = document.querySelector('#messageForm');
var messageInput = document.querySelector('#message');
var messageArea = document.querySelector('#messageArea');
var connectingElement = document.querySelector('.connecting');

var stompClient = null;

var colors = [
    '#2196F3', '#32c787', '#00BCD4', '#ff5652',
    '#ffc107', '#ff85af', '#FF9800', '#39bbb0'
];

function connect() {
    // username = document.querySelector('#name').value.trim();
	
    var socket = new SockJS('/daangnmungcat/ws');
    stompClient = Stomp.over(socket);

    stompClient.connect({}, onConnected, onError);
}


function onConnected() {
    // Subscribe to the Public Topic
    stompClient.subscribe('/topic/chat/' + chatId, onMessageReceived);
	readChat();
    // Tell your username to the server
    /*
    stompClient.send('/app/chat/' + chatId + '.addUser',
    	{},
        JSON.stringify({sender: username, type: 'JOIN'})
    )
    */
    console.log('연결됨');
    connectingElement.classList.add('hidden');
}

function connect_for_new() {
	var socket = new SockJS('/daangnmungcat/ws');
	stompClient = Stomp.over(socket);
	
	stompClient.connect({}, onConnected_for_new(), onError);
}


function onConnected_for_new() {
	console.log('연결됨');
	connectingElement.classList.add('hidden');
}

function subscribe_for_new() {
	stompClient.subscribe('/topic/chat/' + chatId, onMessageReceived);
	readChat();
}


function onError(error) {
    connectingElement.textContent = 'Could not connect to WebSocket server. Please refresh this page to try again!';
    connectingElement.style.color = 'red';
}


function sendMessage(event) {
	event.preventDefault();
	
    var messageContent = messageInput.value.trim();
    var chatMessage = {
            chat: {id: chatId},
            member: {id: memberId, nickname: memberNickname},
            content: messageInput.value,
            regdate: dayjs().format("YYYY-MM-DD hh:mm:ss")
        };
    
    if ($('#customFile').val() != "") {
    	var form = $('#messageForm')[0];
    	var form_data = new FormData(form);
    	
    	sendImage(form_data, chatMessage); // 텍스트랑 사진 같이 보냈을 때
    	return;
    }
    
    sendChatMessage(chatMessage); // 텍스트만 보냈을 때
}

function sendImage(form_data, chatMessage) {
	$.ajax({
		type: 'post',
		enctype: 'multipart/form-data',
		url: contextPath + '/chat/' + chatId + '/upload',
		data: form_data,
		processData: false,
		contentType: false,
		cache: false,
		timeout: 600000,
		success: function(data) {
			chatMessage.image = data;
			console.log(chatMessage);
			sendChatMessage(chatMessage);
		},
		error: function(error) {
			console.log(error);
		}
		
	})
}

function sendChatMessage(chatMessage) {
	if(messageContent && stompClient) {
        stompClient.send('/app/chat/' + chatId + '.sendMessage', {}, JSON.stringify(chatMessage));
        messageInput.value = '';
    }
}

function readChat() {
	if(stompClient) {
		stompClient.send('/app/chat/' + chatId + '.read', {}, memberId);
	}
}

function onMessageReceived(payload) {
	var msg = JSON.parse(payload.body);
	
	if(msg.chat === undefined) {
		if(msg.id != memberId) {
			$('.read_yn').attr('read_yn', 'y');
			$('.read_yn').text('읽음 ');    	
		}
		return;
	}
	

    /*
    if(message.type === 'JOIN') {
        messageElement.classList.add('event-message');
        message.content = message.sender + ' joined!';
    } else if (message.type === 'LEAVE') {
        messageElement.classList.add('event-message');
        message.content = message.sender + ' left!';
    } else { */
    
    /*
    var messageElement = document.createElement('li');
    
    messageElement.classList.add('chat-message');

    var avatarElement = document.createElement('i');
    var avatarText = document.createTextNode(message.member.nickname[0]);
    avatarElement.appendChild(avatarText);
    avatarElement.style['background-color'] = getAvatarColor(message.member.nickname);

    messageElement.appendChild(avatarElement);

    var usernameElement = document.createElement('span');
    var usernameText = document.createTextNode(message.member.nickname);
    usernameElement.appendChild(usernameText);
    messageElement.appendChild(usernameElement);
    // }

    var textElement = document.createElement('p');
    var messageText = document.createTextNode(message.content);
    textElement.appendChild(messageText);
    
    var regdateElement = document.createTextNode(message.readYn + " " + message.regdate);
    textElement.appendChild(regdateElement);
    
    messageElement.appendChild(textElement);
*/
    var li_str = "";
    
    if (msg.member.id == memberId) {
		// 나
		li_str += "<li class='chat-message me' msg_id='" + msg.id + "' sender='" + msg.member.id + "'>";
		li_str += "<div class='chat-message me bubble'><p>";
		if(msg.content != null) {
			li_str += msg.content;
		} else {
			li_str += "<img src='" + contextPath + "/" + msg.image + "'>";
		}
		li_str += "</p><span class='read_yn' read_yn='" + msg.readYn + "'>";
		li_str += (msg.readYn == 'y' ? "읽음" : "읽지 않음") + "</span>";
		li_str += "<span class='regdate' regdate='" + msg.regdate + "'>" + dayjs(msg.regdate).format("YYYY년 M월 D일 h:mm") + "</span></div></li>";
	} else {
		// 너
		li_str += "<li class='chat-message you' msg_id='" + msg.id + "' sender='" + msg.member.id +"'>";
		li_str += "<div class='chat-message you profile_img'>";
		li_str += "<a href='" + contextPath + "/member/profile?id=" + msg.member.id + "'>";
		li_str += "<img alt='개인프로필' src='" + contextPath + "/resources/" + msg.member.profilePic + "'>";
		li_str += "</a></div>";
		li_str += "<div class='chat-message you bubble'><span class='nickname'>" + msg.member.nickname + "</span>";
		if(msg.content != null) {
			li_str += msg.content;
		} else {
			li_str += "<img src='" + contextPath + "/" + msg.image + "'>";
		}
		li_str += "</p>";
		li_str += "<span class='regdate' regdate='" + msg.regdate + "'>" + dayjs(msg.regdate).format("YYYY년 M월 D일 h:mm") + "</span></div></li>";
	}
    
    //messageArea.append(li_str);
    $("#messageArea").append(li_str);
    messageArea.scrollTop = messageArea.scrollHeight;
    
    readChat();
}


function getAvatarColor(messageSender) {
    var hash = 0;
    for (var i = 0; i < messageSender.length; i++) {
        hash = 31 * hash + messageSender.charCodeAt(i);
    }
    var index = Math.abs(hash % colors.length);
    return colors[index];
}