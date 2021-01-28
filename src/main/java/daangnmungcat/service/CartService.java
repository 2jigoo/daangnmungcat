package daangnmungcat.service;

import java.util.List;

import daangnmungcat.dto.Cart;

public interface CartService {

	List<Cart> getCart(String memberId);
	Cart getCartItem(int id, String memberId);
	
	int addCartItem(Cart cart);
}
