package daangnmungcat.dto;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@JsonInclude(Include.NON_DEFAULT)
public class Cart {

	private int id;
	private Member member;
	private MallProduct product;
	private int quantity;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private LocalDateTime regdate;
	
	// 해당 상품 * 수량 = 금액(amount)
	private int amount;
	
	
	public Cart(int id) {
		this.id = id;
	}
	
	public Cart(Member member, MallProduct product) {
		this.member = member;
		this.product = product;
	}
	public Cart(int id, Member member, MallProduct product, int quantity) {
		this.id = id;
		this.member = member;
		this.product = product;
		this.quantity = quantity;
	}

}
