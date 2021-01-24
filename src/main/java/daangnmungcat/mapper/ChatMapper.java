package daangnmungcat.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import daangnmungcat.dto.Chat;

public interface ChatMapper {

	List<Chat> selectAllChatsByMemberId(String memberId);
	Chat selectChatByChatId(int chatId);
	Chat selectChatByMemberIdAndSaleId(@Param("memberId")String memberId, @Param("saleId") int saleId);
	
	int insertChat(Chat chat);
	int deleteChat(Chat chat);
}
