package daangnmungcat.mapper;

import java.util.List;

import daangnmungcat.dto.Chat;

public interface ChatMapper {

	List<Chat> selectAllChatsByMemberId(String memberId);
	Chat selectChatByChatId(String chatId);
	
	int insertChat(Chat chat);
}
