package daangnmungcat.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import daangnmungcat.dto.Chat;
import daangnmungcat.dto.ChatMessage;

public interface ChatMessageMapper {

	List<ChatMessage> selectAllChatMessageByChatId(int chatId);
	List<ChatMessage> selectChatMessagesByChatIdWithPaging(Map<String, Object> pageMaker);
	ChatMessage selectLatestChatMessageByChatId(int chatId);
	
	int selectCountChatMessageByChatId(Chat chat);
	
	int insertChatMessage(ChatMessage message);
	
	int updateChatMessageRead(@Param("id") int id, @Param("memberId") String memberId);
	
	int deleteChatMessageByChatMessageId(ChatMessage message);
	int deleteChatMessagesByChatId(Chat chat);
}
