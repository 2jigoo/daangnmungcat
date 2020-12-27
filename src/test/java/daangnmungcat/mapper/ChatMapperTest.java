package daangnmungcat.mapper;

import java.util.List;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.junit.After;
import org.junit.Assert;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import daangnmungcat.config.ContextRoot;
import daangnmungcat.dto.Chat;
import daangnmungcat.dto.ChatMessage;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.Sale;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {ContextRoot.class} )
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
@Transactional
public class ChatMapperTest {

	private static final Log log = LogFactory.getLog(ChatMapperTest.class);
	
	@Autowired
	private ChatMapper cMapper;
	
	@Autowired
	private ChatMessageMapper cmMapper;
	
	@After
	public void tearDown() throws Exception {
		System.out.println();
	}
	
	@Test
	@Rollback(true)
	public void test01InsertChat() {
		log.debug(Thread.currentThread().getStackTrace()[1].getMethodName() + "()");
		Sale sale = new Sale();
		sale.setId(2);
		
		Member seller = new Member();
		seller.setId("chatuser1");
		sale.setMember(seller);
		
		Member buyer = new Member();
		buyer.setId("chatuser2");
		
		Chat chat = new Chat();
		chat.setSale(sale);;
		chat.setBuyer(buyer);
		
		int res = cMapper.insertChat(chat);
		Assert.assertEquals(1, res);
		
		log.debug("Chat: " + chat);
		log.debug("res: " + res);
	}
	
	@Test
	public void test02selectAllChatsByMemberId() {
		log.debug(Thread.currentThread().getStackTrace()[1].getMethodName() + "()");
		List<Chat> list = cMapper.selectAllChatsByMemberId("chatuser1");
		Assert.assertNotNull(list);
		
		list.stream().forEach(chat -> log.debug(chat.toString()));
	}
	
	@Test
	public void test03selectChatByChatId() {
		log.debug(Thread.currentThread().getStackTrace()[1].getMethodName() + "()");
		Chat chat = cMapper.selectChatByChatId("4");
		Assert.assertNotNull(chat);
		
		log.debug("chat: " + chat);
	}
	
	
	// ChatMessage Test
	
	@Test
	public void test04seletAllChatMessageByChatId() {
		log.debug(Thread.currentThread().getStackTrace()[1].getMethodName() + "()");
		List<ChatMessage> message = cmMapper.selectAllChatMessageByChatId(4);
		Assert.assertNotNull(message);
		
		log.debug("message: " + message);
	}
	
	@Test
	public void test05deleteChatMessageByChatMessageId() {
		log.debug(Thread.currentThread().getStackTrace()[1].getMethodName() + "()");
		
		ChatMessage cm = new ChatMessage();
		cm.setId(1);
		
		int res = cmMapper.deleteChatMessageByChatMessageId(cm);
		Assert.assertEquals(1, res);
	}
	
	@Test
	public void test06deleteChatMessageByChatId() {
		log.debug(Thread.currentThread().getStackTrace()[1].getMethodName() + "()");
		
		Chat chat = new Chat();
		chat.setId(4);
		
		int res = cmMapper.deleteChatMessagesByChatId(chat);
		Assert.assertEquals(1, res);
	}
	

}
