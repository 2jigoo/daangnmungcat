package daangnmungcat.dto.kakao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

import daangnmungcat.dto.PaymentActionDetails;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
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
@Data
public class KakaoPayApprovalVO {
    //response
    private String aid, tid, cid, sid ;
    private String partner_order_id, partner_user_id, payment_method_type, status;
    private AmountVO amount;
    private CardVO card_info;
    private String item_name, item_code, payload;
    private Integer quantity, tax_free_amount, vat_amount;
    private Date created_at, approved_at, canceled_at;
    private CanceledAmount canceled_amount;
    private CanceledAvailableAmount cancel_available_amount;
    private List<PaymentActionDetails> payment_action_details;
   
    public KakaoPayApprovalVO(String tid) {
		this.tid = tid;
	}
	
    
    
    

}