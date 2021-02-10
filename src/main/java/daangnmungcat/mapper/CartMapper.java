package daangnmungcat.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import daangnmungcat.dto.Cart;
import daangnmungcat.dto.MallProduct;

public interface CartMapper {

	List<Cart> selectCartByMemberId(String memberId);
	List<Cart> selectCartByBasketId(String basketId);
	Cart selectCartItem(Cart cart);
	
	int insertCartItem(Cart cart);
	int updateCartItemFromBasektIdToMember(@Param("id")List<Integer> id, @Param("memberId")String memberId);
	int updateQuantityFromBasektIdToMember(@Param("basketId")String basketId, @Param("memberId")String memberId);
	int updateCartItem(Cart cart);
	int deleteCartItem(Cart cart);
	int deleteBasketId(@Param("basketId") String basketId);
	int deleteCartItems(@Param("memberId") String memberId, @Param("pdtList") List<MallProduct> pdtList);
	
}
