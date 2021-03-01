package daangnmungcat.dto;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

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
public class Order {
	private String id; 
	private Member member;
	private List<OrderDetail> details;
	private String addName;
	private int zipcode;
	private String address1;
	private String address2;
	private String addPhone1; 
	private String addPhone2; 
	private String addMemo;
	private int totalPrice;
	private int usedMileage;
	private int finalPrice;
	private int plusMileage;
	private String settleCase;
	private LocalDateTime regDate;
	private int deliveryPrice;
	private String trackingNumber;
	private LocalDateTime shippingDate;
	private int addDeliveryPrice;
	private int returnPrice;
	private String payId;
	private LocalDateTime payDate;
	private String state;
	private int misu;
	private int ordercnt;

	
	public Order(String id) {
		this.id = id;
	}
}
