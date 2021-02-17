package daangnmungcat.dto;

import lombok.Data;

@Data
public class PaymentActionDetails {
	private String aid, approved_at;
	private Integer amount, point_amount, discount_amount;
	private String payment_action_type, payload;
}
