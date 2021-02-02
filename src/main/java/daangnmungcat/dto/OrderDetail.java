package daangnmungcat.dto;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

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
@JsonInclude(Include.NON_DEFAULT)
public class OrderDetail {
	private int id;
	private int orderId; 
	private Member member;
	private MallProduct pdt; // 상품 정보 
	private Cart cart; 
	private int totalPrice;
	
	public OrderDetail(Cart cart) {
		this.cart = cart;
	}
	
	
}


