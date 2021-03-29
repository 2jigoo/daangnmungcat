package daangnmungcat.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import daangnmungcat.dto.Chat;
import daangnmungcat.dto.ChatMessage;
import daangnmungcat.dto.Criteria;

public interface ChatMapper {

	List<Chat> selectAllChatsByMemberId(@Param("memberId") String memberId, @Param("cri") Criteria cri);
	int countAllChatsByMemberId(@Param("memberId") String memberId);
	
	List<Chat> selectAllChatsBySaleId(@Param("saleId") int saleId, @Param("cri") Criteria cri);
	int countAllChatsBySaleId(@Param("saleId") int saleId);
	
	List<Chat> selectChatByMemberIdAndSaleId(@Param("memberId")String memberId, @Param("saleId") int saleId, @Param("cri") Criteria cri);
	int countAllChatsByMemberIdAndSaleId(@Param("memberId")String memberId, @Param("saleId") int saleId);
	
	int selectCountBySaleId(int saleId);
	
	Chat selectChatByChatId(int chatId);
	
	int insertChat(Chat chat);
	int updateChatRead(@Param("id") int id, @Param("memberId") String memberId);
	int updateChatLatestDate(ChatMessage message);
	int deleteChat(Chat chat);
}
