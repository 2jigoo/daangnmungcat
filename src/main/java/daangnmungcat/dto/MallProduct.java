package daangnmungcat.dto;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
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
public class MallProduct {
	private int id;
	private MallCate dogCate;
	private MallCate catCate;
	private String name;
	private int price;
	private String content;
	private String saleYn;
	private int stock;
	private String image1;
	private String image2;
	private String image3;
	private String deliveryKind;
	private int deliveryCondition;
	private int deliveryPrice;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private LocalDateTime regdate;

	public MallProduct(int id) {
		this.id = id;
	}
	
}
