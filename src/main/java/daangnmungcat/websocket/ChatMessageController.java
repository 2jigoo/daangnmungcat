package daangnmungcat.websocket;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Controller;

import daangnmungcat.dto.Chat;
import daangnmungcat.dto.ChatMessage;
import daangnmungcat.service.ChatService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class ChatMessageController {
	
	private static final Log log = LogFactory.getLog(ChatMessageController.class);
	
	private final SimpMessageSendingOperations messagingTemplate;
	
	@Autowired
	private ChatService chatService;
	
	@MessageMapping("/chat/{id}.sendMessage")
    @SendTo("/topic/chat/{id}")
    public ChatMessage sendMessage(@DestinationVariable int id, @Payload ChatMessage chatMessage) {
		chatMessage.setReadYn("n");
//		chatMessage.setRegdate(LocalDateTime.now());
		
		int res = chatService.sendMessage(chatMessage.getChat(), chatMessage);
		System.out.println("결과: " + res);
		
        return chatMessage;
    }

    /*@MessageMapping("/chat/{id}.addUser")
    @SendTo("/topic/chat/{id}")
    public ChatMessage addUser(@DestinationVariable int id, @Payload ChatMessage chatMessage, SimpMessageHeaderAccessor headerAccessor){
        headerAccessor.getSessionAttributes().put("username", chatMessage.getMember().getId());
        return chatMessage;
    }*/

    @MessageMapping("/chat/{id}.read")
    @SendTo("/topic/chat/{id}")
    public String readMessage(@DestinationVariable int id, @Payload String memberId) {
    	String otherPerson = "{\"id\":\"" + chatService.readChat(id, memberId) + "\"}";
    	return otherPerson;
    }
}
