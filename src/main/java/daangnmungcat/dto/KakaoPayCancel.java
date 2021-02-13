package daangnmungcat.dto;

import java.util.Date;

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
@Data
public class KakaoPayCancel {
	private String cid, cid_secret, tid;
	private Integer cancel_amount, cancel_tax_free_amount, cancel_vat_amount, cancel_available_amount;
	private String payload;
}
