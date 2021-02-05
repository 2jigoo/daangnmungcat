package daangnmungcat.service;

import java.util.List;

import daangnmungcat.dto.Cart;

public interface CartService {

	List<Cart> getCart(String memberId);
	List<Cart> getCartForNonmember(String basketId);
	Cart getCartItem(int id);
	Cart getCartItem(String memberId, int productId);
	
	int addCartItem(Cart cart);
	int moveToMember(String basketId, String memberId);
	int modifyQuantity(Cart cart);
	int deleteCartItem(Cart cart);
}
