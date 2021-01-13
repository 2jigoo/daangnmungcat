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


function onError(error) {
    connectingElement.textContent = 'Could not connect to WebSocket server. Please refresh this page to try again!';
    connectingElement.style.color = 'red';
}


function sendMessage(event) {
    var messageContent = messageInput.value.trim();
    if(messageContent && stompClient) {
        var chatMessage = {
            chat: {id: chatId},
            member: {id: memberId, nickname: memberNickname},
            content: messageInput.value
        };
        stompClient.send('/app/chat/' + chatId + '.sendMessage', {}, JSON.stringify(chatMessage));
        messageInput.value = '';
    }
    event.preventDefault();
}


function onMessageReceived(payload) {
    var message = JSON.parse(payload.body);
    console.log(message);
    
    var messageElement = document.createElement('li');

    /*
    if(message.type === 'JOIN') {
        messageElement.classList.add('event-message');
        message.content = message.sender + ' joined!';
    } else if (message.type === 'LEAVE') {
        messageElement.classList.add('event-message');
        message.content = message.sender + ' left!';
    } else { */
    messageElement.classList.add('chat-message');

    var avatarElement = document.createElement('i');
//    var avatarText = document.createTextNode(message.member.nickname[0]);
    var avatarText = document.createTextNode(message.member.id[0]);
    avatarElement.appendChild(avatarText);
//    avatarElement.style['background-color'] = getAvatarColor(message.member.nickname);
    avatarElement.style['background-color'] = getAvatarColor(message.member.id);

    messageElement.appendChild(avatarElement);

    var usernameElement = document.createElement('span');
//    var usernameText = document.createTextNode(message.member.nickname);
    var usernameText = document.createTextNode(message.member.id);
    usernameElement.appendChild(usernameText);
    messageElement.appendChild(usernameElement);
    // }

    var textElement = document.createElement('p');
    var messageText = document.createTextNode(message.content);
    textElement.appendChild(messageText);

    messageElement.appendChild(textElement);

    messageArea.appendChild(messageElement);
    messageArea.scrollTop = messageArea.scrollHeight;
}


function getAvatarColor(messageSender) {
    var hash = 0;
    for (var i = 0; i < messageSender.length; i++) {
        hash = 31 * hash + messageSender.charCodeAt(i);
    }
    var index = Math.abs(hash % colors.length);
    return colors[index];
}

connect();
messageForm.addEventListener('submit', sendMessage, true);