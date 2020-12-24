package daangnmungcat.mapper;

import java.util.List;

import daangnmungcat.dto.ChatMessage;

public interface ChatMessageMapper {

	List<ChatMessage> selectAllChatMessageByChatId(int chatId);
	ChatMessage selectLatestChatMessageByChatId(int chatId);
	
	int insertChatMessage(ChatMessage message);
}
