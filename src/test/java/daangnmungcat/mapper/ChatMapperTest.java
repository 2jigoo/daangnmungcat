package daangnmungcat.mapper;

import java.util.List;

import org.junit.After;
import org.junit.Assert;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import daangnmungcat.config.ContextRoot;
import daangnmungcat.dto.Chat;
import daangnmungcat.dto.ChatMessage;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.Sale;
import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class)
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
@ContextConfiguration(classes = {ContextRoot.class} )
@Log4j2
//@Transactional
public class ChatMapperTest {

	@Autowired
	private ChatMapper cMapper;
	
	@Autowired
	private ChatMessageMapper cmMapper;
	
	// 테스트를 위해 insert한 chat 인스턴스. 테스트 후 롤백될 것임.
	private static Chat chat;
	private static Member chatUser1;
	private static Member chatUser2;
	private static ChatMessage message;
	
	@After
	public void tearDown() throws Exception {
		System.out.println();
	}
	
	@Test
	public void a_test_InsertChat() {
		log.debug(Thread.currentThread().getStackTrace()[1].getMethodName() + "()");
		log.debug("-- Chat 추가 테스트");
		
		Sale sale = new Sale();
		sale.setId(1);
		chatUser1 = new Member();
		chatUser1.setId("chattest1");
		sale.setMember(chatUser1);
		
		chatUser2 = new Member();
		chatUser2.setId("chattest2");
		
		chat = new Chat();
		chat.setSale(sale);;
		chat.setBuyer(chatUser2);
		
		int res = cMapper.insertChat(chat);
		Assert.assertEquals(1, res);
		
		log.debug("Chat: " + chat);
		log.debug("res: " + res);
	}
	
	
	@Test
	public void b_test_selectAllChatsByMemberId() {
		log.debug(Thread.currentThread().getStackTrace()[1].getMethodName() + "()");
		log.debug("-- 해당 유저의 채팅 리스트 가져오기");
		
		List<Chat> list = cMapper.selectAllChatsByMemberId("chattest1");
		Assert.assertNotNull(list);
		
		list.stream().forEach(chat -> log.debug(chat.toString()));
	}
	
	
	@Test
	public void c_test_selectChatByChatId() {
		log.debug(Thread.currentThread().getStackTrace()[1].getMethodName() + "()");
		log.debug("-- 채팅 id로 채팅 정보 가져오기");
		
		chat = cMapper.selectChatByChatId(chat.getId());
		Assert.assertNotNull(chat);
		
		log.debug("chat: " + chat);
	}
	
	
	// ChatMessage Test
	
	
	@Test
	public void d_test_insertChatMessageByChatId() {
		log.debug(Thread.currentThread().getStackTrace()[1].getMethodName() + "()");
		log.debug("-- ChatMessage 추가");
		
		message = new ChatMessage(0, chat, chatUser2, "안녕하세요~", null, null, "n");
		int res = cmMapper.insertChatMessage(message);
		Assert.assertEquals(1, res);
		log.debug("chatMessage: " + message.toString());
	}
	
	@Test
	public void e_test_seletAllChatMessageByChatId() {
		log.debug(Thread.currentThread().getStackTrace()[1].getMethodName() + "()");
		log.debug("-- 해당 Chat의 메시지들 가져오기");
		
		List<ChatMessage> messageList = cmMapper.selectAllChatMessageByChatId(chat.getId());
		Assert.assertNotNull(messageList);
		
		messageList.stream().forEach(message -> log.debug(message.toString()));
	}
	
	@Test
	public void f_test_deleteChatMessageByChatMessageId() {
		log.debug(Thread.currentThread().getStackTrace()[1].getMethodName() + "()");
		log.debug("-- ChatMessage 삭제");
		
		int res = cmMapper.deleteChatMessageByChatMessageId(message);
		Assert.assertEquals(1, res);
	}
	
//	@Test
	public void g_test_deleteChatMessageByChatId() {
		log.debug(Thread.currentThread().getStackTrace()[1].getMethodName() + "()");
		log.debug("-- 한 채팅의 모든 메시지를 삭제");
		
		int res = cmMapper.deleteChatMessagesByChatId(chat);
		Assert.assertEquals(1, res);
	}

	@Test
	public void h_test_deleteChatByChatId() {
		log.debug(Thread.currentThread().getStackTrace()[1].getMethodName() + "()");
		log.debug("-- 한 채팅 삭제. (메시지까지 cascade 되나?)");
		
		Chat chat = new Chat();
		chat.setId(1);
		int res = cMapper.deleteChat(chat);
		log.debug("res: " + res);
		
		Assert.assertEquals(1, res);
	}
}
