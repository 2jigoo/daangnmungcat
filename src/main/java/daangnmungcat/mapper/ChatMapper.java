package daangnmungcat.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import daangnmungcat.dto.Chat;
import daangnmungcat.dto.ChatMessage;

public interface ChatMapper {

	List<Chat> selectAllChatsByMemberId(String memberId);
	List<Chat> selectAllChatsBySaleId(@Param("saleId") int saleId);
	Chat selectChatByChatId(int chatId);
	Chat selectChatByMemberIdAndSaleId(@Param("memberId")String memberId, @Param("saleId") int saleId);
	int selectCountBySaleId(int saleId);
	
	int insertChat(Chat chat);
	int updateChatRead(@Param("id") int id, @Param("memberId") String memberId);
	int updateChatLatestDate(ChatMessage message);
	int deleteChat(Chat chat);
}
