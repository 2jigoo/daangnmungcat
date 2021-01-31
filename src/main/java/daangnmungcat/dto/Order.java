package daangnmungcat.dto;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

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
public class Order {
	private int id; 
	private Member member;
	private List<OrderDetail> details;
	private int zipcode;
	private String address1;
	private String address2;
	private String addPhone; 
	private String addMemo;
	private int totalPrice;
	private int usedMileage;
	private int finalPrice;
	private int plusMileage;
	private int deliveryPrice;
	private int addDeliveryPrice;
	private int cancelPrice;
	private int returnPrice;
	private int payId;
	private LocalDateTime payDate;
	private String state;
	
}
