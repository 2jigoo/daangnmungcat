package daangnmungcat.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import daangnmungcat.dto.Chat;
import daangnmungcat.dto.ChatMessage;
import daangnmungcat.mapper.ChatMapper;
import daangnmungcat.mapper.ChatMessageMapper;
import daangnmungcat.service.ChatService;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class ChatServiceImpl implements ChatService {

	@Autowired
	private ChatMapper chatMapper;
	
	@Autowired
	private ChatMessageMapper messageMapper;
	
	// 내 채팅목록 얻어오기
	@Override
	public List<Chat> getMyChatsList(String memberId) {
		List<Chat> myChatList = chatMapper.selectAllChatsByMemberId(memberId);
		
		// 채팅목록에 가장 최근 메시지 띄우기
		for(Chat chat : myChatList) {
			ChatMessage msg = messageMapper.selectLatestChatMessageByChatId(chat.getId());
			
			ArrayList<ChatMessage> msgList = new ArrayList<ChatMessage>();
			msgList.add(msg);
			
			chat.setLatestDate(msg.getRegdate());
			chat.setMessages(msgList);
		}
		
		return myChatList;
	}
	
	
	// 채팅 하나 정보 읽어오기
	@Override
	public Chat getChatInfo(int chatId) {
		Chat chat = chatMapper.selectChatByChatId(chatId);
		return chat;
	}
	
	// 채팅 얻어오면서 메시지 리스트 set 하기
	@Override
	public Chat getChatWithMessages(int chatId) {
		Chat chat = chatMapper.selectChatByChatId(chatId);
		chat.setMessages(messageMapper.selectAllChatMessageByChatId(chatId));
		return chat;
	}
	
	
	// 메시지들 읽어오기
	@Override
	public List<ChatMessage> getChatMessages(int chatId) {
		List<ChatMessage> msgList = messageMapper.selectAllChatMessageByChatId(chatId);
		return msgList;
	}
	
	
	// 새 채팅 만들기
	@Override
	@Transactional
	public int createNewChat(Chat chat, ChatMessage message) {
		int res = chatMapper.insertChat(chat);
		res += messageMapper.insertChatMessage(message);
		
		if (res != 2) {
			throw new RuntimeException();
		}
		
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

	
	// 채팅창에서 선택한 메시지 지우기
	@Override
	@Transactional
	public int deleteMessage(ChatMessage... message) {
		int count = 0;
		for(ChatMessage msg : message) {
			int res = messageMapper.deleteChatMessageByChatMessageId(msg);
			if(res == 0) {
				throw new RuntimeException();
			}
		}
		return count; // 삭제한 총 갯수
	}

	
	// 채팅 하나 지우기 (on delete cascade)
	@Override
	public int deleteChat(Chat chat) {
		int res = chatMapper.deleteChat(chat);
		
		if(res != 1) {
			throw new RuntimeException();
		}
		
		return res;
	}
	
	
}
