package daangnmungcat.mapper;

import java.util.List;

import daangnmungcat.dto.Cart;

public interface CartMapper {

	Cart selectCartItemById(int id);
	List<Cart> selectCartByMemberId(String memberId);
	
	int insertCartItem(Cart cart);
	int updateCartItem(Cart cart);
	int deleteCartItem(Cart cart);
	
}
