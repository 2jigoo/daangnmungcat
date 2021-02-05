package daangnmungcat.mapper;

import java.util.List;

import daangnmungcat.dto.Cart;

public interface CartMapper {

	List<Cart> selectCartByMemberId(String memberId);
	List<Cart> selectCartByBasketId(String basketId);
	Cart selectCartItem(Cart cart);
	
	int insertCartItem(Cart cart);
	int updateCartItem(Cart cart);
	int deleteCartItem(Cart cart);
	
}
