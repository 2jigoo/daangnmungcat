package daangnmungcat.controller;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Controller;

import daangnmungcat.dto.ChatMessage;
import daangnmungcat.dto.ChatMessageForTest;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class ChatMessageController {
	
	private static final Log log = LogFactory.getLog(ChatMessageController.class);
	
	private final SimpMessageSendingOperations messagingTemplate;
	
	/*
	@MessageMapping("/sendMessage")
	@SendTo("/sub/chats/message")
	public String message(@Payload ChatMessage message) {
		System.out.println(message);
		log.debug("message(): " + message);
	//		messagingTemplate.convertAndSend("/sub/chat/" + message.getChat().getId(), message);
		return message.getChat().getId() + "방에 전송했음";
	}
	*/
	
	@MessageMapping("/chat.sendMessage")
    @SendTo("/topic/public")
    public ChatMessageForTest sendMessage(@Payload ChatMessageForTest chatMessage) {
        return chatMessage;
    }

    @MessageMapping("/chat.addUser")
    @SendTo("/topic/public")
    public ChatMessageForTest addUser(@Payload ChatMessageForTest chatMessage, SimpMessageHeaderAccessor headerAccessor){
        headerAccessor.getSessionAttributes().put("username", chatMessage.getSender());
        return chatMessage;
    }
}
