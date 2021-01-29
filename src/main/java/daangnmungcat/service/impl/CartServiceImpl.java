package daangnmungcat.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import daangnmungcat.dto.Cart;
import daangnmungcat.dto.Member;
import daangnmungcat.mapper.CartMapper;
import daangnmungcat.service.CartService;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class CartServiceImpl implements CartService {

	@Autowired
	CartMapper cartMapper;
	
	@Override
	public List<Cart> getCart(String memberId) {
		List<Cart> list = cartMapper.selectCartByMemberId(memberId);
		
		if(!memberId.equals(list.get(0).getMember().getId())) {
			throw new RuntimeException();
		}
		
		list.forEach(cart -> log.info(cart.toString()));
		return list;
	}

	@Override
	public Cart getCartItem(int id, String memberId) {
		Cart cart = new Cart(id, new Member(memberId));
		Cart gotCart = cartMapper.selectCartItemById(cart.getId());
		
		// 조회를 원하는 회원과 불일치하면
		if(!memberId.equals(gotCart.getMember().getId())) {
			throw new RuntimeException();
		}
		
		log.info(gotCart.toString());
		return gotCart;
	}

	@Override
	public int addCartItem(Cart cart) {
		int res = cartMapper.insertCartItem(cart);
		return res;
	}

}
