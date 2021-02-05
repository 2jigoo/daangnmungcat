package daangnmungcat.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import daangnmungcat.dto.Cart;
import daangnmungcat.dto.MallProduct;
import daangnmungcat.dto.Member;
import daangnmungcat.mapper.CartMapper;
import daangnmungcat.service.CartService;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class CartServiceImpl implements CartService {

	@Autowired
	CartMapper cartMapper;
	
	
	// 해당 회원의 장바구니 목록 조회
	@Override
	public List<Cart> getCart(String memberId) {
		List<Cart> list = cartMapper.selectCartByMemberId(memberId);
		
		try {
		list.forEach(cart -> log.info(cart.toString()));
		} catch(IndexOutOfBoundsException e) {
			log.info("cart list is empty!");
		}
		
		return list;
	}
	
	
	@Override
	public List<Cart> getCartForNonmember(String basketId) {
		List<Cart> list = cartMapper.selectCartByBasketId(basketId);
		
		try {
			list.forEach(cart -> log.info(cart.toString()));
		} catch(IndexOutOfBoundsException e) {
			log.info("cart list is empty!");
		}
		
		return list;
	}
	

	// 본인 식별 가능: id / member.id & product.id
	// 해당 회원의 장바구니 상품 하나 조회
	@Override
	public Cart getCartItem(int id) {
		Cart cart = cartMapper.selectCartItem(new Cart(id));
		
		try {
			log.info(cart.toString());
		} catch(NullPointerException e) {
			log.info("cart item is null!");
		}
		return cart;
	}
	
	@Override
	public Cart getCartItem(String memberId, int productId) {
		Cart cart = cartMapper.selectCartItem(new Cart(new Member(memberId), new MallProduct(productId)));
		
		try {
			log.info(cart.toString());
			// 조회를 원하는 회원과 불일치하면
			if(!memberId.equals(cart.getMember().getId())) {
				throw new RuntimeException();
			}
		} catch(NullPointerException e) {
			log.info("cart item is null!");
		}
		
		return cart;
	}

	@Override
	public int addCartItem(Cart cart) {
		Cart findCart = cartMapper.selectCartItem(cart);
		log.info("cart: " + cart.toString());
		
		int res = 0;
		
		if(findCart != null) {
			log.info("findCart: " + findCart.toString());
			cart.setId(findCart.getId());
			cart.setQuantity(findCart.getQuantity() + cart.getQuantity());
			res = cartMapper.updateCartItem(cart);
		} else {
			res = cartMapper.insertCartItem(cart);
		}
		return res;
	}
	
	
	@Override
	public int modifyQuantity(Cart cart) {
		int res = cartMapper.updateCartItem(cart);
		return res;
	}
	
	
	@Override
	public int deleteCartItem(Cart cart) {
		int res = cartMapper.deleteCartItem(cart);
		return res;
	}

}
