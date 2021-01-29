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
import daangnmungcat.dto.Cart;
import daangnmungcat.dto.MallProduct;
import daangnmungcat.dto.Member;
import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class)
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
@ContextConfiguration(classes = {ContextRoot.class} )
@Log4j2
public class CartMapperTest {
	
	@Autowired
	private CartMapper cartMapper;
	
	@After
	public void tearDown() throws Exception {
		System.out.println();
	}
	
	@Test
	public void A_한_회원의_장바구니_목록_들고오기() {
		log.debug(">> " + Thread.currentThread().getStackTrace()[1].getMethodName());
		
		// given
		String memberId = "chattest1";
		
		// when
		List<Cart> list = cartMapper.selectCartByMemberId(memberId);
		
		// then
		Assert.assertNotNull(list);
		list.forEach(cart -> log.info(cart.toString()));
	}
	
//	@Test
	public void C_아이템_하나_장바구니_담기() {
		log.debug(">> " + Thread.currentThread().getStackTrace()[1].getMethodName());
		
		// given
		Member member = new Member("chattest1");
		MallProduct product = new MallProduct(1);
		Cart cart = new Cart(0, member, product, 2);
		
		// when
		int res = cartMapper.insertCartItem(cart);
		
		// then
		Assert.assertEquals(1, res);
		log.info(cart.toString());
	}
	
}
