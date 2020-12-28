package daangnmungcat.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import daangnmungcat.dto.Chat;
import daangnmungcat.dto.ChatMessage;
import daangnmungcat.mapper.ChatMapper;
import daangnmungcat.mapper.ChatMessageMapper;
import daangnmungcat.service.ChatService;

@Service
public class ChatServiceImpl implements ChatService {

	@Autowired
	private ChatMapper chatMapper;
	
	@Autowired
	private ChatMessageMapper messageMapper;
	
	// 내 채팅목록 얻어오기
	@Override
	public List<Chat> getMyChatsList(String memberId) {
		List<Chat> myChatList = chatMapper.selectAllChatsByMemberId(memberId);
		for(Chat chat : myChatList) {
			chat.setLatestDate(messageMapper.selectLatestChatMessageByChatId(chat.getId()).getRegdate());
		}
		return myChatList;
	}
	
	// 채팅 하나 정보 읽어오기
	@Override
	public Chat getChat(int chatId) {
		Chat chat = chatMapper.selectChatByChatId(chatId);
		return chat;
	}
	
	// 새 채팅 만들기
	@Override
	public int createNewChat(Chat chat, ChatMessage message) {
		int res = chatMapper.insertChat(chat);
		res += messageMapper.insertChatMessage(message);
		return res;
	}
	
	// 메시지 보내기
	@Override
	public int sendMessage(Chat chat, ChatMessage message) {
		int res = 0;
		if(chat.getId() == 0) {
			res = chatMapper.insertChat(chat);
		}
		res += messageMapper.insertChatMessage(message);
		
		return res;
	}

	// 메시지 하나 지우기
	@Override
	public int deleteMessage(ChatMessage message) {
		int res = messageMapper.deleteChatMessageByChatMessageId(message);
		return res;
	}

	// 채팅 하나 지우기 (on delete cascade)
	@Override
	public int deleteChat(Chat chat) {
		int res = chatMapper.deleteChat(chat);
		
		if(res != 1) {
			
		}
		
		return res;
	}
}
