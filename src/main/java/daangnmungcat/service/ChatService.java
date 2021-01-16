package daangnmungcat.service;

import java.util.List;

import daangnmungcat.dto.Chat;
import daangnmungcat.dto.ChatMessage;
import daangnmungcat.dto.Criteria;

public interface ChatService {

	List<Chat> getMyChatsList(String memberId);
	Chat getChatInfo(int chatId);
	
	Chat getChatWithMessages(int chatId);
	Chat getChatWithMessages(int chatId, Criteria criteria);
	
	List<ChatMessage> getChatMessages(int chatId);
	List<ChatMessage> getChatMessages(int chatId, Criteria criteria);
	
	int createNewChat(Chat chat, ChatMessage message);
	int sendMessage(Chat chat, ChatMessage message);
	
	int deleteMessage(ChatMessage... message);
	int deleteChat(Chat chat);
	
	// 메시지 읽음 처리

}
