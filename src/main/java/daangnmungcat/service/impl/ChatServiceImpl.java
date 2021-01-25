package daangnmungcat.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import daangnmungcat.dto.Chat;
import daangnmungcat.dto.ChatMessage;
import daangnmungcat.dto.Criteria;
import daangnmungcat.mapper.ChatMapper;
import daangnmungcat.mapper.ChatMessageMapper;
import daangnmungcat.service.ChatService;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class ChatServiceImpl implements ChatService {

	private static final String UPLOAD_PATH = "resources" + File.separator + "upload" + File.separator + "chat";
	
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
			
			try {
				chat.setLatestDate(msg.getRegdate());
			} catch (NullPointerException e) {
				
			}
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
	
	@Override
	public Chat getChatWithMessages(int chatId, Criteria criteria) {
		Chat chat = chatMapper.selectChatByChatId(chatId);
		chat.setMessages(getChatMessages(chatId, criteria));
		return chat;
	}
	
	
	// 메시지들 읽어오기
	@Override
	public List<ChatMessage> getChatMessages(int chatId) {
		List<ChatMessage> msgList = messageMapper.selectAllChatMessageByChatId(chatId);
		return msgList;
	}
	
	@Override
	public List<ChatMessage> getChatMessages(int chatId, Criteria criteria) {
		Map<String, Object> params = new HashMap<>();
		params.put("chatId", chatId);
		params.put("criteria", criteria);
		List<ChatMessage> msgList = messageMapper.selectChatMessagesByChatIdWithPaging(params);
		return msgList;
	}
	
	
	// 새 채팅 만들기
	@Override
	public int createNewChat(Chat chat) {
		int res = chatMapper.insertChat(chat);
		
		if (res != 1) {
			throw new RuntimeException();
		}
		
		return chat.getId();
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

	
	@Override
	public String readChat(int id, String memberId) {
		chatMapper.updateChatRead(id, memberId);
		
		Chat chat = chatMapper.selectChatByChatId(id);
		return memberId;
	}
	
	
	@Override
	public int readChatMessage(int id, String memberId) {
		int res = messageMapper.updateChatMessageRead(id, memberId);
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


	// 해당 판매글에 member가 참여한 채팅 정보 조회
	@Override
	public Chat getChatInfoFromSale(String memberId, int saleId) {
		Chat chat = chatMapper.selectChatByMemberIdAndSaleId(memberId, saleId);
		return chat;
	}


	// 이미지 첨부한 채팅 메시지 보내기
	@Override
	public String uploadImageMessage(ChatMessage message, MultipartFile file, HttpSession session) {
		
		String path = UPLOAD_PATH + File.separator + message.getChat().getId();
		
		/* 업로드할 폴더 지정. 폴더가 없는 경우 생성 */
		File dir = new File(session.getServletContext().getRealPath(path)); 
		
		if(!dir.exists()) {
			dir.mkdirs();
		}
		
		// 원본 파일명 자체를 수정하고 싶을 때 사용하기
//		String originName = file.getOriginalFilename();
//		int idx = originName.lastIndexOf(".");
//		String ext = originName.substring(idx);
		
		String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
		File saveFile = new File(dir, fileName); // 위에서 지정한 폴더에 fileName 이름으로 저장
		
		try {
			file.transferTo(saveFile);
		} catch(Exception e) {
			log.error(e.getMessage());
		}
		
		return fileName;
	}
	
	
}
