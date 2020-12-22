package daangnmungcat.mapper;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.junit.After;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import daangnmungcat.config.ContextRoot;
import daangnmungcat.dto.Chat;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.Sale;
import org.junit.Assert;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {ContextRoot.class} )
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class ChatMapperTest {

	private static final Log log = LogFactory.getLog(ChatMapperTest.class);
	
	@Autowired
	private ChatMapper mapper;
	
	@After
	public void tearDown() throws Exception {
		System.out.println();
	}
	
	@Test
	public void insertChat() {
		Sale sale = new Sale();
		sale.setId(1);
		
		Member seller = new Member();
		seller.setId("chatuser1");
		sale.setMember(seller);
		
		Member buyer = new Member();
		buyer.setId("chatuser2");
		
		Chat chat = new Chat();
		chat.setSale(sale);;
		chat.setBuyer(buyer);
		
		int res = mapper.insertChat(chat);
		Assert.assertEquals(1, res);
		
		log.debug("Chat: " + chat);
		log.debug("res: " + res);
	}

}
