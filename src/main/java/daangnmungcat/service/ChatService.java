package daangnmungcat.service;

import java.io.File;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import daangnmungcat.dto.Chat;
import daangnmungcat.dto.ChatMessage;
import daangnmungcat.dto.Criteria;

public interface ChatService {

	List<Chat> getMyChatsList(String memberId, Criteria cri);
	int countMyChatsList(String memberId);
	
	List<Chat> getMyChatsList(int saleId, Criteria cri);
	int countMyChatsList(int saleId);
	
	List<Chat> getMyChatsListOnSale(String memberId, int saleId, Criteria cri);
	int countsMyChatsOnSale(String memberId, int saleId);
	
	Chat getChatInfo(int chatId);
	int getChatCounts(int saleId);
	
	Chat getChatWithMessages(int chatId);
	Chat getChatWithMessages(int chatId, Criteria criteria);
	
	List<ChatMessage> getChatMessages(int chatId);
	List<ChatMessage> getChatMessages(int chatId, Criteria criteria);
	
	int createNewChat(Chat chat);
	int sendMessage(Chat chat, ChatMessage message);
	String uploadImageMessage(ChatMessage message, MultipartFile file, File realPath);
	
	String readChat(int chat, String memberId);
	int readChatMessage(int message, String memberId);
	
	int deleteMessage(ChatMessage... message);
	int deleteChat(Chat chat);
	
	// 메시지 읽음 처리

}
