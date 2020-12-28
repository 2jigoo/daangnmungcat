package daangnmungcat.service;

import java.util.List;

import daangnmungcat.dto.Chat;
import daangnmungcat.dto.ChatMessage;

public interface ChatService {

	List<Chat> getMyChatsList(String memberId);
	Chat getChat(int chatId);
	
	int createNewChat(Chat chat, ChatMessage message);
	int sendMessage(Chat chat, ChatMessage message);
	
	int deleteMessage(ChatMessage message);
	int deleteChat(Chat chat);

}
