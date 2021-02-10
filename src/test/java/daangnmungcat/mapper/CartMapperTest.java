package daangnmungcat.mapper;

import java.util.List;
import java.util.stream.Collectors;

import org.junit.After;
import org.junit.Assert;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

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
	
//	@Test
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
	
	@Test
	@Transactional
	public void D_비회원_장바구니_회원_장바구니로_옮기기() {
		log.debug(">> " + Thread.currentThread().getStackTrace()[1].getMethodName());
		
		// given
		String basketId = "dc2e9747-878b-4631-8994-51ddcf7f6710";
		String memberId = "chattest1";
		
		// when
		List<Cart> basketList = cartMapper.selectCartByBasketId(basketId);
		List<Cart> memberList = cartMapper.selectCartByMemberId(memberId);
		
		// then
		// memberId에 없는 거 -> 그대로 update set member_id = '' basket_id = null where id = ''
		List<Integer> dontExistIds = basketList.stream()
					.filter(c -> memberList.stream().noneMatch(m -> m.getProduct().getId() == c.getProduct().getId()))
					.map(Cart::getId).collect(Collectors.toList());
		
		// memberId에 있는 거 -> 수량 업데이트 해주고 delete where basket_id = ''
		List<Integer> existProductId = basketList.stream()
				.filter(c -> memberList.stream().noneMatch(m -> m.getProduct().getId() != c.getProduct().getId()))
				.map(Cart::getProduct).map(MallProduct::getId).collect(Collectors.toList());
		
		cartMapper.updateCartItemFromBasektIdToMember(dontExistIds, memberId);
		cartMapper.updateQuantityFromBasektIdToMember(basketId, memberId);
		cartMapper.deleteBasketId(basketId);
		
		cartMapper.selectCartByMemberId(memberId).forEach(System.out::println);
	}
	
}
