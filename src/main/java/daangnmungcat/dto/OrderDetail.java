package daangnmungcat.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
@ToString
public class OrderDetail {
	private int id;
	private int orderId; 
	private Member member;
	private Cart cart; // 상품id, 수량, 가격
	private int totalPrice;
	
	public OrderDetail(Cart cart) {
		this.cart = cart;
	}
	
	
}


